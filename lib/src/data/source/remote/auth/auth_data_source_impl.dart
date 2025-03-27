import 'package:dio/dio.dart';
import 'package:mera_bazaar/src/core/network/client/dio_client.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/data/models/auth/send_otp/send_otp_response.dart';
import 'package:mera_bazaar/src/data/models/auth/verify_otp/verify_otp_response.dart';
import 'package:mera_bazaar/src/data/source/remote/auth/auth_data_source.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final DioClient dioClient;

  AuthDataSourceImpl({required this.dioClient});

  @override
  Future<SendOtpResponse> sendOtp(String number) async {
    try {
      final data = {"number": number};

      await Future.delayed(const Duration(seconds: 2));

      return SendOtpResponse(
          success: true, message: "OTP sent successfully", error: false);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<VerifyOtpResponse> verifyOtp(String number, String otp) async {
    try {
      final data = {"number": number};

      await Future.delayed(const Duration(seconds: 2));

      return VerifyOtpResponse(
          success: true, message: "OTP sent successfully", error: false);
    } catch (_) {
      rethrow;
    }
  }
}
