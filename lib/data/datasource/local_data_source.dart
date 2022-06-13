import 'package:eyyplus/data/models/product_suggestion.dart';
import 'package:eyyplus/presentation/receipt_cubit/receipt_cubit.dart';
import 'package:hive/hive.dart';

import '../models/receiptmodel.dart';

abstract class LocalDataSource {
  Future<List<ReceiptModel>> getReceipt();
  Future<void> addReceipt(ReceiptModel receipt);
  Future<void> deleteReceipt({required String receiptno});
  Future<List<ReceiptModel>> getSpecificReceipt(String text);
  Future<void> addProducts(ProductSuggestionModel products);
  Future<List<ProductSuggestionModel>> showSuggestions(String search);
}

class LocalDataSourceImpl implements LocalDataSource {
  final box = Hive.box('aplus_receipt_edited4');
  final suggestionBox = Hive.box('products_suggestion3');
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
    await box.put(products.receiptno, products);
  }

  @override
  Future<List<ProductSuggestionModel>> showSuggestions(String search) async {
    var cachedReceipt = suggestionBox.values.toList();
    final convertedTable = cachedReceipt.map((e) {
      return ProductSuggestionModel.fromEntity(e);
    }).toList();
    final result = convertedTable.where((p) {
      print('p: $p');
      final product = p.suggestions.where((prod) {
        final name = prod.toLowerCase();
        return name.contains(search.toLowerCase());
      }).toList();
      return product.isEmpty ? false : true;
    }).toList();
    return result;
  }
}
