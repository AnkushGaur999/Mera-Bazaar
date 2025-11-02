// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartData _$CartDataFromJson(Map<String, dynamic> json) => CartData(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  imageUrl: json['image_url'] as String?,
  originalPrice: (json['original_price'] as num?)?.toDouble(),
  discountedPrice: (json['discounted_price'] as num?)?.toDouble(),
  totalOriginalPrice: (json['total_original_price'] as num?)?.toDouble(),
  totalDiscountedPrice: (json['total_discounted_price'] as num?)?.toDouble(),
  discount: (json['discount'] as num?)?.toDouble(),
  price: (json['price'] as num?)?.toDouble(),
  quantity: (json['quantity'] as num?)?.toInt(),
  rating: (json['rating'] as num?)?.toDouble(),
);

Map<String, dynamic> _$CartDataToJson(CartData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'original_price': instance.originalPrice,
      'discounted_price': instance.discountedPrice,
      'total_original_price': instance.totalOriginalPrice,
      'total_discounted_price': instance.totalDiscountedPrice,
      'price': instance.price,
      'quantity': instance.quantity,
      'discount': instance.discount,
      'rating': instance.rating,
    };
