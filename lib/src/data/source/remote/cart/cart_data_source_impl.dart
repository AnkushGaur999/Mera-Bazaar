/// Implementation of the cart data source.
///
/// This class implements the [CartDataSource] interface and provides
/// concrete implementations for cart-related API calls using Firestore.
/// It handles adding, retrieving, updating, and deleting cart items
/// in the Firestore database.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mera_bazaar/src/core/network/client/dio_client.dart';
import 'package:mera_bazaar/src/data/models/cart/cart_response.dart';
import 'package:mera_bazaar/src/data/source/remote/cart/cart_data_source.dart';

/// A concrete implementation of the [CartDataSource] interface.
///
/// This class uses Firestore to manage cart data in the database.
/// It handles CRUD operations for cart items and converts between
/// Firestore documents and [CartResponse] models.
class CartDataSourceImpl extends CartDataSource {
  /// The Dio client for making HTTP requests
  final DioClient dioClient;

  /// Creates a new instance of [CartDataSourceImpl].
  ///
  /// Requires a [DioClient] to be provided for making HTTP requests.
  CartDataSourceImpl({required this.dioClient});

  /// The Firestore instance for database operations
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  /// Adds an item to the cart.
  ///
  /// This method adds a new document to the "cart" collection in Firestore
  /// with the provided cart item data.
  ///
  /// Returns a success message string.
  ///
  /// [cartData] - The cart item data to add
  Future<String> addToCart({required CartResponse cartData}) async {
    await _fireStore.collection("cart").add(cartData.toJson());

    return "Successfully Add To Cart";
  }

  @override
  /// Retrieves all items in the cart.
  ///
  /// This method retrieves all documents from the "cart" collection in Firestore
  /// and converts them to [CartResponse] models.
  ///
  /// Returns a list of [CartResponse] containing all cart items.
  Future<List<CartResponse>> getCartItems() async {
    try {
      final response = await _fireStore.collection("cart").get();

      final cartList =
          response.docs.map((e) => CartResponse.fromJson(e.data())).toList();

      return cartList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  /// Deletes an item from the cart.
  ///
  /// This method finds the document in the "cart" collection with the given ID
  /// and deletes it from Firestore.
  ///
  /// Returns a success message string.
  ///
  /// [id] - The ID of the cart item to delete
  Future<String> deleteCartItem({required int id}) async {
    try {
      final response =
          await _fireStore.collection("cart").where("id", isEqualTo: id).get();

      for (var element in response.docs) {
        await _fireStore.collection("cart").doc(element.id).delete();
      }

      return "Successfully Removed From Cart";
    } catch (e) {
      rethrow;
    }
  }

  @override
  /// Updates an item in the cart.
  ///
  /// This method finds the document in the "cart" collection with the given ID
  /// and updates its fields with the provided cart item data.
  ///
  /// Returns a success message string.
  ///
  /// [cartData] - The updated cart item data
  Future<String> updateCartItem({required CartResponse cartData}) async {
    try {
      final response =
          await _fireStore
              .collection("cart")
              .where("id", isEqualTo: cartData.id)
              .get();

      _fireStore.collection("cart").doc(response.docs[0].id).update({
        "quantity": cartData.quantity,
        "total_discounted_price": cartData.totalDiscountedPrice,
        "total_original_price": cartData.totalOriginalPrice,
        "discount": cartData.discount,
      });

      return "Successfully Updated";
    } catch (e) {
      rethrow;
    }
  }
}
