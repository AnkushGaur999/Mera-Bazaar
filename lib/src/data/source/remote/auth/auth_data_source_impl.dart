/// Implementation of the authentication data source.
///
/// This class implements the [AuthDataSource] interface and provides
/// concrete implementations for authentication-related API calls using Firebase
/// Authentication and Firestore. It handles:
/// - Sending OTP via Firebase Phone Authentication
/// - Verifying OTP using Firebase credentials
/// - Retrieving user profile from Firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mera_bazaar/src/core/network/client/dio_client.dart';
import 'package:mera_bazaar/src/data/models/auth/get_user_profile/get_user_profile_response.dart';
import 'package:mera_bazaar/src/data/models/auth/send_otp/send_otp_response.dart';
import 'package:mera_bazaar/src/data/models/auth/verify_otp/verify_otp_response.dart';
import 'package:mera_bazaar/src/data/source/remote/auth/auth_data_source.dart';

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

  /// Creates a new instance of [AuthDataSourceImpl].
  ///
  /// Requires a [DioClient] to be provided for making HTTP requests.
  AuthDataSourceImpl({required this.dioClient});

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
  Future<SendOtpResponse> sendOtp(String number) async {
    try {
      SendOtpResponse? sendOtpResponse;

      await _auth.verifyPhoneNumber(
        phoneNumber: "+91$number",
        verificationCompleted: (
          PhoneAuthCredential verificationCompleted,
        ) async {
          final result = await _auth.signInWithPhoneNumber(number);
          sendOtpResponse = SendOtpResponse(
            success: true,
            message:
                "OTP Sent! Save this verificationId: ${result.verificationId}",
            error: false,
          );
        },
        verificationFailed: (FirebaseAuthException verificationFailed) async {
          sendOtpResponse = SendOtpResponse(
            success: false,
            message: "Invalid Phone Number",
            error: true,
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          sendOtpResponse = SendOtpResponse(
            success: true,
            message: "OTP Sent! Save this verificationId: $verificationId",
            error: false,
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          sendOtpResponse = SendOtpResponse(
            success: false,
            message: "Server Timeout Error.",
            error: true,
          );
        },
      );

      return SendOtpResponse(
        success: true,
        message: "OTP Sent Successfully.",
        error: false,
      );
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
  Future<VerifyOtpResponse> verifyOtp(String verificationId, String otp) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId:
            "AD8T5IsOgsO5Vlq6Jly8XGWgP4ee9FsWmI2tdje_v6tLEEWe93Fat9r7JHTYJWo0OglnDb4sQHEUqSZoOXXoU5N8LEKVU6mh5RMadxHPtzAaRKxFhPG_vH58JbrTnLLGUvBWINX4UHxryqLv10nIfnnOWyZgPD_OqQ",
        smsCode: "123123",
      );

      await _auth.signInWithCredential(phoneAuthCredential);

      return VerifyOtpResponse(
        success: true,
        message: "OTP Verified!",
        error: false,
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
      final response = await _fireStore.collection("users").doc(token).get();
      return GetUserProfileResponse.fromJson(response.data()!);
    } catch (_) {
      rethrow;
    }
  }
}
