/// Interface for cart data source operations.
///
/// This abstract class defines the contract for making cart-related
/// API calls. It includes methods for:
/// - Adding items to cart
/// - Retrieving cart items
/// - Deleting cart items
/// - Updating cart items
import 'package:mera_bazaar/src/data/models/cart/cart_response.dart';

/// Abstract class defining the contract for cart data source operations.
///
/// This interface should be implemented by concrete classes that handle the actual
/// API calls for cart operations. The methods return response models that
/// can be converted to domain entities.
abstract class CartDataSource {
  /// Adds an item to the cart.
  ///
  /// This method should make an API call to add the given cart item.
  /// It returns a success message string.
  ///
  /// [cartData] - The cart item data to add
  Future<String> addToCart({required CartResponse cartData});

  /// Retrieves all items in the cart.
  ///
  /// This method should make an API call to get all cart items.
  /// It returns a list of [CartResponse] containing the cart items.
  Future<List<CartResponse>> getCartItems();

  /// Deletes an item from the cart.
  ///
  /// This method should make an API call to delete the cart item with the given ID.
  /// It returns a success message string.
  ///
  /// [id] - The ID of the cart item to delete
  Future<String> deleteCartItem({required int id});

  /// Updates an item in the cart.
  ///
  /// This method should make an API call to update the given cart item.
  /// It returns a success message string.
  ///
  /// [cartData] - The updated cart item data
  Future<String> updateCartItem({required CartResponse cartData});
}
