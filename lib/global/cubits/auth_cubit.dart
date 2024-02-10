import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topparcel/data/models/requests/registration_request.dart';
import 'package:topparcel/data/models/requests/update_password_request.dart';
import 'package:topparcel/global/cubits/app_message_cubit.dart';
import 'package:topparcel/interfaces/auth_repository.dart';

part '../states/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  // Статические методы для прослушивания и получения кубита
  static AuthState watchState(BuildContext context) =>
      context.watch<AuthCubit>().state;
  static AuthCubit read(BuildContext context) => context.read<AuthCubit>();

  AuthCubit({
    required AuthRepository authRepository,
    required AppMessageCubit appMessageCubit,
  })  : _authRepository = authRepository,
        _appMessageCubit = appMessageCubit,
        super(AuthState(status: LoadingAuthStatus()));

  AuthRepository _authRepository;
  final AppMessageCubit _appMessageCubit;

  void checkAuthorisation() async {
    final isAuthirised = await _authRepository.isAuthorised();
    await Future.delayed(const Duration(seconds: 2));
    if (isAuthirised) {
      emit(AuthState(status: AuthorisedStatus()));
    } else {
      emit(AuthState(status: UnauthorisedStatus()));
    }
  }

  void login(String login, String password) async {
    try {
      final response = await _authRepository.login(login, password);
      print('RESPONSE: - $response');
      _authRepository.saveSession(response['token']!, response['email']!);
      emit(AuthState(status: AuthorisedStatus()));
    } on DioError catch (e) {
      _appMessageCubit.showDioErrorMessage(e);
    }
  }

  void deleteAccount(String login) async {
    try {
      await _authRepository.deleteAccount(login);
      logout();
    } on DioError catch (e) {
      _appMessageCubit.showDioErrorMessage(e);
    }
  }

  void logout() {
    _authRepository.logout();
    checkAuthorisation();
  }

  void registration(RegistrationRequest requestModel) async {
    try {
      final response = await _authRepository.registration(requestModel);
      _authRepository.saveSession(response['token']!, requestModel.email);
      emit(AuthState(status: AuthorisedStatus()));
    } on DioError catch (e) {
      _appMessageCubit.showDioErrorMessage(e);
    } catch (e) {
      _appMessageCubit.showErrorMessage(e.toString());
    }
  }

  void sendCodeToEmail(String email, {bool repeateSendCode = false}) async {
    try {
      final result = await _authRepository.recoverPassword(email);
      if (!repeateSendCode) {
        emit(AuthState(status: EnterCodeChangedPasswordStatus()));
      }
    } on DioError catch (e) {
      _appMessageCubit.showDioErrorMessage(e);
    } catch (e) {
      _appMessageCubit.showErrorMessage(e.toString());
    }
  }

  void checkEnterCode(String code, String email) async {
    // _authRepository.saveSession(code, email);
    emit(AuthState(status: UpdatingPasswordStatus()));
  }

  void updatePassword(UpdatePasswordRequest requestModel,
      {bool isLogin = false}) async {
    try {
      if (!isLogin) emit(AuthState(status: UpdatingPasswordStatus()));
      final response = await _authRepository.updatePassword(requestModel);

      emit(AuthState(status: UpdatedPasswordStatus()));
    } on DioError catch (e) {
      _appMessageCubit.showDioErrorMessage(e);
    } catch (e) {
      _appMessageCubit.showErrorMessage(e.toString());
    }
  }
}
