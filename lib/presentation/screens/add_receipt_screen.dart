// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:eyyplus/depedency.dart';
import 'package:eyyplus/domain/entity/productentity.dart';

import '../../core/color/color.dart';
import '../../domain/entity/receiptentity.dart';
import '../receipt_cubit/receipt_cubit.dart';
import '../widgets/customquicksandtext.dart';
import 'second_add_screen.dart';

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
    _date.text = DateFormat('dd MMM yyyy, KK:mm a').format(DateTime.now());
    super.initState();
  }

  List<ProductEntity> products = [];

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomQuickSandText(text: 'Receipt No.'),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomTextField(
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
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomQuickSandText(text: 'Date'),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                readOnly: true,
                controller: _date,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () async {
                      DateTime? datetime = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050),
                      );
                      setState(() {
                        _date.text = DateFormat('dd MMM yyyy, KK:mm a')
                            .format(datetime!);
                      });
                    },
                    icon: const Icon(Icons.calendar_today),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  filled: true,
                  fillColor: const Color(0xff58739B).withOpacity(0.2),
                  focusColor: const Color(0xff58739B),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(
                      color: const Color(0xff58739B).withOpacity(0.2),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: const BorderSide(style: BorderStyle.none),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  hintText: _date.text,
                  hintStyle: GoogleFonts.quicksand(
                    color: Colors.grey,
                  ),
                ),
                style: GoogleFonts.quicksand(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomQuickSandText(text: 'Supplier Name'),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomTextField(
                'Supplier Name',
                controller: _supplier,
                formKey: const ValueKey('Supplier'),
                radius: 0,
                color: const Color(0xff58739B).withOpacity(0.40),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]').hasMatch(value)) {
                    return 'Enter the correct supplier name';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(height: 15),
            const HDivider(
              color: Color(0xffBE5108),
              splitter: 50,
              isDot: true,
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomQuickSandText(
                text: 'Add Products',
                weight: FontWeight.w700,
                size: 16,
              ),
            ),
            const SizedBox(height: 15),
            products.isEmpty
                ? Container(
                    height: 89,
                    width: double.infinity,
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
                        // isThreeLine: true,
                        tileColor:
                            isOdd ? MAIN_COLOR.withOpacity(0.2) : Colors.white,
                        title: CustomQuickSandText(
                          text: product.product,
                          weight: FontWeight.w700,
                        ),
                        trailing: CustomQuickSandText(
                            text: '₱${product.totalprice.toStringAsFixed(2)}'),
                        subtitle: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
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
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
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
                                                setState(() {
                                                  products.remove(product);
                                                });
                                                Navigator.pop(context);
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
                                    });
                              },
                              child: Container(
                                height: 19,
                                decoration:
                                    const BoxDecoration(color: Colors.red),
                                child: const Center(
                                  child: CustomQuickSandText(
                                    text: "DELETE THIS PRODUCT",
                                    color: Colors.white,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
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
                              builder: (context) => BlocProvider<ReceiptCubit>(
                                    create: (context) => sl<ReceiptCubit>(),
                                    child: SecondAddScreen(
                                      receipno: _receipt.text,
                                      date: _date.text,
                                      supplier: _supplier.text,
                                    ),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      height: 41,
                      width: double.infinity,
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
                          context.read<ReceiptCubit>().addReceipt(localreceipt);

                          Navigator.pop(context, true);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            height: 41,
                            width: double.infinity,
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
                  ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
