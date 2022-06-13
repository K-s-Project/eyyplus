part of 'receipt_cubit.dart';

@immutable
abstract class ReceiptState {}

class ReceiptInitial extends ReceiptState {}

class Loading extends ReceiptState {}

class Loaded extends ReceiptState {
  final List<ReceiptEntity> receipts;
  Loaded({
    required this.receipts,
  });
}

class SuggestionLoaded extends ReceiptState {
  final List<ProductSuggestionEntity> suggestions;
  SuggestionLoaded({
    required this.suggestions,
  });
}

class Error extends ReceiptState {}

class Empty extends ReceiptState {
  final String msg;
  Empty({
    required this.msg,
  });
}
