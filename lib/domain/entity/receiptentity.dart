import 'productentity.dart';

class ReceiptEntity {
  final String receiptno;
  final String date;
  final String supplier;
  final List<ProductEntity> product;
  final int totalquantity;
  final double totalprice;
  ReceiptEntity({
    required this.receiptno,
    required this.date,
    required this.supplier,
    required this.product,
    required this.totalquantity,
    required this.totalprice,
  });
}
