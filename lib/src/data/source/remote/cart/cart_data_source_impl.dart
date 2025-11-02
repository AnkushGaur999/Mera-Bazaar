import 'package:mera_bazaar/main_export.dart';
import 'package:mera_bazaar/src/core/network/client/dio_client.dart';
import 'package:mera_bazaar/src/data/models/cart/cart_data.dart';
import 'package:mera_bazaar/src/data/source/remote/cart/cart_data_source.dart';

/// Implementation of the cart data source.
///
/// This class implements the [CartDataSource] interface and provides
/// concrete implementations for cart-related API calls using Firestore.
/// It handles adding, retrieving, updating, and deleting cart items
/// in the Firestore database.

/// A concrete implementation of the [CartDataSource] interface.
///
/// This class uses Firestore to manage cart data in the database.
/// It handles CRUD operations for cart items and converts between
/// Firestore documents and [CartData] models.
class CartDataSourceImpl extends CartDataSource {
  /// The Dio client for making HTTP requests
  final DioClient dioClient;

  /// Creates a new instance of [CartDataSourceImpl].
  ///
  /// Requires a [DioClient] to be provided for making HTTP requests.
  CartDataSourceImpl({required this.dioClient});

  @override
  /// Adds an item to the cart.
  ///
  /// This method adds a new document to the "cart" collection in Firestore
  /// with the provided cart item data.
  ///
  /// Returns a success message string.
  ///
  /// [cartData] - The cart item data to add
  Future<String> addToCart({required CartData cartData}) async {
    await fireStore
        .collection("cart")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("items")
        .add(cartData.toJson());

    return "Successfully Add To Cart";
  }

  @override
  /// Retrieves all items in the cart.
  ///
  /// This method retrieves all documents from the "cart" collection in Firestore
  /// and converts them to [CartData] models.
  ///
  /// Returns a list of [CartData] containing all cart items.
  Future<List<CartData>> getCartItems() async {
    final response = await fireStore
        .collection("cart")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("items")
        .get();

    final cartList = response.docs
        .map((e) => CartData.fromJson(e.data()))
        .toList();

    return cartList;
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
    final response = await fireStore
        .collection("cart")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("items")
        .where("id", isEqualTo: id)
        .limit(1)
        .get();


    await fireStore
        .collection("cart")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("items")
        .doc(response.docs.first.id)
        .delete();

    return "Successfully Removed From Cart";
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
  Future<String> updateCartItem({required CartData cartData}) async {
    try {
      final response = await fireStore
          .collection("cart")
          .doc(firebaseAuth.currentUser!.uid)
          .collection("items")
          .where("id", isEqualTo: cartData.id)
          .limit(1)
          .get();

      fireStore
          .collection("cart")
          .doc(firebaseAuth.currentUser!.uid)
          .collection("items")
          .doc(response.docs.first.id)
          .update({
            "quantity": cartData.quantity,
            "total_discounted_price": cartData.totalDiscountedPrice,
            "total_original_price": cartData.totalOriginalPrice,
            "discount": cartData.discount,
          });
    } on FirebaseException catch (_) {
      return "Server Error! Please Try again";
    } catch (e) {
      return "Something went wrong! Please try after some time";
    }

    return "Successfully Updated";
  }

  @override
  Future<List<CartData>> getCartItem({required String id}) async {
    try {
      final result = await fireStore
          .collection("cart")
          .doc(firebaseAuth.currentUser!.uid)
          .collection("items")
          .where("id", isEqualTo: id)
          .limit(1)
          .get();

      return result.docs.isNotEmpty
          ? [CartData.fromJson(result.docs.first.data())]
          : [];
    } catch (e) {
      rethrow;
    }
  }
}
