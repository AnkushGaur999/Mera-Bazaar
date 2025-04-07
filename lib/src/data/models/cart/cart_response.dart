import 'package:json_annotation/json_annotation.dart';
import 'package:mera_bazaar/src/domain/entities/cart/cart_entity.dart';

part 'cart_response.g.dart';

@JsonSerializable()
class CartResponse {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "image_url")
  final String? imageUrl;

  @JsonKey(name: "original_price")
  final double? originalPrice;

  @JsonKey(name: "discounted_price")
  final double? discountedPrice;

  @JsonKey(name: "total_original_price")
  final double? totalOriginalPrice;

  @JsonKey(name: "total_discounted_price")
  final double? totalDiscountedPrice;

  @JsonKey(name: "price")
  final double? price;

  @JsonKey(name: "quantity")
  final int? quantity;

  @JsonKey(name: "discount")
  final double? discount;

  @JsonKey(name: "rating")
  final double? rating;


  CartResponse({
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

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseToJson(this);

  CartEntity toEntity(CartResponse instance) => CartEntity(
    id: instance.id,
    name: instance.name,
    imageUrl: instance.imageUrl,
    discount: instance.discount,
    quantity: instance.quantity,
    price: instance.price,
    rating: instance.rating,
    originalPrice: instance.originalPrice,
    discountedPrice: instance.discountedPrice,
    totalOriginalPrice: instance.totalOriginalPrice,
    totalDiscountedPrice: instance.totalDiscountedPrice,
  );
}
