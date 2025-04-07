import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/auth/send_otp_response_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/authentication_repository.dart';

class SendOtpUseCase {
  final AuthenticationRepository authenticationRepository;

  SendOtpUseCase({required this.authenticationRepository});

  Future<DataState<SendOtpResponseEntity>> sendOtp({required String number}) async {
    return await authenticationRepository.sendOTP(number: number);
  }
}
