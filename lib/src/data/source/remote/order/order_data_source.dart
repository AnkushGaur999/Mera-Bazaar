import 'package:mera_bazaar/src/data/models/order/order_response.dart';

abstract class OrderDataSource{

  Future<List<OrderResponse>> getOrders();

}