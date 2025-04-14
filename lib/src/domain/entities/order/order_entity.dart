class OrderEntity {
  final String? orderId;

  final String? name;

  final String? imageUrl;

  final double? originalPrice;

  final double? discountedPrice;

  final double? discount;

  final double? price;

  final int? quantity;

  final double? totalPrice;

  final String? orderDate;

  final String? deliveryDate;

  final double? rating;

  OrderEntity({
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
}
