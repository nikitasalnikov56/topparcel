part of '../cubits/app_message_cubit.dart';

class AppMessageState {
  final MessageType messageType;
  final String message;
  final int durationInSeconds;
  final List<SystemMessage> systemMessages;
  final bool shouldUpdateApp;

  AppMessageState({
    required this.message,
    required this.messageType,
    this.durationInSeconds = 5,
    required this.systemMessages,
    this.shouldUpdateApp = false,
  });
}
