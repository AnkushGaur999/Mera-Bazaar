part of 'payment_bloc.dart';

sealed class PaymentState extends Equatable {}

final class PaymentInitial extends PaymentState {
  @override
  List<Object?> get props => [];
}

final class ProcessPaymentLoading extends PaymentState {
  @override
  List<Object?> get props => [];
}

final class ProcessPaymentSuccess extends PaymentState {
  final String message;

  ProcessPaymentSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

final class ProcessPaymentFailed extends PaymentState {
  final String message;

  ProcessPaymentFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
