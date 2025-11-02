import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mera_bazaar/main_export.dart';
import 'package:mera_bazaar/src/core/exceptions/network_exception.dart';
import 'package:mera_bazaar/src/core/network/client/dio_client.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/data/models/auth/get_user_profile/get_user_profile_response.dart';
import 'package:mera_bazaar/src/data/models/auth/send_otp/send_otp_response.dart';
import 'package:mera_bazaar/src/data/models/auth/verify_otp/verify_otp_response.dart';
import 'package:mera_bazaar/src/data/source/remote/auth/auth_data_source.dart';
import 'package:mera_bazaar/src/domain/entities/auth/phone_auth_result.dart';

/// Implementation of the authentication data source.
///
/// This class implements the [AuthDataSource] interface and provides
/// concrete implementations for authentication-related API calls using Firebase
/// Authentication and Firestore. It handles:
/// - Sending OTP via Firebase Phone Authentication
/// - Verifying OTP using Firebase credentials
/// - Retrieving user profile from Firestore

/// A concrete implementation of the [AuthDataSource] interface.
///
/// This class uses Firebase Authentication for phone number verification and
/// Firestore for storing and retrieving user profiles. It handles the actual
/// API calls and converts the responses to appropriate data models.
class AuthDataSourceImpl extends AuthDataSource {
  /// The Dio client for making HTTP requests
  final DioClient dioClient;

  /// Creates a new instance of [AuthDataSourceImpl].
  ///
  /// Requires a [DioClient] to be provided for making HTTP requests.
  AuthDataSourceImpl({required this.dioClient});

  @override
  Future<DataState<User>> login(String email, String password) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return DataSuccess(data: response.user!);
    } on FirebaseAuthException catch (e) {
      return DataError(
        exception: MyBazaarException.fromException(e, message: e.code),
      );
    } catch (e) {
      return DataError(exception: MyBazaarException.fromException(e));
    }
  }

  @override
  /// Sends an OTP to the specified phone number using Firebase Phone Authentication.
  ///
  /// This method initiates the phone number verification process by calling
  /// Firebase's [verifyPhoneNumber] method. It handles various callbacks:
  /// - [verificationCompleted]: When the verification is completed automatically
  /// - [verificationFailed]: When the verification fails
  /// - [codeSent]: When the verification code is sent
  /// - [codeAutoRetrievalTimeout]: When the code auto-retrieval times out
  ///
  /// Returns a [SendOtpResponse] containing the result of the operation.
  ///
  /// [number] - The phone number to send the OTP to (without country code)
  Future<PhoneAuthResult> sendOtp(String number) async {
    final Completer<PhoneAuthResult> completer = Completer();
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91$number",
        verificationCompleted: (PhoneAuthCredential credential) async {
          if (completer.isCompleted) return;
          final UserCredential userCredential = await firebaseAuth
              .signInWithCredential(credential);
          completer.complete(
            PhoneAuthResult(
              success: true,
              user: userCredential.user,
              message: 'Verification Successfully Completed',
            ),
          );
        },
        verificationFailed: (FirebaseAuthException verificationFailed) async {
          if (completer.isCompleted) return;
          completer.complete(
            PhoneAuthResult(
              success: false,
              message: verificationFailed.message!,
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          if (completer.isCompleted) return;
          completer.complete(
            PhoneAuthResult(
              success: true,
              verificationId: verificationId,
              resendToken: resendToken,
              message:
                  "Verification code successfully sent to your register number.",
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (completer.isCompleted) return;
          completer.complete(
            PhoneAuthResult(
              success: false,
              verificationId: verificationId,
              message: "SMS code auto-retrieval timed out.",
            ),
          );
        },
      );
      return completer.future;
    } catch (e) {
      if (!completer.isCompleted) {
        completer.complete(
          PhoneAuthResult(success: false, message: e.toString()),
        );
      }
      return completer.future;
    }
  }

  @override
  /// Verifies an OTP using Firebase Phone Authentication.
  ///
  /// This method creates a [PhoneAuthCredential] using the provided verification ID
  /// and OTP code, then signs in the user using that credential.
  ///
  /// Returns a [VerifyOtpResponse] containing the result of the operation.
  ///
  /// [verificationId] - The ID of the verification process
  /// [otp] - The OTP code to verify
  Future<PhoneAuthResult> verifyOtp(
    String phone,
    String verificationId,
    String otp,
  ) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      final userCredential = await firebaseAuth.signInWithCredential(
        phoneAuthCredential,
      );

      if (!await isUserAlreadyExist(phone: userCredential.user?.phoneNumber)) {
        addUser(user: userCredential.user);
      }

      return PhoneAuthResult(
        success: true,
        message: "Successfully Authenticate User.",
        user: userCredential.user,
      );
    } on FirebaseAuthException catch (e) {
      return PhoneAuthResult(
        success: false,
        message: e.message ?? "Something went wrong!",
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  /// Retrieves the user profile from Firestore.
  ///
  /// This method queries the Firestore database to get the user's profile
  /// document using the provided token as the document ID.
  ///
  /// Returns a [GetUserProfileResponse] containing the user's profile data.
  ///
  /// [token] - The user's document ID in Firestore
  Future<GetUserProfileResponse> getUserProfile({required String token}) async {
    try {
      final response = await fireStore.collection("users").doc(token).get();
      return GetUserProfileResponse.fromJson(response.data()!);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> addUser({required User? user}) async {
    if (user == null) return;

    try {
      await fireStore.collection("users").add(user.toJson());
    } on FirebaseException catch (e) {
      debugPrint("Exception: ${e.message}");
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> isUserAlreadyExist({required String? phone}) async {
    final users = await fireStore
        .collection("users")
        .where("phoneNumber", isEqualTo: phone)
        .limit(1)
        .get();

    return users.docs.isNotEmpty;
  }
}

extension ToUserToJson on User {
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "uid": uid,
      "phoneNumber": phoneNumber,
      "displayName": displayName ?? "Guest",
      "email": email,
      "emailVerified": emailVerified,
      "photoURL": photoURL,
      "refreshToken": refreshToken,
      "tenantId": tenantId,
    };
  }
}
