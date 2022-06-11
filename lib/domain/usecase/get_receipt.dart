import '../entity/receiptentity.dart';
import '../repository/receipt_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/cachefailure.dart';

class GetReceipt {
  final ReceiptRepository repo;
  GetReceipt({
    required this.repo,
  });

  Future<Either<CacheFailure, List<ReceiptEntity>>> call() async {
    return repo.getReceipt();
  }
}
