import 'package:json_annotation/json_annotation.dart';
import 'package:mera_bazaar/src/domain/entities/product/product_entity.dart';

part 'products_response.g.dart';

@JsonSerializable()
class ProductResponse {
  @JsonKey(name: "id")
  final String? id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "image_url")
  final String? imageUrl;

  @JsonKey(name: "original_price")
  final double? originalPrice;

  @JsonKey(name: "discounted_price")
  final double? discountedPrice;

  @JsonKey(name: "price")
  final double? price;

  @JsonKey(name: "discount")
  final double? discount;

  @JsonKey(name: "rating")
  final double? rating;

  ProductResponse({
    this.id,
    this.name,
    this.imageUrl,
    this.price,
    this.rating,
    this.originalPrice,
    this.discountedPrice,
    this.discount,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);

  ProductEntity toEntity(ProductResponse instance) => ProductEntity(
    name: instance.name,
    imageUrl: instance.imageUrl,
    price: instance.price,
    rating: instance.rating,
    discount: instance.discount,
    originalPrice: instance.originalPrice,
    discountedPrice: instance.discountedPrice,
  );
}
