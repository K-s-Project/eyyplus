class ProductEntity {
  final String product;
  final double price;

  final double totalprice;
  final int quantity;
  final int discount;
  final String unit;
  ProductEntity({
    required this.product,
    required this.price,
    required this.totalprice,
    required this.quantity,
    required this.discount,
    required this.unit,
  });
}
