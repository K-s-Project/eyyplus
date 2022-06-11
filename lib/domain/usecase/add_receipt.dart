import '../entity/receiptentity.dart';
import '../repository/receipt_repository.dart';

class AddReceipt {
  final ReceiptRepository repo;
  AddReceipt({
    required this.repo,
  });

  Future<void> call({required ReceiptEntity receipt}) async {
    await repo.addReceipt(receipt);
  }
}
