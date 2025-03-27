part of "auth_bloc.dart";

sealed class AuthEvent extends Equatable {}

class SendOtpEvent extends AuthEvent {
  final String number;

  SendOtpEvent({required this.number});

  @override
  List<Object?> get props => [number];
}

class VerifyOtpEvent extends AuthEvent {
  final String number;
  final String otp;

  VerifyOtpEvent({required this.number, required this.otp});

  @override
  List<Object?> get props => [number, otp];
}
