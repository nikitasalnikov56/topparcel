part of '../cubits/bottom_sheet_cubit.dart';

class BottomSheetState {
  final BottomSheetStatus status;

  BottomSheetState({required this.status});

  BottomSheetState copyWith({
    BottomSheetStatus? status,
  }) {
    return BottomSheetState(
      status: status ?? this.status,
    );
  }
}

abstract class BottomSheetStatus {}

class OkBottomSheetStatus extends BottomSheetStatus {}

class ModalBottomSheetStatus extends BottomSheetStatus {
  final Widget bottomSheetWidget;

  ModalBottomSheetStatus({required this.bottomSheetWidget});
}
