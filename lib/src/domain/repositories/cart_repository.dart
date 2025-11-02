import 'package:mera_bazaar/src/core/network/data_state.dart';
import 'package:mera_bazaar/src/domain/entities/cart/cart_entity.dart';

abstract class CartRepository {
  Future<DataState<String>> addToCart({required CartEntity cartEntity});

  Future<DataState<List<CartEntity>>> getCartItems();

  Future<DataState<CartEntity>> getCartItem({required String id});

  Future<DataState<String>> deleteCartItem({required int id});

  Future<DataState<String>> updateCartItem({required CartEntity cartEntity});
}
