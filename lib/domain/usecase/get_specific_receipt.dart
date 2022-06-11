import '../repository/receipt_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/cachefailure.dart';
import '../entity/receiptentity.dart';

class GetSpecificReceipt {
  final ReceiptRepository repo;
  GetSpecificReceipt({
    required this.repo,
  });
  Future<Either<CacheFailure, List<ReceiptEntity>>> call(String text) async {
    return await repo.getSpecificReceipt(text);
  }
}
