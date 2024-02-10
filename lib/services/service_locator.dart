import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topparcel/data/local_db/email_storage.dart';
import 'package:topparcel/data/local_db/token_storage.dart';
import 'package:topparcel/data/network/user_api.dart';
import 'package:topparcel/interfaces/user_repository.dart';
import 'package:topparcel/repositories/user_repository_impl.dart';

import '../data/local_db/account_storage.dart';
import '../data/local_db/authentication_storage.dart';
import '../data/network/auth_api.dart';
import '../data/network/dio_provider.dart';
import '../helpers/utils/error_handler.dart';
import '../interfaces/auth_repository.dart';
import '../repositories/auth_repository_impl.dart';
import 'env_service.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  sl.registerSingletonAsync(() async => await SharedPreferences.getInstance());
  // Future.delayed(const Duration(seconds: 5));

  sl.registerSingletonAsync<FlutterSecureStorage>(() async {
    return FlutterSecureStorage();
  });

  //Local DB
  // sl.registerLazySingleton<TokenStorage>(() => TokenStorage(prefs: sl()));
  sl.registerLazySingleton<TokenStorage>(
      () => TokenStorage(prefs: sl<FlutterSecureStorage>()));

  // sl.registerLazySingleton<AuthStorage>(() => AuthStorage(prefs: sl()));
  sl.registerLazySingleton<AuthStorage>(
      () => AuthStorage(prefs: sl<FlutterSecureStorage>()));

  sl.registerLazySingleton<AccountStorage>(() => AccountStorage(prefs: sl()));
  sl.registerLazySingleton<EmailStorage>(() => EmailStorage(prefs: sl()));
  // sl.registerLazySingleton<AccountStorage>(
  //     () => AccountStorage(prefs: sl<FlutterSecureStorage>()));

  //Services

  sl.registerLazySingleton<EvnService>(() => EvnService(prefs: sl()));

  //Utilities
  sl.registerLazySingleton<ErrorHandler>(() => ErrorHandler());

  //API
  sl.registerLazySingleton<Dio>(() => DioProvider().get());
  sl.registerLazySingleton<AuthApi>(() => AuthApi(sl()));
  sl.registerLazySingleton<UserApi>(() => UserApi(sl()));

  //Repositories
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      userAPI: sl(),
      tokenStorage: sl(),
    ),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      emailStorage: sl(),
      authApi: sl(),
      authStorage: sl(),
      tokenStorage: sl(),
    ),
  );
}
