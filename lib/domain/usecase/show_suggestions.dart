// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:eyyplus/core/error/cachefailure.dart';
import 'package:eyyplus/domain/entity/product_suggestion.dart';
import 'package:eyyplus/domain/repository/receipt_repository.dart';

class ShowSuggestions {
  final ReceiptRepository repo;
  ShowSuggestions({
    required this.repo,
  });

  Future<Either<CacheFailure, List<ProductSuggestionEntity>>> call(
      String search) async {
    return await repo.showSuggestions(search);
  }
}
