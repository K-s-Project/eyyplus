import '../../core/error/cacheexception.dart';
import '../../core/error/cachefailure.dart';
import '../datasource/local_data_source.dart';
import '../models/receiptmodel.dart';
import '../../domain/entity/receiptentity.dart';
import '../../domain/repository/receipt_repository.dart';
import 'package:dartz/dartz.dart';

class ReceiptRepositoryImpl implements ReceiptRepository {
  final LocalDataSource local;
  ReceiptRepositoryImpl({
    required this.local,
  });

  @override
  Future<void> addReceipt(ReceiptEntity receipt) async {
    await local.addReceipt(ReceiptModel.fromEntity(receipt));
  }

  @override
  Future<void> deleteReceipt({required String receiptno}) async {
    await local.deleteReceipt(receiptno: receiptno);
  }

  @override
  Future<Either<CacheFailure, List<ReceiptEntity>>> getReceipt() async {
    try {
      final result = await local.getReceipt();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<CacheFailure, List<ReceiptEntity>>> getSpecificReceipt(
      String text) async {
    try {
      final result = await local.getSpecificReceipt(text);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
