/// Implementation of the authentication data source.
///
/// This class implements the [AuthDataSource] interface and provides
/// concrete implementations for authentication-related API calls using Firebase
/// Authentication and Firestore. It handles:
/// - Sending OTP via Firebase Phone Authentication
/// - Verifying OTP using Firebase credentials
/// - Retrieving user profile from Firestore
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mera_bazaar/src/core/exceptions/network_exception.dart';
import 'package:mera_bazaar/src/core/network/client/dio_client.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/data/models/auth/get_user_profile/get_user_profile_response.dart';
import 'package:mera_bazaar/src/data/models/auth/send_otp/send_otp_response.dart';
import 'package:mera_bazaar/src/data/models/auth/verify_otp/verify_otp_response.dart';
import 'package:mera_bazaar/src/data/source/remote/auth/auth_data_source.dart';
import 'package:mera_bazaar/src/domain/entities/auth/phone_auth_result.dart';

/// A concrete implementation of the [AuthDataSource] interface.
///
/// This class uses Firebase Authentication for phone number verification and
/// Firestore for storing and retrieving user profiles. It handles the actual
/// API calls and converts the responses to appropriate data models.
class AuthDataSourceImpl extends AuthDataSource {
  /// The Dio client for making HTTP requests
  final DioClient dioClient;

  /// The Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// The Firestore instance for database operations
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  /// The Firebase Authentication instance
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Creates a new instance of [AuthDataSourceImpl].
  ///
  /// Requires a [DioClient] to be provided for making HTTP requests.
  AuthDataSourceImpl({required this.dioClient});

  @override
  Future<DataState<User>> login(String email, String password) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
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
    try {
      final Completer<PhoneAuthResult> completer = Completer();

      await _auth.verifyPhoneNumber(
        phoneNumber: "+91$number",
        verificationCompleted: (PhoneAuthCredential credential) async {
          final UserCredential userCredential = await _auth
              .signInWithCredential(credential);
          completer.complete(
            PhoneAuthResult(success: true, user: userCredential.user),
          );
        },
        verificationFailed: (FirebaseAuthException verificationFailed) async {
          completer.complete(
            PhoneAuthResult(
              success: false,
              message: verificationFailed.message,
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          completer.complete(
            PhoneAuthResult(
              success: true,
              verificationId: verificationId,
              resendToken: resendToken,
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          completer.complete(
            const PhoneAuthResult(
              success: false,
              message: "SMS code auto-retrieval timed out.",
            ),
          );
        },
      );
      return completer.future;
    } catch (_) {
      rethrow;
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
  Future<PhoneAuthResult> verifyOtp(String verificationId, String otp) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      final userCredential = await _auth.signInWithCredential(
        phoneAuthCredential,
      );

      return PhoneAuthResult(success: true, user: userCredential.user);
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
      final response = await _fireStore.collection("users").doc(token).get();
      return GetUserProfileResponse.fromJson(response.data()!);
    } catch (_) {
      rethrow;
    }
  }
}
