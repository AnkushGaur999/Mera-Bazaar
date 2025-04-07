import 'package:mera_bazaar/src/data/models/cart/cart_response.dart';

abstract class CartDataSource {
  Future<String> addToCart({required CartResponse cartData});

  Future<List<CartResponse>> getCartItems();

  Future<String> deleteCartItem({required int id});

  Future<String> updateCartItem({required CartResponse cartData});
}
