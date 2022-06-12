import 'package:eyyplus/domain/entity/productentity.dart';
import 'package:eyyplus/presentation/screens/main_screen.dart';

import '../../depedency.dart';
import '../../domain/entity/receiptentity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:intl/intl.dart';
import '../receipt_cubit/receipt_cubit.dart';
import '../widgets/add_appbar.dart';
import 'second_add_screen.dart';
import '../widgets/customquicksandtext.dart';

import '../../core/color/color.dart';

class AddScreen extends StatefulWidget {
  final ProductEntity? product;

  const AddScreen({
    Key? key,
    this.product,
  }) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _receipt = TextEditingController();

  final _date = TextEditingController();

  final _supplier = TextEditingController();
  int totalquantity = 0;
  double totalprice = 0;
  double _totalprice = 0;
  @override
  void initState() {
    totalprice += widget.product?.price ?? 0;
    print('price: ${widget.product?.price ?? 0}');
    print('totalprice: $totalprice');
    _date.text = DateFormat('dd MMM, yyyy - KK:mm a').format(DateTime.now());
    super.initState();
  }

  List<ProductEntity> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const AddAppBar(),
              const CustomQuickSandText(text: 'Receipt No.'),
              const SizedBox(height: 15),
              CustomTextField(
                'Receipt No.',
                controller: _receipt,
                color: const Color(0xff58739B).withOpacity(0.40),
                formKey: const ValueKey('Receipt'),
                radius: 0,
                keyboard: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the receipt no';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 15),
              const CustomQuickSandText(text: 'Date'),
              const SizedBox(height: 15),
              CustomTextField(
                _date.text,
                controller: _date,
                radius: 0,
                color: const Color(0xff58739B).withOpacity(0.40),
                formKey: const ValueKey('Date'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the date';
                  } else {
                    return null;
                  }
                },
                suffix: IconButton(
                    onPressed: () async {
                      DateTime? datetime = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050),
                      );
                      setState(() {
                        _date.text = DateFormat().format(datetime!);
                      });
                    },
                    icon: const Icon(Icons.calendar_today)),
              ),
              const SizedBox(height: 15),
              const CustomQuickSandText(text: 'Supplier Name'),
              const SizedBox(height: 15),
              CustomTextField(
                'Supplier Name',
                controller: _supplier,
                formKey: const ValueKey('Supplier'),
                radius: 0,
                color: const Color(0xff58739B).withOpacity(0.40),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the supplier name';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 15),
              const HDivider(
                color: Color(0xffBE5108),
                splitter: 50,
                isDot: true,
              ),
              const SizedBox(height: 15),
              const CustomQuickSandText(
                text: 'Add Products',
                weight: FontWeight.w700,
                size: 16,
              ),
              const SizedBox(height: 15),
              products.isEmpty
                  ? Container(
                      height: 89,
                      width: 428,
                      color: const Color(0xff58739B).withOpacity(0.40),
                      child: Center(
                        child: CustomQuickSandText(
                          text: 'No products yet.',
                          weight: FontWeight.w700,
                          size: 12,
                          color: const Color(0xff000000).withOpacity(0.40),
                        ),
                      ),
                    )
                  : Column(
                      children: products.map((product) {
                        final isOdd = products.indexOf(product) % 2 == 0;
                        return ListTile(
                          tileColor: isOdd
                              ? MAIN_COLOR.withOpacity(0.2)
                              : Colors.white,
                          title: CustomQuickSandText(
                            text: product.product,
                            weight: FontWeight.w700,
                          ),
                          trailing: CustomQuickSandText(
                              text:
                                  '₱${product.totalprice.toStringAsFixed(2)}'),
                          subtitle: Row(
                            children: [
                              const SizedBox(height: 8),
                              Container(
                                width: 67,
                                height: 19,
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xff0CBE08).withOpacity(0.66),
                                ),
                                child: Center(
                                  child: CustomQuickSandText(
                                    text: "₱${product.price}",
                                    color: Colors.white,
                                  ),
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
                                      text: "${product.quantity} ITEMS",
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 67,
                                height: 19,
                                decoration: const BoxDecoration(
                                  color: PRIMARY_COLOR,
                                ),
                                child: Center(
                                  child: CustomQuickSandText(
                                    text: "${product.discount}% OFF",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: InkWell(
                    onTap: () async {
                      if (_receipt.text.isEmpty ||
                          _date.text.isEmpty ||
                          _supplier.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: CustomQuickSandText(
                              text: 'Please fill up the text field',
                            ),
                          ),
                        );
                      } else {
                        var val = await Navigator.push<ProductEntity>(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondAddScreen(
                                      receipno: _receipt.text,
                                      date: _date.text,
                                      supplier: _supplier.text,
                                    )));

                        if (val != null) {
                          products.add(val);
                          setState(() {});
                          final discount = val.discount / 100;
                          final multipliedprice = val.price * val.quantity;
                          final discountvalue = multipliedprice * discount;
                          totalprice = multipliedprice - discountvalue;
                          _totalprice = _totalprice + totalprice;
                          totalquantity = totalquantity + val.quantity;
                        }
                      }
                    },
                    child: Container(
                      height: 41,
                      width: 362,
                      color: const Color(0xff58739B),
                      child: Center(
                        child: CustomQuickSandText(
                          text: products.isEmpty
                              ? 'ADD NEW PRODUCT +'
                              : 'ADD MORE PRODUCT +',
                          weight: FontWeight.w700,
                          size: 16,
                          color: const Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              products.isEmpty
                  ? const SizedBox.shrink()
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: InkWell(
                          onTap: () async {
                            final localreceipt = ReceiptEntity(
                              receiptno: _receipt.text,
                              date: _date.text,
                              supplier: _supplier.text,
                              product: products,
                              totalquantity: totalquantity,
                              totalprice: _totalprice,
                            );
                            context
                                .read<ReceiptCubit>()
                                .addReceipt(localreceipt);
                            BlocProvider.value(
                              value: sl<ReceiptCubit>()..getReceipt(),
                              child: MainScreen(),
                            );

                            Navigator.pop(context, true);
                          },
                          child: Container(
                            height: 41,
                            width: 362,
                            color: const Color(0xff58739B),
                            child: const Center(
                              child: CustomQuickSandText(
                                text: 'SUBMIT RECEIPT',
                                weight: FontWeight.w700,
                                size: 16,
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
