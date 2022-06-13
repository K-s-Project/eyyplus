import 'package:hive/hive.dart';

import 'package:eyyplus/domain/entity/product_suggestion.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first
part 'product_suggestion.g.dart';

@HiveType(typeId: 2)
class ProductSuggestionModel extends ProductSuggestionEntity {
  @HiveField(0)
  final List<String> suggestions;
  final String receiptno;
  ProductSuggestionModel({
    required this.suggestions,
    required this.receiptno,
  }) : super(
          suggestions: suggestions,
          receiptno: receiptno,
        );

  factory ProductSuggestionModel.fromEntity(ProductSuggestionEntity product) {
    return ProductSuggestionModel(
      suggestions: product.suggestions,
      receiptno: product.receiptno,
    );
  }
}
