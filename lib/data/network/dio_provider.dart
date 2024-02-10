import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../helpers/exceptions.dart';
import '../../services/env_service.dart';
import '../../services/service_locator.dart';

/// Провайдер Dio с настройками.
class DioProvider {
  Dio get() {
    BaseOptions options = BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
    );

    final dio = Dio(options);

    dio.options.baseUrl = '';

    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.baseUrl = sl<EvnService>().baseURL;
        log('🚀🚀🚀---------------------------------🚀🚀🚀');
        log('| REQUEST SENT:');
        log('|    🟡 FULL URL: ${options.uri.toString()}');
        log('|    🟡 PARAMETERS: ${options.data.toString()}');
        log('|    🟡 PATH/QUERY: ${options.path.toString()}');
        log('|    🟡 HEADERS: ${options.headers.toString()}');
        log('🚀🚀🚀---------------------------------🚀🚀🚀');
        log('\n');
        handler.next(options);
      },
      onResponse: (e, handler) {
        if (e.data.containsKey('status') && e.data['status'] != 200) {
          final serverError = ServerErrorException.fromJson(e.data);
          log('-----------------❌❌❌❌❌❌-----------------');
          log('| RESPONSE RECIEVED:');
          log('|    🔴 REQUEST: ${e.realUri.toString()}');
          log('|    🔴 DATA: ${e.data}');
          log('-----------------❌❌❌❌❌-----------------');
          log('\n');
          throw serverError;
        }
        if (e.data.containsKey('error')) {
          final serverError = ServerErrorException.fromJson(e.data['error']);
          log('-----------------❌❌❌❌❌❌-----------------');
          log('| RESPONSE RECIEVED:');
          log('|    🔴 REQUEST: ${e.realUri.toString()}');
          log('|    🔴 DATA: ${e.data.toString()}');
          log('-----------------❌❌❌❌❌-----------------');
          log('\n');
          throw serverError;
        } else {
          log('-----------------✅✅✅✅✅-----------------');
          log('| RESPONSE RECIEVED:');
          log('|    🟢 REQUEST: ${e.realUri.toString()}');
          log('|    🟢 DATA: ${e.data.toString()}');
          log('-----------------✅✅✅✅✅-----------------');
          log('\n');
          handler.next(e);
        }
      },
    ));

    return dio;
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
