import 'package:hive/hive.dart';

import '../../data/models/product_suggestion.dart';

class SuggestionFilter {
  final suggestionBox = Hive.box('products_suggestions7');
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
}
