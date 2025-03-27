import 'package:equatable/equatable.dart';
import 'package:mera_bazaar/src/data/models/auth/verify_otp/verify_otp_response.dart';

class VerifyOtpResponseEntity extends Equatable {
  final bool? success;
  final String? message;
  final bool? error;
  final VerifyOtpData? data;

  const VerifyOtpResponseEntity({
    this.success,
    this.message,
    this.error,
    this.data,
  });

  @override
  List<Object?> get props => [
        success,
        message,
        error,
        data,
      ];
}
