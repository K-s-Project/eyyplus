// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:eyyplus/domain/usecase/add_products.dart';
import 'package:meta/meta.dart';

import '../../domain/entity/product_suggestion.dart';
import '../../domain/entity/receiptentity.dart';
import '../../domain/usecase/add_receipt.dart';
import '../../domain/usecase/delete_receipt.dart';
import '../../domain/usecase/get_receipt.dart';
import '../../domain/usecase/get_specific_receipt.dart';

part 'receipt_state.dart';

class ReceiptCubit extends Cubit<ReceiptState> {
  ReceiptCubit(
    this._getReceipt,
    this._addReceipt,
    this._deleteReceipt,
    this._getSpecificReceipt,
    this._addProducts,
  ) : super(ReceiptInitial());

  final GetReceipt _getReceipt;
  final AddReceipt _addReceipt;
  final DeleteReceipt _deleteReceipt;
  final GetSpecificReceipt _getSpecificReceipt;
  final AddProducts _addProducts;

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
    emit(Loading());
    print('Add Receipt $receipt');
    await _addReceipt.call(receipt: receipt);
  }

  void delete(String receiptno) async {
    emit(Loading());
    await _deleteReceipt.call(receiptno: receiptno);
  }

  void searchReceipts(String text) async {
    emit(Loading());
    final either = await _getSpecificReceipt.call(text);
    either.fold((l) => emit(Error()), (r) {
      if (r.isEmpty) {
        emit(Empty(msg: 'no result'));
      } else {
        emit(Loaded(receipts: r));
      }
    });
  }

  void addProduct(ProductSuggestionEntity products) async {
    emit(Loading());
    await _addProducts.call(products);
  }
}
