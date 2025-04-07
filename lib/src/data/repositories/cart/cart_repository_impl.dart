import 'package:dio/dio.dart';
import 'package:mera_bazaar/src/core/exceptions/network_exception.dart';
import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/data/source/remote/cart/cart_data_source.dart';
import 'package:mera_bazaar/src/domain/entities/cart/cart_entity.dart';
import 'package:mera_bazaar/src/domain/repositories/cart_repository.dart';

class CartRepositoryImpl extends CartRepository {
  final CartDataSource cartDataSource;

  CartRepositoryImpl({required this.cartDataSource});

  @override
  Future<DataState<String>> addToCart({required CartEntity cartEntity}) async {
    try {
      final response = await cartDataSource.addToCart(
        cartData: cartEntity.toModel(cartEntity),
      );
      return DataSuccess(data: response);
    } on DioException catch (e) {
      return DataError(exception: NetworkException.fromDioError(e));
    } catch (e) {
      return DataError(exception: NetworkException.fromException(e));
    }
  }

  @override
  Future<DataState<List<CartEntity>>> getCartItems() async {
    try {
      final response = await cartDataSource.getCartItems();
      return DataSuccess(data: response.map((e) => e.toEntity(e)).toList());
    } on DioException catch (e) {
      return DataError(exception: NetworkException.fromDioError(e));
    } catch (e) {
      return DataError(exception: NetworkException.fromException(e));
    }
  }

  @override
  Future<DataState<String>> deleteCartItem({required int id}) async {
    try {
      final response = await cartDataSource.deleteCartItem(id: id);
      return DataSuccess(data: response);
    } on DioException catch (e) {
      return DataError(exception: NetworkException.fromDioError(e));
    } catch (e) {
      return DataError(exception: NetworkException.fromException(e));
    }
  }

  @override
  Future<DataState<String>> updateCartItem({
    required CartEntity cartEntity,
  }) async {
    try {
      final response = await cartDataSource.updateCartItem(
        cartData: cartEntity.toModel(cartEntity),
      );
      return DataSuccess(data: response);
    } on DioException catch (e) {
      return DataError(exception: NetworkException.fromDioError(e));
    } catch (e) {
      return DataError(exception: NetworkException.fromException(e));
    }
  }
}
