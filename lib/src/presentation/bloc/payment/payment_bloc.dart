import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/payment/payment_entity.dart';
import 'package:mera_bazaar/src/domain/use_cases/payment/process_payment_use_case.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final ProcessPaymentUseCase processPaymentUseCase;

  PaymentBloc({required this.processPaymentUseCase}) : super(PaymentInitial()) {
    on<ProcessPaymentEvent>(_processPayment);
  }

  Future<void> _processPayment(
    ProcessPaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(ProcessPaymentLoading());

    final response = await processPaymentUseCase.call(
      paymentEntity: event.paymentEntity,
    );

    if (response is DataSuccess) {
      emit(ProcessPaymentSuccess(message: response.data!));
    } else {
      emit(ProcessPaymentFailed(message: response.exception!.message));
    }
  }
}
