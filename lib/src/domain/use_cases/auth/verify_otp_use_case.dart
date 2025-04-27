import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/auth/verify_otp_response_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository authenticationRepository;

  VerifyOtpUseCase({required this.authenticationRepository});

  Future<DataState<VerifyOtpResponseEntity>> sendOtp({
    required String number,
    required String otp,
  }) async {
    return await authenticationRepository.verifyOTP(number: number, otp: otp);
  }
}
