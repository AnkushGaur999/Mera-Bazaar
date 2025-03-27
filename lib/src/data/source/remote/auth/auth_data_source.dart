import 'package:mera_bazaar/src/data/models/auth/send_otp/send_otp_response.dart';
import 'package:mera_bazaar/src/data/models/auth/verify_otp/verify_otp_response.dart';

abstract class AuthDataSource{

  Future<SendOtpResponse> sendOtp(String number);

  Future<VerifyOtpResponse> verifyOtp(String number, String otp);

}