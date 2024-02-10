import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topparcel/data/local_db/email_storage.dart';
import 'package:topparcel/data/models/requests/create_address_request.dart';
import 'package:topparcel/data/models/requests/fetch_addresses_request.dart';
import 'package:topparcel/data/models/requests/update_user_request.dart';
import 'package:topparcel/data/models/requests/user_details_request.dart';
import 'package:topparcel/data/models/response/create_pay_response.dart';
import 'package:topparcel/data/models/response/user_details_response.dart';
import 'package:topparcel/global/cubits/app_message_cubit.dart';
import 'package:topparcel/helpers/exceptions.dart';
import 'package:topparcel/interfaces/user_repository.dart';

import '../../data/models/response/fetch_addresses_response.dart';
import '../../helpers/utils/error_handler.dart';

part '../states/user_state.dart';

class UserCubit extends Cubit<UserState> {
  // Статические методы для прослушивания и получения кубита
  static UserState watchState(BuildContext context) =>
      context.watch<UserCubit>().state;
  static UserCubit read(BuildContext context) => context.read<UserCubit>();

  UserCubit({
    required UserRepository userRepository,
    required this.errorHandler,
    required AppMessageCubit appMessageCubit,
    required this.emailStorage,
  })  : _appMessageCubit = appMessageCubit,
        _userRepository = userRepository,
        super(UserState(
          user: UserModel.emptyModel(),
          status: InitialUserStatus(),
          email: '',
          id: -1,
          addressList: [],
        ));

  UserRepository _userRepository;
  final AppMessageCubit _appMessageCubit;
  final EmailStorage emailStorage;

  void addAddress(CreateAddressRequest requestModel,
      {bool isEdit = false}) async {
    try {
      final result = await _userRepository.createAddress(requestModel);
      String successMessage = 'Address created';
      if (isEdit) {
        successMessage = 'Address changed';
      }
      _appMessageCubit.showInformationMessage(successMessage);
      init();
    } on DioError catch (e) {
      emit(state.copyWith(
        status: ErrorUserStatus(),
      ));
      _appMessageCubit.showDioErrorMessage(e);
    }
  }

  void init() async {
    addEmail(emailStorage.email);
    await fetchUserDetails(UserDetailsRequest(
        email: state.email, password: 'password', currency: 'EUR'));
    await fetchUserAddresses(
        UserAddressesRequest(email: state.email, password: 'password'));
    addId(int.parse(state.user.id));
  }

  final ErrorHandler errorHandler;

  void addEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void addId(int id) {
    emit(state.copyWith(id: id));
  }

  Future<void> fetchUserAddresses(UserAddressesRequest model) async {
    try {
      final response = await _userRepository.fetchUserAddresses(model);
      emit(state.copyWith(
        status: OkUserStatus(),
        addressList: response.addresses,
      ));
    } on DioError catch (e) {
      emit(state.copyWith(
        status: ErrorUserStatus(),
      ));
      _appMessageCubit.showDioErrorMessage(e);
    }
  }

  Future<void> fetchUserDetails(UserDetailsRequest model) async {
    try {
      final response = await _userRepository.fetchUserDetails(model);
      emit(state.copyWith(
        status: OkUserStatus(),
        user: response.user,
      ));
    } on DioError catch (e) {
      emit(state.copyWith(
        status: ErrorUserStatus(),
      ));
      _appMessageCubit.showDioErrorMessage(e);
    }
  }

  void topup(String email, int amount, int typeId) async {
    try {
      final result = await _userRepository.createPay(email, typeId, amount);
      if (result.status == 200) {
        init();
      }
      emit(
          state.copyWith(status: SuccessFetchPaymentLinkStatus(model: result)));
    } on DioError catch (e) {
      _appMessageCubit.showDioErrorMessage(e);
    }
  }

  Future<void> updateUser(UpdateUserRequest model) async {
    try {
      emit(state.copyWith(status: LoadingUserStatus()));
      final response = await _userRepository.updateUser(model);
      if (response.status == 200) {
        init();
      }
      _appMessageCubit
          .showInformationMessage('User information has been changed');
      emit(state.copyWith(
        status: OkUserStatus(),
      ));
    } on DioError catch (e) {
      emit(state.copyWith(
        status: OkUserStatus(),
      ));
      _appMessageCubit.showDioErrorMessage(e);
    }
  }
}
