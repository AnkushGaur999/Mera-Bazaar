part of 'payment_bloc.dart';

sealed class PaymentEvent extends Equatable {}

class ProcessPaymentEvent extends PaymentEvent {
  final PaymentEntity paymentEntity;

  ProcessPaymentEvent({required this.paymentEntity});

  @override
  List<Object?> get props => [paymentEntity];
}
