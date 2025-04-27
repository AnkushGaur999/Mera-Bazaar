import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/payment/payment_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/payment_repository.dart';

class ProcessPaymentUseCase {
  final PaymentRepository paymentRepository;

  ProcessPaymentUseCase({required this.paymentRepository});

  Future<DataState<String>> call({required PaymentEntity paymentEntity}) async {
    return await paymentRepository.processPayment(paymentEntity: paymentEntity);
  }
}
