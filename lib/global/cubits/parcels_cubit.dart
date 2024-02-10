import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topparcel/data/local_db/email_storage.dart';
import 'package:topparcel/data/models/app_model/ordering_step_one_model.dart';
import 'package:topparcel/data/models/app_model/parcel_content_model.dart';
import 'package:topparcel/data/models/requests/create_parcel_request.dart';
import 'package:topparcel/data/models/requests/create_rate_request.dart';
import 'package:topparcel/data/models/response/fetch_country_response.dart';
import 'package:topparcel/data/models/response/fetch_parcels_response.dart';
import 'package:topparcel/global/cubits/app_message_cubit.dart';
import 'package:topparcel/interfaces/user_repository.dart';

import '../../data/models/response/create_rate_response.dart';

part '../states/parcels_state.dart';

enum StepParcel {
  firstInfo,
  stepOne,
  stepTwo,
  stepThree,
  finish,
  payment,
  successPay
}

enum TypePayment { payPall, creditCard, balance, stripe }

class ParcelsCubit extends Cubit<ParcelsState> {
  // Статические методы для прослушивания и получения кубита
  static ParcelsState watchState(BuildContext context) =>
      context.watch<ParcelsCubit>().state;
  static ParcelsCubit read(BuildContext context) =>
      context.read<ParcelsCubit>();
  ParcelsCubit({
    required UserRepository userRepository,
    required AppMessageCubit appMessageCubit,
    required this.emailStorage,
  })  : _userRepository = userRepository,
        _appMessageCubit = appMessageCubit,
        super(ParcelsState(
          status: LoadingParcelsStatus(),
          countriesList: [],
          newRates: [],
          parcelsList: [],
          selecteCourier: Courier.emptyModel(),
          isInsuarance: false,
          email: '',
        ));

  UserRepository _userRepository;
  final AppMessageCubit _appMessageCubit;
  final EmailStorage emailStorage;

  void init() async {
    await addEmail(emailStorage.email);
    await fetchCountryList();
    await fetchParcels();
  }

  Future<void> addEmail(String email) async {
    emit(state.copyWith(email: email));
  }

  /// Create parcel

  Future<void> createRate(List<Parcel> model) async {
    await _createRate(model);
  }

  void selecteRateParcel(Courier selecteCourier) {
    emit(state.copyWith(
        status: OrderingStepOneStatus(), selecteCourier: selecteCourier));
  }

  void doneStepOneOrdering(OrderingStepOneModel model) {
    emit(state.copyWith(status: OrderingStepTwoStatus(), stepOne: model));
  }

  void doneStepTwoOrdering(List<ParcelContentModel> itemsList) {
    emit(state.copyWith(
        status: OrderingStepThreeStatus(), itemsList: itemsList));
  }

  void doneInsuaranceOrdering(bool isInsuarance) {
    emit(state.copyWith(
        status: OrderingPayStatus(), isInsuarance: isInsuarance));
  }

  void createParcel(ParcelsRequest model) async {
    try {
      final result = await _userRepository.createParcels(model, state.email);
      if (result == 200) {
        emit(state.copyWith(status: SuccessPaymentCreateParcelsStatus()));
      } else {
        emit(state.copyWith(status: ErrorPaymentCreateParcelsStatus()));
      }
    } on DioError catch (e) {
      _appMessageCubit.showDioErrorMessage(e);
    }
  }

  void showCreateParcelPage(StepParcel step) {
    TypePayment typePayment = TypePayment.payPall;
    if (state.status is CreateParcelStatus) {
      typePayment = (state.status as CreateParcelStatus).typePayment;
    }
    emit(state.copyWith(
        status: CreateParcelStatus(step: step, typePayment: typePayment)));
  }

  void updateTypePayment(TypePayment type) {
    final step = (state.status as CreateParcelStatus).step;
    emit(state.copyWith(
        status: CreateParcelStatus(step: step, typePayment: type)));
  }

  /// Network request

  Future<void> fetchCountryList() async {
    try {
      final result = await _userRepository.fetchCountryList(state.email);
      emit(state.copyWith(
          status: OkParcelsStatus(), countriesList: result.countriesList));
    } on DioError catch (e) {
      _appMessageCubit.showDioErrorMessage(e);
    }
  }

  Future<void> _createRate(List<Parcel> model) async {
    try {
      final result = await _userRepository.createRate(model, state.email);
      emit(state.copyWith(
          status: RateParcelsStatus(), ratesList: result.parcelsList));
    } on DioError catch (e) {
      _appMessageCubit.showDioErrorMessage(e);
    }
  }

  Future<void> fetchParcels() async {
    try {
      final result = await _userRepository.fetchParcels(state.email);
      emit(state.copyWith(parcelsList: result));
    } on DioError catch (e) {
      _appMessageCubit.showDioErrorMessage(e);
    }
  }
}
