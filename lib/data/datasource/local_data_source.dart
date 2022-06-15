import 'package:hive/hive.dart';

import '../models/product_suggestion.dart';
import '../models/receiptmodel.dart';

abstract class LocalDataSource {
  Future<List<ReceiptModel>> getReceipt();
  Future<void> addReceipt(ReceiptModel receipt);
  Future<void> deleteReceipt({required String receiptno});
  Future<List<ReceiptModel>> getSpecificReceipt(String text);
  Future<void> addProducts(ProductSuggestionModel products);
}

class LocalDataSourceImpl implements LocalDataSource {
  final box = Hive.box('aplus_receipts');
  final suggestionBox = Hive.box('suggestions_edited');
  @override
  Future<void> addReceipt(ReceiptModel receipt) async {
    await box.put(receipt.receiptno, receipt);
  }

  @override
  Future<void> deleteReceipt({required String receiptno}) async {
    await box.delete(receiptno);
  }

  @override
  Future<List<ReceiptModel>> getReceipt() async {
    var cachedReceipt = box.values.toList();

    final convertedTable = cachedReceipt.map((e) {
      return ReceiptModel.fromEntity(e);
    }).toList();
    convertedTable.map((e) => print('receipt ${e.receiptno}')).toList();
    return convertedTable;
  }

  @override
  Future<List<ReceiptModel>> getSpecificReceipt(String text) async {
    var cachedReceipt = box.values.toList();
    final convertedTable = cachedReceipt.map((e) {
      return ReceiptModel.fromEntity(e);
    }).toList();
    final result = convertedTable.where((receipt) {
      final product = receipt.product.where((product) {
        final name = product.product.toLowerCase();
        return name.contains(text.toLowerCase());
      }).toList();
      return product.isEmpty ? false : true;
    }).toList();
    return result;
  }

  @override
  Future<void> addProducts(ProductSuggestionModel products) async {
    await suggestionBox.put(products.suggestion, products);
  }
}
