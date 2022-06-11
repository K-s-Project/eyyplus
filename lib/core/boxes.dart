import 'package:hive/hive.dart';

import '../data/models/receiptmodel.dart';

class Boxes {
  static Box<ReceiptModel> getReceipt() => Hive.box('recie');
}
