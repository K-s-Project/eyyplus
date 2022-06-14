import 'package:get_it/get_it.dart';

import 'data/datasource/local_data_source.dart';
import 'data/repository/receipt_repository_impl.dart';
import 'domain/repository/receipt_repository.dart';
import 'domain/usecase/add_products.dart';
import 'domain/usecase/add_receipt.dart';
import 'domain/usecase/delete_receipt.dart';
import 'domain/usecase/get_receipt.dart';
import 'domain/usecase/get_specific_receipt.dart';
import 'presentation/receipt_cubit/receipt_cubit.dart';

final sl = GetIt.instance;

Future init() async {
  sl.registerFactory(
    () => ReceiptCubit(
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );

  sl.registerLazySingleton(() => GetReceipt(repo: sl()));
  sl.registerLazySingleton(() => AddReceipt(repo: sl()));
  sl.registerLazySingleton(() => DeleteReceipt(repo: sl()));
  sl.registerLazySingleton(() => GetSpecificReceipt(repo: sl()));
  sl.registerLazySingleton(() => AddProducts(repo: sl()));

  sl.registerLazySingleton<ReceiptRepository>(
      () => ReceiptRepositoryImpl(local: sl()));
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
}
