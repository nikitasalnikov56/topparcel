part of '../cubits/hscode_cubit.dart';

abstract class HscodeState {}

final class HscodeInitial extends HscodeState {}

class HscodeLoadingState extends HscodeState {}

class HscodeLoadedState extends HscodeState {
  final CreateHscodeResponse hscodeResponse;

  HscodeLoadedState(this.hscodeResponse);
}
class HscodeErrorState extends HscodeState {
  final String error;

  HscodeErrorState(this.error);
}