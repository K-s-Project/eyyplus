import 'package:eyyplus/data/models/supplier_suggestion.dart';
import 'package:hive/hive.dart';

import '../../data/models/product_suggestion.dart';

class SuggestionFilter {
  final suggestionBox = Hive.box('suggestions_fixed1');
  final supplierBox = Hive.box('supplier_suggestions');
  Future<List<ProductSuggestionModel>> showSuggestions(String query) async {
    var cachedReceipt = suggestionBox.values.toList();
    final convertedTable = cachedReceipt.map((e) {
      return ProductSuggestionModel.fromEntity(e);
    }).toList();
    List<ProductSuggestionModel> matches = [];
    matches.addAll(convertedTable);
    matches.retainWhere((element) =>
        element.suggestion.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  Future<List<SupplierSuggestionModel>> showSuppliers(String query) async {
    var cachedReceipt = supplierBox.values.toList();
    final convertedTable = cachedReceipt.map((e) {
      return SupplierSuggestionModel.fromEntity(e);
    }).toList();
    List<SupplierSuggestionModel> matches = [];
    matches.addAll(convertedTable);
    matches.retainWhere((element) =>
        element.suppliername.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
