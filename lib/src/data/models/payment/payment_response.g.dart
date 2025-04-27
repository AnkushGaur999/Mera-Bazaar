// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentResponse _$PaymentResponseFromJson(Map<String, dynamic> json) =>
    PaymentResponse(
      id: json['id'] as String?,
      amount: (json['amount'] as num).toDouble(),
      paymentMethod: json['payment_method'] as String,
      orderId: json['order_id'] as String?,
      userId: json['user_id'] as String?,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$PaymentResponseToJson(PaymentResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'payment_method': instance.paymentMethod,
      'order_id': instance.orderId,
      'user_id': instance.userId,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
    };
