import '../receipt_cubit/receipt_cubit.dart';
import '../widgets/customquicksandtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/widgets/textfield.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import '../../depedency.dart';
import 'add_receipt_screen.dart';
import 'package:iconify_flutter/icons/carbon.dart';

import 'detail_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isRefresh = false;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 35,
                        width: 35,
                        child: Image.asset(
                          'assets/aplus1.2.png',
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: CustomTextField(
                          'search something...',
                          controller: searchController,
                          color: const Color(0xff58739B).withOpacity(0.40),
                          onChanged: (value) {
                            context.read<ReceiptCubit>().searchReceipts(value);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      IconButton(
                        onPressed: () async {
                          bool refresh = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BlocProvider<ReceiptCubit>(
                                create: (context) => sl<ReceiptCubit>(),
                                child: const AddScreen(),
                              ),
                            ),
                          );
                          isRefresh = refresh;
                          if (isRefresh) {
                            context.read<ReceiptCubit>().getReceipt();
                          }
                        },
                        icon: Iconify(
                          Carbon.document_add,
                          size: 35,
                          color: ThemeData().primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: CustomQuickSandText(
                      text: 'Receipts',
                      size: 18,
                      weight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  BlocBuilder<ReceiptCubit, ReceiptState>(
                      builder: (context, state) {
                    if (state is Loaded) {
                      return ExpansionPanelList.radio(
                        dividerColor: Colors.transparent,
                        elevation: 0,
                        children: state.receipts.map((receipt) {
                          final isOdd =
                              state.receipts.indexOf(receipt) % 2 == 0;
                          return ExpansionPanelRadio(
                            backgroundColor: isOdd
                                ? const Color(0xffD9D9D9).withOpacity(0.40)
                                : Colors.white,
                            value: receipt,
                            headerBuilder: (context, isExpanded) => ListTile(
                              title: CustomQuickSandText(
                                text: '#${receipt.receiptno} - ${receipt.date}',
                                weight: FontWeight.w700,
                                size: 12,
                                color: const Color(0xff000000),
                              ),
                              subtitle: Column(
                                children: [
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 19,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff0CBE08)
                                              .withOpacity(0.66),
                                        ),
                                        child: Center(
                                          child: CustomQuickSandText(
                                              text:
                                                  "₱${receipt.totalprice.toStringAsFixed(2)}"),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 80,
                                        height: 19,
                                        decoration: const BoxDecoration(
                                          color: Color(0xff309FF0),
                                        ),
                                        child: Center(
                                          child: CustomQuickSandText(
                                            text:
                                                "${receipt.totalquantity} ITEMS",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: receipt.product.map((e) {
                                      return e.product.length > 3
                                          ? CustomQuickSandText(
                                              text:
                                                  '${e.product.toUpperCase()}, ',
                                              weight: FontWeight.w600,
                                              size: 10,
                                            )
                                          : CustomQuickSandText(
                                              text: '${e.product} ,',
                                              weight: FontWeight.w600,
                                              size: 10,
                                            );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            body: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomQuickSandText(
                                        text: 'ITEMS INCLUDED',
                                        weight: FontWeight.w700,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children:
                                            receipt.product.map((product) {
                                          return CustomQuickSandText(
                                            text: product.discount == 0
                                                ? '${product.quantity}x ${product.product}   no discount'
                                                : '${product.quantity}x ${product.product}    ${product.discount}%off',
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                      receipt: receipt),
                                            ),
                                          );
                                        },
                                        child: const CustomQuickSandText(
                                          text: 'VIEW DETAILS',
                                          weight: FontWeight.bold,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children:
                                            receipt.product.map((product) {
                                          return CustomQuickSandText(
                                            text:
                                                '₱${product.totalprice.toStringAsFixed(2)}',
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    } else if (state is Empty) {
                      return Container(
                        height: 89,
                        width: 428,
                        color: const Color(0xffBCC7D7).withOpacity(0.40),
                        child:
                            Center(child: CustomQuickSandText(text: state.msg)),
                      );
                    }
                    return const SizedBox.shrink();
                  })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
