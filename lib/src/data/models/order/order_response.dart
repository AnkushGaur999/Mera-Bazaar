import 'package:json_annotation/json_annotation.dart';
import 'package:mera_bazaar/src/domain/entities/order/order_entity.dart';

part 'order_response.g.dart';

@JsonSerializable()
class OrderResponse {
  @JsonKey(name: "order_id")
  final String? orderId;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "image_url")
  final String? imageUrl;

  @JsonKey(name: "original_price")
  final double? originalPrice;

  @JsonKey(name: "discounted_price")
  final double? discountedPrice;

  @JsonKey(name: "discount")
  final double? discount;

  @JsonKey(name: "price")
  final double? price;

  @JsonKey(name: "quantity")
  final int? quantity;

  @JsonKey(name: "total_price")
  final double? totalPrice;

  @JsonKey(name: "order_date")
  final String? orderDate;

  @JsonKey(name: "delivery_date")
  final String? deliveryDate;

  @JsonKey(name: "rating")
  final double? rating;

  OrderResponse({
    this.orderId,
    this.name,
    this.imageUrl,
    this.originalPrice,
    this.discountedPrice,
    this.discount,
    this.price,
    this.quantity,
    this.totalPrice,
    this.orderDate,
    this.deliveryDate,
    this.rating,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);

  OrderEntity toEntity(OrderResponse instance) => OrderEntity(
    orderId: instance.orderId,
    name: instance.name,
    imageUrl: instance.imageUrl,
    originalPrice: instance.originalPrice,
    discountedPrice: instance.discountedPrice,
    discount: instance.discount,
    price: instance.price,
    quantity: instance.quantity,
    totalPrice: instance.totalPrice,
    orderDate: instance.orderDate,
    deliveryDate: instance.deliveryDate,
    rating: instance.rating,
  );
}
