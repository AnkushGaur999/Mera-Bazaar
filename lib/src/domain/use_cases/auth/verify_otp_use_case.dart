import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/auth/phone_auth_result.dart';
import 'package:mera_bazaar/src/domain/repositories/authentication_repository.dart';

class VerifyOtpUseCase {
  final AuthenticationRepository authenticationRepository;

  VerifyOtpUseCase({required this.authenticationRepository});

  Future<DataState<PhoneAuthResult>> call({
    required String number,
    required String otp,
  }) async {
    return await authenticationRepository.verifyOTP(number: number, otp: otp);
  }
}
