class ProductEntity {
  final String? name;
  final String? imageUrl;
  final double? price;
  final double? discount;
  final double? originalPrice;
  final double? discountedPrice;
  final double? rating;

  ProductEntity({
    this.name,
    this.imageUrl,
    this.price,
    this.rating,
    this.discount,
    this.originalPrice,
    this.discountedPrice
  });
}
