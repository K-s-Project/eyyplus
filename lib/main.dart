import 'package:eyyplus/data/models/supplier_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/color/color.dart';
import 'data/models/product_suggestion.dart';
import 'data/models/productmodel.dart';
import 'data/models/receiptmodel.dart';
import 'depedency.dart' as di;
import 'depedency.dart';
import 'presentation/receipt_cubit/receipt_cubit.dart';
import 'presentation/screens/main_screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductSuggestionModelAdapter());
  Hive.registerAdapter(ReceiptModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(SupplierSuggestionModelAdapter());
  await Hive.openBox('suggestions_fixed1');
  await Hive.openBox('aplus_products1');
  await Hive.openBox('aplus_receipts1');
  await Hive.openBox('supplier_suggestions');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'A+',
      theme: ThemeData(
        primaryColor: MAIN_COLOR,
        appBarTheme:
            const AppBarTheme(iconTheme: IconThemeData(color: PRIMARY_COLOR)),
        // dividerColor: const Color(0xffBE5108),
      ),
      home: BlocProvider<ReceiptCubit>(
        create: (context) => sl<ReceiptCubit>()..getReceipt(),
        child: const MainScreen(),
      ),
    );
  }
}
