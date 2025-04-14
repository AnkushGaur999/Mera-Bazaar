import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mera_bazaar/src/core/network/client/dio_client.dart';
import 'package:mera_bazaar/src/data/models/order/order_response.dart';
import 'package:mera_bazaar/src/data/source/remote/order/order_data_source.dart';

class OrderDataSourceImpl extends OrderDataSource {
  final DioClient dioClient;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  OrderDataSourceImpl({required this.dioClient});

  @override
  Future<List<OrderResponse>> getOrders() async {
    final response =
        await _fireStore
            .collection("orders")
            .where("user_id", isEqualTo: "YKaxiSO1NagMEQA7jN5t")
            .get();

    final List<OrderResponse> orderList = [];

    for (int i = 0; i < response.docs.length; i++) {
      orderList.add(OrderResponse.fromJson(response.docs[i].data()));
    }

    return orderList;
  }
}
