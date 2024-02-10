import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../states/bottom_sheet_state.dart';

class BottomSheetCubit extends Cubit<BottomSheetState> {
  // Статические методы для прослушивания и получения кубита
  static BottomSheetState watchState(BuildContext context) =>
      context.watch<BottomSheetCubit>().state;
  static BottomSheetCubit read(BuildContext context) =>
      context.read<BottomSheetCubit>();
  BottomSheetCubit() : super(BottomSheetState(status: OkBottomSheetStatus()));

  void showModalBottomSheet(Widget bottomSheetWidget) {
    emit(state.copyWith(
        status: ModalBottomSheetStatus(bottomSheetWidget: bottomSheetWidget)));
  }

  void closeBottomSheet() {
    emit(state.copyWith(status: OkBottomSheetStatus()));
  }
}
