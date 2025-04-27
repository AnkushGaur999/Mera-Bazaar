import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/payment/payment_entity.dart';

abstract class PaymentRepository {
  Future<DataState<String>> processPayment({
    required PaymentEntity paymentEntity,
  });
}
