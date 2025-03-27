import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/send_otp_response_entity.dart';
import 'package:mera_bazaar/src/domain/entities/verify_otp_response_entity.dart';

abstract class AuthenticationRepository {
  Future<DataState<SendOtpResponseEntity>> sendOTP({required String number});

  Future<DataState<VerifyOtpResponseEntity>> verifyOTP({required String number, required String otp});
}
