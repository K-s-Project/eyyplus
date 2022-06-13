// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:eyyplus/domain/entity/product_suggestion.dart';
import 'package:eyyplus/domain/repository/receipt_repository.dart';

class AddProducts {
  final ReceiptRepository repo;
  AddProducts({
    required this.repo,
  });

  Future<void> call(ProductSuggestionEntity products) async {
    await repo.addProducts(products);
  }
}
