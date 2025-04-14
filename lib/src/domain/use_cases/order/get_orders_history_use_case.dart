import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/order/order_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/order_repository.dart';

class GetOrdersHistoryUseCase {
  final OrderRepository repository;

  GetOrdersHistoryUseCase({required this.repository});

  Future<DataState<List<OrderEntity>>> call() async {
    return await repository.getOrders();
  }
}
