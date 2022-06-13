import 'package:eyyplus/data/datasource/local_data_source.dart';
import 'package:eyyplus/data/models/product_suggestion.dart';

import 'core/color/color.dart';
import 'presentation/receipt_cubit/receipt_cubit.dart';
import 'package:flutter/material.dart';
import 'data/models/productmodel.dart';
import 'presentation/screens/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'depedency.dart' as di;
import 'data/models/receiptmodel.dart';
import 'depedency.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductSuggestionModelAdapter());
  Hive.registerAdapter(ReceiptModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  await Hive.openBox('products_suggestions6');
  await Hive.openBox('product_storage_edite6');
  await Hive.openBox('aplus_receipt_edited6');

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
