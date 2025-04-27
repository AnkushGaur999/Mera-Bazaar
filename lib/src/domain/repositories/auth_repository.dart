import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/auth/get_user_profile_entity.dart';
import 'package:mera_bazaar/src/domain/entities/auth/send_otp_response_entity.dart';
import 'package:mera_bazaar/src/domain/entities/auth/verify_otp_response_entity.dart';

abstract class AuthRepository {
  Future<DataState<SendOtpResponseEntity>> sendOTP({required String number});

  Future<DataState<VerifyOtpResponseEntity>> verifyOTP({required String number, required String otp});

  Future<DataState<GetUserProfileEntity>> getUserProfile({required String token});
}
