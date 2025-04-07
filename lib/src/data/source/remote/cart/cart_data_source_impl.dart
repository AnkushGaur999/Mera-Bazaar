import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mera_bazaar/src/core/network/client/dio_client.dart';
import 'package:mera_bazaar/src/data/models/cart/cart_response.dart';
import 'package:mera_bazaar/src/data/source/remote/cart/cart_data_source.dart';

class CartDataSourceImpl extends CartDataSource {
  final DioClient dioClient;

  CartDataSourceImpl({required this.dioClient});

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Future<String> addToCart({required CartResponse cartData}) async {
    await _fireStore.collection("cart").add(cartData.toJson());

    return "Successfully Add To Cart";
  }

  @override
  Future<List<CartResponse>> getCartItems() async {
    final response = await _fireStore.collection("cart").get();

    final cartList =
        response.docs.map((e) => CartResponse.fromJson(e.data())).toList();

    return cartList;
  }

  @override
  Future<String> deleteCartItem({required int id}) async {
    final response =
        await _fireStore.collection("cart").where("id", isEqualTo: id).get();

    for (var element in response.docs) {
      await _fireStore.collection("cart").doc(element.id).delete();
    }

    return "Successfully Removed From Cart";
  }

  @override
  Future<String> updateCartItem({required CartResponse cartData}) async {
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
  }
}
