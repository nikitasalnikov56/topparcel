import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../exceptions.dart';

class AppCustomException implements Exception {
  final String message;

  AppCustomException(this.message);
}

class ErrorHandler {
  String handle(e) {
    switch (e.runtimeType) {
      case AppCustomException:
        return (e as AppCustomException).message;
      case ServerErrorException:
        final serverError = e as ServerErrorException;
        return serverError.text;
      case SocketException:
        return 'Ошибка подключения! Проверьте соединение с интернетом и обновите экран.';
      case DioError:
        final dioError = e as DioError;

        if (dioError.error is ServerErrorException) {
          final serverError = dioError.error as ServerErrorException;
          final response = dioError.requestOptions;
          log('⛔️⛔️⛔️---------------------------------------------------------⛔️⛔️⛔️');
          log('NETWORK ERROR WITH STATUS CODE ${serverError.code}: ${serverError.text}');
          log('\n');
          log('🔴 ERROR SIDE: ${serverError.side}');
          log('🔴 BACKEND CODE: ${serverError.code}');
          log('🔴 BACKEND MESSAGE: ${serverError.text}');
          log('\n');
          log('🟣 REQUEST TO: ${response.uri}\n');
          log('🟣 PARAMETERS: ${response.data}');
          log('🟣 HEADERS: ${response.headers}');
          log('\n');
          log('⛔️⛔️⛔️---------------------------------------------------------⛔️⛔️⛔️');
          log('\n');
          return serverError.text.substring(
              serverError.text.indexOf(']') + 1, serverError.text.length);
        }

        if (dioError.error is SocketException) {
          return 'Ошибка подключения! Проверьте соединение с интернетом и обновите экран.';
        }
        final response = dioError.response;

        if (response?.statusCode == 304) {
          log('⛔️----------------------------⬇️⬇️⬇️-----------------------------⛔️');
          log('NETWORK ERROR WITH STATUS CODE 304: Изменений нет');
          log('\n');
          log('🟠 BACKEND MESSAGE: Изменений нет');
          log('\n');
          log('🟠 REQUEST TO: ${response?.realUri}\n');
          log('🟠 PARAMETERS: ${response?.requestOptions.data}');
          log('🟠 HEADERS: ${response?.headers}');
          log('⛔️----------------------------⬆️⬆️⬆️-----------------------------⛔️');

          return 'Изменений нет';
        }

        String backendMessage = 'Неизвестная ошибка';
        int backendCode = 000;
        String errorSide = '???';
        final data = response?.data;

        if (data != null && data is Map) {
          if (data.containsKey("error") &&
              data['error'] is Map<String, dynamic>) {
            final error = data['error'] as Map<String, dynamic>;
            backendMessage = error['text'] as String;
            backendCode = error['code'] as int;
            errorSide = error['side'] as String;

            backendMessage = backendMessage.substring(
                backendMessage.indexOf(']') + 1, backendMessage.length);
          }
        }
        if (dioError.error != null &&
            dioError.error != '' &&
            dioError.error is String) {
          return dioError.error as String;
        }

        log('⛔️----------------------------⬇️⬇️⬇️-----------------------------⛔️');
        log('NETWORK ERROR WITH STATUS CODE ${response?.statusCode}: $backendMessage');
        log('\n');
        log('🔴 ERROR SIDE: $errorSide');
        log('🔴 BACKEND CODE: $backendCode');
        log('🔴 BACKEND MESSAGE: $backendMessage');
        log('\n');
        log('🟣 REQUEST TO: ${response?.realUri}\n');
        log('🟣 PARAMETERS: ${response?.requestOptions.data}');
        log('🟣 HEADERS: ${response?.headers}');
        log('⛔️----------------------------⬆️⬆️⬆️-----------------------------⛔️');

        return backendMessage;
      default:
        return 'Неизвестная ошибка';
    }
  }
}


/// {
///   "error" : {
///     "text" : "[15] Неверное имя или пароль для пользователя  [31.52.46623]",
///     "code" : 15, 
///     "side" : "Client"
///   }
/// }