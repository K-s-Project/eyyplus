import 'package:hive/hive.dart';

import '../../domain/entity/productentity.dart';

part 'productmodel.g.dart';

@HiveType(typeId: 1)
class ProductModel extends ProductEntity {
  @HiveField(0)
  final String product;
  @HiveField(1)
  final double price;
  @HiveField(2)
  final double totalprice;
  @HiveField(3)
  final int quantity;
  @HiveField(4)
  final int discount;
  @HiveField(5)
  final String unit;
  ProductModel({
    required this.product,
    required this.price,
    required this.totalprice,
    required this.quantity,
    required this.discount,
    required this.unit,
  }) : super(
          product: product,
          price: price,
          totalprice: totalprice,
          quantity: quantity,
          discount: discount,
          unit: unit,
        );
  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      product: entity.product,
      price: entity.price,
      totalprice: entity.totalprice,
      quantity: entity.quantity,
      discount: entity.discount,
      unit: entity.unit,
    );
  }
}
