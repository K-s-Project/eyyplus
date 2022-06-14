import '../receipt_cubit/receipt_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xffBE5108),
          ),
        ),
        title: const CustomQuickSandText(
          text: 'Receipt Detail',
          weight: FontWeight.w700,
          size: 18,
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomQuickSandText(
              text: "#${receipt.receiptno}",
              size: 12,
              weight: FontWeight.w700,
              color: const Color(0xffBE5108),
            ),
            const SizedBox(
              height: 30,
            ),
            const HDivider(
              color: Color(0xffBE5108),
              splitter: 50,
              isDot: true,
            ),
            RowDetail(
              text1: 'Receipt No.',
              text2: '#${receipt.receiptno}',
              size: 12,
            ),
            RowDetail(
              text1: 'Date',
              text2: receipt.date,
              size: 12,
            ),
            RowDetail(
              text1: 'Supplier Name',
              text2: receipt.supplier,
              size: 12,
            ),
            const HDivider(
              color: Color(0xffBE5108),
              splitter: 50,
              isDot: true,
            ),
            const CustomQuickSandText(
              text: 'Products',
              color: Color(0xffBE5108),
              size: 14,
              weight: FontWeight.w700,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: receipt.product.map((product) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    RowDetail(
                      text1: '${product.quantity} x ${product.product}',
                      text2: NumberFormat.currency(
                              locale: 'fil', symbol: '₱', decimalDigits: 2)
                          .format(product.totalprice),
                      size: 12,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      child: product.discount == 0
                          ? CustomQuickSandText(
                              text: 'No Discount',
                              weight: FontWeight.w700,
                              size: 12,
                              color: const Color(0xff000000).withOpacity(0.60),
                            )
                          : CustomQuickSandText(
                              text: '${product.discount}% Discount',
                              weight: FontWeight.w700,
                              size: 12,
                              color: const Color(0xff000000).withOpacity(0.60),
                            ),
                    ),
                    CustomQuickSandText(
                      text: product.unit.isEmpty ? 'no unit' : product.unit,
                      size: 12,
                      weight: FontWeight.w700,
                      color: const Color(0xff000000).withOpacity(0.60),
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
            RowDetail(
              text1: 'Total',
              text2: NumberFormat.currency(
                locale: 'fil',
                symbol: '₱',
                decimalDigits: 2,
              ).format(receipt.totalprice),
              color: PRIMARY_COLOR,
              size: 16,
            ),
            const HDivider(
              color: Color(0xffBE5108),
              splitter: 50,
              isDot: true,
            ),
            const CustomQuickSandText(
              text: '* * *',
              size: 36,
              weight: FontWeight.w700,
              color: PRIMARY_COLOR,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.0),
              child: CustomQuickSandText(
                align: TextAlign.center,
                text:
                    'Thank you for shopping with us. Eisenhower St, Greenhills Cavite',
                size: 12,
                weight: FontWeight.w700,
                color: Color(0xff58739B),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: const CustomQuickSandText(
                          text: 'Are you sure?',
                          weight: FontWeight.w500,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const CustomQuickSandText(
                              text: 'No',
                              weight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context
                                  .read<ReceiptCubit>()
                                  .delete(receipt.receiptno);
                              Navigator.pop(context);
                              Navigator.pop(context, true);
                            },
                            child: const CustomQuickSandText(
                              text: 'Yes',
                              color: Color(0xffD70B2F),
                              weight: FontWeight.bold,
                            ),
                          )
                        ],
                      );
                    });
              },
              child: const CustomQuickSandText(
                text: 'Delete this receipt',
                size: 12,
                weight: FontWeight.w700,
                color: Color(0xffD70B2F),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
