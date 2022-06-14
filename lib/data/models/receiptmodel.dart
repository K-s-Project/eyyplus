import 'package:hive/hive.dart';

import '../../domain/entity/receiptentity.dart';
import 'productmodel.dart';

part 'receiptmodel.g.dart';

@HiveType(typeId: 0)
class ReceiptModel extends ReceiptEntity {
  @override
  @HiveField(0)
  final String receiptno;
  @override
  @HiveField(1)
  final String date;
  @override
  @HiveField(2)
  final String supplier;
  @override
  @HiveField(3)
  final List<ProductModel> product;
  @override
  @HiveField(4)
  final int totalquantity;
  @override
  @HiveField(5)
  final double totalprice;
  ReceiptModel({
    required this.receiptno,
    required this.date,
    required this.supplier,
    required this.product,
    required this.totalquantity,
    required this.totalprice,
  }) : super(
          receiptno: receiptno,
          date: date,
          supplier: supplier,
          product: product,
          totalquantity: totalquantity,
          totalprice: totalprice,
        );
  factory ReceiptModel.fromEntity(ReceiptEntity receiptEntity) {
    return ReceiptModel(
      receiptno: receiptEntity.receiptno,
      date: receiptEntity.date,
      supplier: receiptEntity.supplier,
      product:
          receiptEntity.product.map((e) => ProductModel.fromEntity(e)).toList(),
      totalquantity: receiptEntity.totalquantity,
      totalprice: receiptEntity.totalprice,
    );
  }
}
