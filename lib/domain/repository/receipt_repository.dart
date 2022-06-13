import 'package:dartz/dartz.dart';
import 'package:eyyplus/domain/entity/product_suggestion.dart';

import '../../core/error/cachefailure.dart';
import '../entity/receiptentity.dart';

abstract class ReceiptRepository {
  Future<Either<CacheFailure, List<ReceiptEntity>>> getReceipt();
  Future<void> addReceipt(ReceiptEntity receipt);
  Future<void> deleteReceipt({required String receiptno});
  Future<Either<CacheFailure, List<ReceiptEntity>>> getSpecificReceipt(
      String text);
  Future<Either<CacheFailure, List<ProductSuggestionEntity>>> showSuggestions(
      String search);
  Future<void> addProducts(ProductSuggestionEntity products);
}
