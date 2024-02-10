import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topparcel/data/local_db/email_storage.dart';
import 'package:topparcel/global/cubits/app_message_cubit.dart';
import 'package:topparcel/interfaces/user_repository.dart';

import '../../data/models/response/tracking_number_response.dart';

part '../states/track_parcel_state.dart';

class TrackParcelCubit extends Cubit<TrackParcelState> {
  // Статические методы для прослушивания и получения кубита
  static TrackParcelState watchState(BuildContext context) =>
      context.watch<TrackParcelCubit>().state;
  static TrackParcelCubit read(BuildContext context) =>
      context.read<TrackParcelCubit>();
  TrackParcelCubit({
    required UserRepository trackParcelRepository,
    required AppMessageCubit appMessageCubit,
    required this.emailStorage,
  })  : _userRepository = trackParcelRepository,
        _appMessageCubit = appMessageCubit,
        super(
          TrackParcelState(
            status: LoadingTrackParcelStatus(),
            eventsList: [],
            email: '',
          ),
        );

  final UserRepository _userRepository;
  final AppMessageCubit _appMessageCubit;
  final EmailStorage emailStorage;

  void init() async {
    addEmail(emailStorage.email);
  }

  void addEmail(String email) {
    emit(state.copyWith(email: email));
  }

  Future<void> trackingNumber(String trakingNumber) async {
    try {
      final result =
          await _userRepository.trackingNumber(trakingNumber, state.email);
      emit(state.copyWith(
          status: OkTrackParcelStatus(), eventsList: result.events));
    } on DioError catch (e) {
      _appMessageCubit.showDioErrorMessage(e);
    }
  }
}
