part of "auth_bloc.dart";

sealed class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class SendOtpLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class SendOtpSuccess extends AuthState {
  final String message;

  SendOtpSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class SendOtpError extends AuthState {
  final String message;

  SendOtpError({required this.message});

  @override
  List<Object?> get props => [message];
}

class VerifyOtpLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class VerifyOtpSuccess extends AuthState {
  final String message;

  VerifyOtpSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class VerifyOtpError extends AuthState {
  final String message;

  VerifyOtpError({required this.message});

  @override
  List<Object?> get props => [message];
}
