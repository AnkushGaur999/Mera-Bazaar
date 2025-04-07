import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mera_bazaar/src/core/network/client/dio_client.dart';
import 'package:mera_bazaar/src/data/models/auth/get_user_profile/get_user_profile_response.dart';
import 'package:mera_bazaar/src/data/models/auth/send_otp/send_otp_response.dart';
import 'package:mera_bazaar/src/data/models/auth/verify_otp/verify_otp_response.dart';
import 'package:mera_bazaar/src/data/source/remote/auth/auth_data_source.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final DioClient dioClient;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  AuthDataSourceImpl({required this.dioClient});

  @override
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
  Future<GetUserProfileResponse> getUserProfile({required String token}) async {
    try {
      final response = await _fireStore.collection("users").doc(token).get();
      return GetUserProfileResponse.fromJson(response.data()!);
    } catch (_) {
      rethrow;
    }
  }
}
