import 'package:mera_bazaar/src/data/models/cart/cart_data.dart';

class CartEntity {
  final int? id;

  final String? name;

  final String? imageUrl;

  double? originalPrice;

  double? discountedPrice;

  double? totalOriginalPrice;

  double? totalDiscountedPrice;

  double? price;

  int? quantity;

  double? discount;

  double? rating;

  CartEntity({
    this.id,
    this.name,
    this.imageUrl,
    this.originalPrice,
    this.discountedPrice,
    this.totalOriginalPrice,
    this.totalDiscountedPrice,
    this.discount,
    this.price,
    this.quantity,
    this.rating,
  });

  CartData toModel(CartEntity instance) => CartData(
    id: id,
    name: name,
    imageUrl: imageUrl,
    originalPrice: originalPrice,
    discountedPrice: discountedPrice,
    totalOriginalPrice: totalOriginalPrice,
    totalDiscountedPrice: totalDiscountedPrice,
    discount: discount,
    price: price,
    quantity: quantity,
    rating: rating,

  );
}
