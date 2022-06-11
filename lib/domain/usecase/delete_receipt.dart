import '../repository/receipt_repository.dart';

class DeleteReceipt {
  final ReceiptRepository repo;
  DeleteReceipt({
    required this.repo,
  });

  Future<void> call({required String receiptno}) async {
    await repo.deleteReceipt(receiptno: receiptno);
  }
}
