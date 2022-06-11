import '../../depedency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:intl/intl.dart';

import '../../domain/entity/productentity.dart';
import '../../domain/entity/receiptentity.dart';
import '../receipt_cubit/receipt_cubit.dart';
import '../widgets/add_appbar.dart';
import '../widgets/customquicksandtext.dart';

import 'add_receipt_screen.dart';

class SecondAddScreen extends StatefulWidget {
  final String receipno;
  final String date;
  final String supplier;
  const SecondAddScreen({
    Key? key,
    required this.receipno,
    required this.date,
    required this.supplier,
  }) : super(key: key);

  @override
  State<SecondAddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<SecondAddScreen> {
  final _receipt = TextEditingController();
  final _date = TextEditingController();
  final _supplier = TextEditingController();
  final _product = TextEditingController();
  final _price = TextEditingController();
  final _quantity = TextEditingController();
  final _discount = TextEditingController();
  final _totalp = TextEditingController();

  @override
  void initState() {
    _receipt.text = widget.receipno;
    _date.text = widget.date;
    _supplier.text = widget.supplier;
    super.initState();
  }

  List<ProductEntity> products = [];
  int totalquantity = 0;
  double totalprice = 0;
  double _totalprice = 0;
  int totalq = 0;
  int dc = 0;
  double zero = 0;
  var pricekey = GlobalKey<FormState>();
  var quankey = GlobalKey<FormState>();
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
              const SizedBox(height: 20),
              const CustomQuickSandText(text: 'Receipt No.'),
              const SizedBox(height: 15),
              CustomTextField(
                'Receipt No.',
                controller: _receipt,
                color: const Color(0xff58739B).withOpacity(0.40),
                formKey: const ValueKey('Receipt'),
                radius: 0,
              ),
              const SizedBox(height: 15),
              const CustomQuickSandText(text: 'Date'),
              const SizedBox(height: 15),
              CustomTextField(
                'Date',
                controller: _date,
                radius: 0,
                color: const Color(0xff58739B).withOpacity(0.40),
                formKey: const ValueKey('Date'),
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
              const CustomQuickSandText(text: 'Product Name'),
              const SizedBox(height: 15),
              CustomTextField(
                'Product Name',
                controller: _product,
                formKey: const ValueKey('Product'),
                radius: 0,
                color: const Color(0xff58739B).withOpacity(0.40),
              ),
              const SizedBox(height: 15),
              Row(
                children: const [
                  CustomQuickSandText(text: 'Price'),
                  SizedBox(width: 195),
                  CustomQuickSandText(text: 'Total Price')
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      'Price',
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            _totalp.text = '0';
                          } else {
                            _totalp.text = value;
                            _quantity.clear();
                          }
                        });
                      },
                      controller: _price,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the price';
                        } else {
                          return null;
                        }
                      },
                      formKey: pricekey,
                      radius: 0,
                      color: const Color(0xff58739B).withOpacity(0.40),
                      keyboard: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: CustomTextField(
                      'Total Price',
                      controller: _totalp,
                      radius: 0,
                      defaultData: _totalp.text,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: const [
                  CustomQuickSandText(text: 'Quantity'),
                  SizedBox(width: 170),
                  CustomQuickSandText(text: 'Discount')
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      'Quantity',
                      controller: _quantity,
                      formKey: quankey,
                      radius: 0,
                      color: const Color(0xff58739B).withOpacity(0.40),
                      onChanged: (value) {
                        setState(() {
                          if (pricekey.currentState!.validate()) {
                            if (_quantity.text.isEmpty) {
                              double total = double.parse(_price.text);
                              _totalp.text = total.toString();
                            } else {
                              double total = double.parse(_price.text) *
                                  int.parse(_quantity.text);
                              _totalp.text = total.toString();
                            }
                          } else {
                            _quantity.clear();
                          }
                        });
                      },
                      suffix: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CustomText(
                            'x',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      keyboard: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty && _price.text.isNotEmpty) {
                          return 'Please enter the quantity ';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: CustomTextField(
                      'Discount',
                      controller: _discount,
                      formKey: const ValueKey('Discount'),
                      radius: 0,
                      color: const Color(0xff58739B).withOpacity(0.40),
                      onChanged: (value) {
                        setState(() {
                          if (_discount.text.isEmpty) {
                            final multipliedprice = double.parse(_price.text) *
                                int.parse(_quantity.text);
                            _totalp.text = multipliedprice.toString();
                          } else {
                            final discount = int.parse(_discount.text) / 100;
                            final multipliedprice = double.parse(_price.text) *
                                int.parse(_quantity.text);
                            final discountvalue = multipliedprice * discount;
                            _totalprice = multipliedprice - discountvalue;
                            _totalp.text = _totalprice.toString();
                          }
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please input 0 or above';
                        } else {
                          return null;
                        }
                      },
                      suffix: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CustomText(
                            '%',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      keyboard: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      if (_product.text.isEmpty ||
                          _price.text.isEmpty ||
                          _quantity.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: CustomQuickSandText(
                              text: 'Please fill up text field',
                            ),
                          ),
                        );
                      } else {
                        final discount = int.parse(_discount.text) / 100;
                        final multipliedprice = double.parse(_price.text) *
                            int.parse(_quantity.text);
                        final discountvalue = multipliedprice * discount;
                        _totalprice = multipliedprice - discountvalue;
                        totalprice = totalprice + _totalprice;
                        print('total $totalprice');
                        print('price: ${_totalprice}');
                        final product = ProductEntity(
                          product: _product.text,
                          price: double.parse(_price.text),
                          totalprice: _totalprice,
                          quantity: int.parse(_quantity.text),
                          discount: int.parse(_discount.text),
                        );

                        // products.add(product);
                        // totalquantity =
                        //     totalquantity + int.parse(_quantity.text);
                        // final receipt = ReceiptEntity(
                        //   receiptno: _receipt.text,
                        //   date: _date.text,
                        //   supplier: _supplier.text,
                        //   product: products,
                        //   totalquantity: totalquantity,
                        //   totalprice: totalprice,
                        // );
                        _product.clear();
                        _price.clear();
                        _quantity.clear();
                        _discount.clear();
                        _totalp.clear();
                        setState(() {});
                        print('before pop');
                        Navigator.pop(
                          context,
                          product,
                        );
                      }
                    },
                    child: Container(
                      height: 41,
                      width: 362,
                      color: const Color(0xff58739B),
                      child: const Center(
                        child: CustomQuickSandText(
                          text: 'ADD THIS TO RECEIPT',
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
