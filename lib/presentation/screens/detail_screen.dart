import '../../core/color/color.dart';
import '../widgets/row_detail.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/receiptentity.dart';
import 'package:general/widgets/divider.dart';

import '../widgets/customquicksandtext.dart';

class DetailScreen extends StatelessWidget {
  final ReceiptEntity receipt;
  const DetailScreen({
    Key? key,
    required this.receipt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xffBE5108),
                      ),
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    const CustomQuickSandText(
                      text: 'Receipt Detail',
                      weight: FontWeight.w700,
                      size: 18,
                    ),
                  ],
                ),
              ),
              CustomQuickSandText(
                text: "#${receipt.receiptno}",
                size: 12,
                weight: FontWeight.w700,
                color: const Color(0xffBE5108),
              ),
              const SizedBox(
                height: 80,
              ),
              const HDivider(
                color: Color(0xffBE5108),
                splitter: 50,
                isDot: true,
              ),
              const SizedBox(
                height: 15,
              ),
              const RowDetail(
                text1: 'Payment Status',
                text2: 'Paid',
                size: 12,
              ),
              const SizedBox(
                height: 15,
              ),
              const RowDetail(
                text1: 'Payment Option',
                text2: 'Gcash',
                size: 12,
              ),
              const SizedBox(
                height: 15,
              ),
              const HDivider(
                color: Color(0xffBE5108),
                splitter: 50,
                isDot: true,
              ),
              Column(
                children: receipt.product.map((product) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      RowDetail(
                        text1: '${product.quantity} x ${product.product}',
                        text2: '₱${product.totalprice.toStringAsFixed(2)}',
                        size: 12,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RowDetail(
                        text1: 'Supplier Name',
                        text2: receipt.supplier,
                        size: 12,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width,
                        child: product.discount == 0
                            ? CustomQuickSandText(
                                text: 'No Discount',
                                weight: FontWeight.w700,
                                size: 12,
                                color:
                                    const Color(0xff000000).withOpacity(0.60),
                              )
                            : CustomQuickSandText(
                                text: '${product.discount}% Discount',
                                weight: FontWeight.w700,
                                size: 12,
                                color:
                                    const Color(0xff000000).withOpacity(0.60),
                              ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const HDivider(
                        color: Color(0xffBE5108),
                        splitter: 50,
                        isDot: true,
                      ),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 15,
              ),
              const RowDetail(text1: 'Tax', text2: '₱0', size: 12),
              const SizedBox(
                height: 15,
              ),
              RowDetail(
                text1: 'Total',
                text2: '₱${receipt.totalprice.toStringAsFixed(2)}',
                color: PRIMARY_COLOR,
                size: 16,
              ),
              const SizedBox(
                height: 15,
              ),
              const HDivider(
                color: Color(0xffBE5108),
                splitter: 50,
                isDot: true,
              ),
              const SizedBox(
                height: 15,
              ),
              RowDetail(
                text1: 'Date',
                text2: receipt.date,
                size: 12,
              ),
              const SizedBox(
                height: 70,
              ),
              const CustomQuickSandText(
                text: '* * *',
                size: 36,
                weight: FontWeight.w700,
                color: PRIMARY_COLOR,
              ),
              const CustomQuickSandText(
                text:
                    'Thank you for shopping with us. Eisenhower St, Greenhills Cavite',
                size: 12,
                weight: FontWeight.w700,
                color: Color(0xff58739B),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
