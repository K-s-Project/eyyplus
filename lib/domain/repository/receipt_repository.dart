import 'package:dartz/dartz.dart';
import 'package:eyyplus/domain/entity/supplier_suggestion.dart';

import '../../core/error/cachefailure.dart';
import '../entity/product_suggestion.dart';
import '../entity/receiptentity.dart';

abstract class ReceiptRepository {
  Future<Either<CacheFailure, List<ReceiptEntity>>> getReceipt();
  Future<void> addReceipt(ReceiptEntity receipt);
  Future<void> deleteReceipt({required String receiptno});
  Future<Either<CacheFailure, List<ReceiptEntity>>> getSpecificReceipt(
      String text);
  Future<void> addProducts(ProductSuggestionEntity products);
  Future<void> addSupplier(SupplierSuggestionEntity supplier);
}
