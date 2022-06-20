// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:eyyplus/domain/entity/supplier_suggestion.dart';
import 'package:eyyplus/domain/repository/receipt_repository.dart';

class AddSuppliers {
  final ReceiptRepository repo;
  AddSuppliers({
    required this.repo,
  });

  Future<void> call(SupplierSuggestionEntity supplier) async {
    await repo.addSupplier(supplier);
  }
}
