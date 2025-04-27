import 'package:json_annotation/json_annotation.dart';
import 'package:mera_bazaar/src/domain/entities/payment/payment_entity.dart';

part 'payment_response.g.dart';

@JsonSerializable()
class PaymentResponse {
  @JsonKey(name: "id")
  final String? id;

  @JsonKey(name: "amount")
  final double amount;

  @JsonKey(name: "payment_method")
  final String paymentMethod;

  @JsonKey(name: "order_id")
  final String? orderId;

  @JsonKey(name: "user_id")
  final String? userId;

  @JsonKey(name: "status")
  final String status;

  @JsonKey(name: "created_at")
  final DateTime createdAt;

  PaymentResponse({
    this.id,
    required this.amount,
    required this.paymentMethod,
    this.orderId,
    this.userId,
    required this.status,
    required this.createdAt,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentResponseToJson(this);

  PaymentEntity toEntity(PaymentResponse instance) => PaymentEntity(
    id: instance.id,
    amount: instance.amount,
    paymentMethod: instance.paymentMethod,
    orderId: instance.orderId,
    userId: instance.userId,
    status: instance.status,
    createdAt: instance.createdAt,
  );
}
