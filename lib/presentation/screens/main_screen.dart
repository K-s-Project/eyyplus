import 'dart:convert';

import 'package:general/general.dart';
import 'package:intl/intl.dart';

import '../../core/utils/csv_export.dart';
import '../../domain/entity/productentity.dart';
import '../../domain/entity/receiptentity.dart';
import '../receipt_cubit/receipt_cubit.dart';
import '../widgets/customquicksandtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                        'Search something',
                        controller: searchController,
                        color: const Color(0xff58739B).withOpacity(0.40),
                        onChanged: (value) {
                          context.read<ReceiptCubit>().searchReceipts(value);
                        },
                        prefix: const Icon(
                          Icons.search,
                          size: 25,
                          color: Color(0xff58739B),
                        ),
                        radius: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () async {
                        bool? refresh = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BlocProvider<ReceiptCubit>(
                              create: (context) => sl<ReceiptCubit>(),
                              child: const AddScreen(),
                            ),
                          ),
                        );

                        if (refresh ?? false) {
                          context.read<ReceiptCubit>().getReceipt();
                        }
                      },
                      child: Row(
                        children: const [
                          CustomQuickSandText(
                            text: 'Add',
                            size: 18,
                            weight: FontWeight.w700,
                            color: Color(0xff58739B),
                          ),
                          Iconify(
                            Carbon.document_add,
                            size: 35,
                            color: Color(0xff58739B),
                          ),
                        ],
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
                  padding: EdgeInsets.only(left: 14.0, bottom: 14),
                  child: CustomQuickSandText(
                    text: 'Receipts',
                    size: 18,
                    weight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    BlocBuilder<ReceiptCubit, ReceiptState>(
                        builder: (context, state) {
                      if (state is Loaded) {
                        return TextButton(
                            onPressed: () async {
                              //Export function
                              final result =
                                  await CsvExportUtils.export(state.receipts);
                              if (result) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.green,
                                    duration: Duration(milliseconds: 120),
                                    content: CustomQuickSandText(
                                      text: 'Export Successfully!',
                                      weight: FontWeight.bold,
                                      color: Color(0xff58739B),
                                    ),
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: CustomQuickSandText(
                                      text: 'Go to your Downloads Folder',
                                    ),
                                  ),
                                );

                                setState(() {});
                              }
                            },
                            child: const CustomQuickSandText(
                              text: 'Export',
                              weight: FontWeight.bold,
                              color: Color(0xff58739B),
                              size: 16,
                            ));
                      }
                      return const SizedBox();
                    }),
                    TextButton(
                        onPressed: () async {
                          //Import function
                          final receipts =
                              await CsvImport.openFileExplorer(mounted);

                          receipts.removeAt(0);
                          for (var receipt in receipts) {
                            final rawproducts = json.decode(receipt[5]) as List;

                            final localproducts = rawproducts
                                .map((e) => ProductEntity.fromMap(
                                    e as Map<String, dynamic>))
                                .toList();
                            final localreceipt = ReceiptEntity(
                                date: receipt[1].toString(),
                                product: localproducts,
                                receiptno: receipt[0].toString(),
                                supplier: receipt[2].toString(),
                                totalquantity:
                                    int.tryParse(receipt[3].toString()) ?? 0,
                                totalprice:
                                    double.tryParse(receipt[4].toString()) ??
                                        0.0);

                            context
                                .read<ReceiptCubit>()
                                .addReceipt(localreceipt);
                            context.read<ReceiptCubit>().getReceipt();
                          }
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: const Duration(seconds: 1),
                              backgroundColor: Colors.green,
                              content: CustomQuickSandText(
                                  text:
                                      'Import Successfully! ${receipts.length} Receipts')));
                        },
                        child: const CustomQuickSandText(
                          text: 'Import',
                          weight: FontWeight.bold,
                          color: Color(0xff58739B),
                          size: 16,
                        )),
                  ],
                ),
                BlocBuilder<ReceiptCubit, ReceiptState>(
                    builder: (context, state) {
                  if (state is Loaded) {
                    return Column(
                      children: [
                        ExpansionPanelList.radio(
                          dividerColor: Colors.transparent,
                          elevation: 0,
                          children: state.receipts.map((receipt) {
                            final isOdd =
                                state.receipts.indexOf(receipt) % 2 == 0;
                            return ExpansionPanelRadio(
                              backgroundColor: isOdd
                                  ? const Color(0xffBCC7D7)
                                  : Colors.white,
                              value: receipt,
                              headerBuilder: (context, isExpanded) => SizedBox(
                                height: 100,
                                width: 428,
                                child: InkWell(
                                  onTap: () async {
                                    bool? isrefreshed = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider<ReceiptCubit>(
                                          create: (context) =>
                                              sl<ReceiptCubit>(),
                                          child: DetailScreen(receipt: receipt),
                                        ),
                                      ),
                                    );
                                    if (isrefreshed ?? false) {
                                      context.read<ReceiptCubit>().getReceipt();
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: ListTile(
                                      title: CustomQuickSandText(
                                        text:
                                            '#${receipt.receiptno} - ${receipt.date}',
                                        weight: FontWeight.w700,
                                        size: 14,
                                        color: const Color(0xff000000),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Container(
                                                width: 90,
                                                height: 19,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xff0CBE08)
                                                      .withOpacity(0.66),
                                                ),
                                                child: Center(
                                                  child: CustomQuickSandText(
                                                    text: NumberFormat.currency(
                                                            locale: 'fil',
                                                            symbol: '₱',
                                                            decimalDigits: 2)
                                                        .format(
                                                            receipt.totalprice),
                                                    color: Colors.white,
                                                    size: 12,
                                                    weight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Container(
                                                width: 90,
                                                height: 19,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xff309FF0),
                                                ),
                                                child: Center(
                                                  child: CustomQuickSandText(
                                                    text:
                                                        "${receipt.product.length} PRODUCTS",
                                                    color: Colors.white,
                                                    size: 12,
                                                    weight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          CustomQuickSandText(
                                            text: receipt.supplier,
                                            weight: FontWeight.w700,
                                            color: Color(0xffBE5108),
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              body: Column(
                                children: [
                                  const Divider(
                                    color: Color(0xff58739B),
                                    thickness: 1,
                                  ),
                                  Padding(
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
                                              children: receipt.product
                                                  .map((product) {
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
                                              onTap: () async {
                                                bool? isrefreshed =
                                                    await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        BlocProvider<
                                                            ReceiptCubit>(
                                                      create: (context) =>
                                                          sl<ReceiptCubit>(),
                                                      child: DetailScreen(
                                                          receipt: receipt),
                                                    ),
                                                  ),
                                                );
                                                if (isrefreshed ?? false) {
                                                  context
                                                      .read<ReceiptCubit>()
                                                      .getReceipt();
                                                }
                                              },
                                              child: const CustomQuickSandText(
                                                text: 'VIEW DETAILS',
                                                weight: FontWeight.bold,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: receipt.product
                                                  .map((product) {
                                                return CustomQuickSandText(
                                                  text: NumberFormat.currency(
                                                    locale: 'fil',
                                                    symbol: '₱',
                                                    decimalDigits: 2,
                                                  ).format(product.totalprice),
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  } else if (state is Empty) {
                    return Container(
                      height: 89,
                      width: double.infinity,
                      color: const Color(0xffBCC7D7).withOpacity(0.40),
                      child:
                          Center(child: CustomQuickSandText(text: state.msg)),
                    );
                  } else if (state is Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is Error) {
                    return Container(
                      height: 89,
                      width: double.infinity,
                      color: const Color(0xffBCC7D7).withOpacity(0.40),
                      child: const Center(
                        child: CustomQuickSandText(
                          text: 'Something went wrong',
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
