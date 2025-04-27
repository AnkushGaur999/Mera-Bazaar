import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/core/exceptions/network_exception.dart';
import 'package:mera_bazaar/src/data/models/payment/payment_response.dart';
import 'package:mera_bazaar/src/data/source/remote/payment/payment_data_source.dart';
import 'package:mera_bazaar/src/domain/entities/payment/payment_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentDataSource paymentDataSource;

  PaymentRepositoryImpl({required this.paymentDataSource});

  @override
  Future<DataState<String>> processPayment({
    required PaymentEntity paymentEntity,
  }) async {
    try {
      // Convert entity to response model
      final paymentResponse = PaymentResponse(
        id: paymentEntity.id,
        amount: paymentEntity.amount,
        paymentMethod: paymentEntity.paymentMethod,
        orderId: paymentEntity.orderId,
        userId: paymentEntity.userId,
        status: paymentEntity.status,
        createdAt: paymentEntity.createdAt,
      );

      // Call data source
      final result = await paymentDataSource.processPayment(
        paymentData: paymentResponse,
      );

      return DataSuccess(data: result);
    } catch (e) {
      return DataError<String>(exception: NetworkException.fromException(e));
    }
  }
}
