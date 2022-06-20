import 'dart:convert';

class ProductEntity {
  final String product;
  final double price;

  final double totalprice;
  final int quantity;
  final double discount;
  final String unit;
  ProductEntity({
    required this.product,
    required this.price,
    required this.totalprice,
    required this.quantity,
    required this.discount,
    required this.unit,
  });

  Map<String, dynamic> toMap() {
    return {
      'product': product,
      'price': price,
      'totalprice': totalprice,
      'quantity': quantity,
      'discount': discount,
      'unit': unit,
    };
  }

  factory ProductEntity.fromMap(Map<String, dynamic> map) {
    return ProductEntity(
      product: map['product'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      totalprice: map['totalprice']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
      discount: map['discount']?.double() ?? 0,
      unit: map['unit'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductEntity.fromJson(String source) =>
      ProductEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductEntity(product: $product, price: $price, totalprice: $totalprice, quantity: $quantity, discount: $discount, unit: $unit)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductEntity &&
        other.product == product &&
        other.price == price &&
        other.totalprice == totalprice &&
        other.quantity == quantity &&
        other.discount == discount &&
        other.unit == unit;
  }

  @override
  int get hashCode {
    return product.hashCode ^
        price.hashCode ^
        totalprice.hashCode ^
        quantity.hashCode ^
        discount.hashCode ^
        unit.hashCode;
  }
}
