import 'package:dio/dio.dart';
import 'package:mera_bazaar/src/core/exceptions/network_exception.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/data/source/remote/order/order_data_source.dart';
import 'package:mera_bazaar/src/domain/entities/order/order_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/order_repository.dart';

class OrderRepositoryImpl extends OrderRepository {
  final OrderDataSource orderDataSource;

  OrderRepositoryImpl({required this.orderDataSource});

  @override
  Future<DataState<List<OrderEntity>>> getOrders() async {
    try {
      final response = await orderDataSource.getOrders();

      return DataSuccess(data: response.map((e) => e.toEntity(e)).toList());
    } on DioException catch (e) {
      return DataError(exception: NetworkException.fromDioError(e));
    } on Exception catch (e) {
      return DataError(exception: NetworkException.fromException(e));
    }
  }
}
