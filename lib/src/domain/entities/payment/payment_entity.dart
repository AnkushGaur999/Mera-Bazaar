class PaymentEntity {
  final String? id;
  final double amount;
  final String paymentMethod;
  final String? orderId;
  final String? userId;
  final String status;
  final DateTime createdAt;

  PaymentEntity({
    this.id,
    required this.amount,
    required this.paymentMethod,
    this.orderId,
    this.userId,
    required this.status,
    required this.createdAt,
  });
}
