import 'package:general/service/csv.dart';

import '../../domain/entity/receiptentity.dart';

class CsvExportUtils {
  static Future<bool> export(List<ReceiptEntity> receipts) async {
    List<List<dynamic>> data = receipts.map((e) {
      List<dynamic> row = List.empty(growable: true);
      row.add(e.receiptno);
      row.add(e.date);
      row.add(e.supplier);
      row.add(e.totalquantity);
      row.add(e.totalprice);
      row.add(e.product.toList().map((e) => e.toJson()).toList());

      return row;
    }).toList();

    print(data);

    final result = await CsvExport.getCsv([
      [
        'Receipt No.',
        'Date',
        'Supplier',
        'Quantity',
        'Price',
        'Product (Encoded)',
      ],
      ...data
    ]);
    return result;
  }
}
