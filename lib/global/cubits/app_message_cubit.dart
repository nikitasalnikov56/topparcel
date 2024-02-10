import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topparcel/data/models/response/system_message_response.dart';
import 'package:topparcel/helpers/exceptions.dart';

import '../../data/enums/enums.dart';
import '../../helpers/utils/error_handler.dart';

part '../states/app_message_state.dart';

class AppMessageCubit extends Cubit<AppMessageState> {
  // Статические методы для прослушивания и получения кубита
  static AppMessageState watchState(BuildContext context) =>
      context.watch<AppMessageCubit>().state;
  static AppMessageCubit read(BuildContext context) =>
      context.read<AppMessageCubit>();

  AppMessageCubit({
    required this.errorHandler,
  }) : super(AppMessageState(
            message: '', messageType: MessageType.none, systemMessages: []));

  final ErrorHandler errorHandler;

  void refreshApp() {
    emit(AppMessageState(
        message: '', messageType: MessageType.none, systemMessages: []));
  }

  void showDioErrorMessage(DioError e) {
    final String error = errorHandler.handle(e);
    if (e.error is ServerErrorException) {
      emit(AppMessageState(
          message: (e.error as ServerErrorException).text,
          messageType: MessageType.error,
          systemMessages: []));
    } else if (e.type == DioErrorType.connectionTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.sendTimeout) {
      emit(AppMessageState(
          message:
              'Истекло время соединения, пороверьте соединение с интернетом.',
          messageType: MessageType.networkException,
          systemMessages: []));
    } else if (e.response?.statusCode == 403) {
      emit(AppMessageState(
          message: 'Истек срок авторизации',
          messageType: MessageType.deauthorise,
          durationInSeconds: 10,
          systemMessages: []));
    } else {
      if (e.error is SocketException) {
        log('🌍🌍 Ошибка на contract_details_cubit: $error');
        emit(AppMessageState(
            message: error,
            messageType: MessageType.networkException,
            systemMessages: []));
      } else {
        log('🔥🔥 Ошибка на contract_details_cubit: $error');
        emit(AppMessageState(
            message: error,
            messageType: MessageType.error,
            systemMessages: []));
      }
    }
  }

  void showErrorMessage(String message) {
    emit(AppMessageState(
        message: message, messageType: MessageType.error, systemMessages: []));
  }

  void showInformationMessage(String message) {
    emit(AppMessageState(
        message: message, messageType: MessageType.info, systemMessages: []));
  }
}
