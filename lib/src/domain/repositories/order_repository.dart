
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/order/order_entity.dart';

abstract class OrderRepository{

  Future<DataState<List<OrderEntity>>> getOrders();

}