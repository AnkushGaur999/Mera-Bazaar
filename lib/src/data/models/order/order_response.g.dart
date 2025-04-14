// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) =>
    OrderResponse(
      orderId: json['order_id'] as String?,
      name: json['name'] as String?,
      imageUrl: json['image_url'] as String?,
      originalPrice: (json['original_price'] as num?)?.toDouble(),
      discountedPrice: (json['discounted_price'] as num?)?.toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toInt(),
      totalPrice: (json['total_price'] as num?)?.toDouble(),
      orderDate: json['order_date'] as String?,
      deliveryDate: json['delivery_date'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'original_price': instance.originalPrice,
      'discounted_price': instance.discountedPrice,
      'discount': instance.discount,
      'price': instance.price,
      'quantity': instance.quantity,
      'total_price': instance.totalPrice,
      'order_date': instance.orderDate,
      'delivery_date': instance.deliveryDate,
      'rating': instance.rating,
    };
