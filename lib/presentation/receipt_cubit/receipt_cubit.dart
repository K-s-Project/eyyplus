import '../../domain/usecase/get_specific_receipt.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entity/receiptentity.dart';
import '../../domain/usecase/add_receipt.dart';
import '../../domain/usecase/delete_receipt.dart';
import '../../domain/usecase/get_receipt.dart';

part 'receipt_state.dart';

class ReceiptCubit extends Cubit<ReceiptState> {
  ReceiptCubit(
    this._getReceipt,
    this._addReceipt,
    this._deleteReceipt,
    this._getSpecificReceipt,
  ) : super(ReceiptInitial());

  final GetReceipt _getReceipt;
  final AddReceipt _addReceipt;
  final DeleteReceipt _deleteReceipt;
  final GetSpecificReceipt _getSpecificReceipt;
  void getReceipt() async {
    emit(Loading());
    final either = await _getReceipt.call();
    either.fold((l) => emit(Error()), (r) {
      if (r.isEmpty) {
        emit(Empty(msg: 'Empty'));
      } else {
        print('b4 ${r.length}');
        emit(Loaded(receipts: r));
        print('after ${r.length}');
      }
    });
  }

  void addReceipt(ReceiptEntity receipt) async {
    await _addReceipt.call(receipt: receipt);
  }

  void searchReceipts(String text) async {
    emit(Loading());
    final either = await _getSpecificReceipt.call(text);
    either.fold((l) => emit(Error()), (r) => emit(Loaded(receipts: r)));
  }
}
