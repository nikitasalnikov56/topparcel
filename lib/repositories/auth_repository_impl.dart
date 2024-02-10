import 'package:topparcel/data/local_db/email_storage.dart';
import 'package:topparcel/data/local_db/token_storage.dart';
import 'package:topparcel/data/models/requests/login_request.dart';
import 'package:topparcel/data/models/requests/recover_request.dart';
import 'package:topparcel/data/models/requests/registration_request.dart';
import 'package:topparcel/data/models/requests/update_password_request.dart';
import 'package:topparcel/data/models/response/update_password_response.dart';
import 'package:topparcel/data/network/auth_api.dart';

import '../data/local_db/authentication_storage.dart';
import '../interfaces/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthApi authApi;
  final AuthStorage authStorage;
  final TokenStorage tokenStorage;
  final EmailStorage emailStorage;

  AuthRepositoryImpl({
    required this.authApi,
    required this.authStorage,
    required this.tokenStorage,
    required this.emailStorage,
  });

  @override
  Future<Map<String, String>> login(String login, String password) async {
    try {
      LoginRequest requestModel =
          LoginRequest(login: login, password: password);
      final result = await authApi.login(requestModel);
      return {
        'token': result.token,
        'email': login,
      };
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount(String login) async {
    try {
      LoginRequest requestModel =
          LoginRequest(login: login, password: tokenStorage.token);
      await authApi.login(requestModel);
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<bool> isAuthorised() async {
  //   final token = await tokenStorage.token;
  //   return token != '' && token != null;
  // }

  @override
  Future<bool> isAuthorised() async {
    final token = await tokenStorage.loadToken();
    return token != '' && token != null;
  }

  @override
  Future<Map<String, String>> registration(
      RegistrationRequest requestModel) async {
    try {
      final result = await authApi.registration(requestModel);
      return {
        'token': result.token,
        'email': requestModel.email,
      };
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UpdatePasswordResponse> updatePassword(
      UpdatePasswordRequest model) async {
    final requestModel = UpdatePasswordRequest(
      email: emailStorage.email,
      password:
          tokenStorage.token != 'pass' ? model.password : tokenStorage.token,
      newPassword: model.newPassword,
    );
    try {
      final result = await authApi.updatePassword(requestModel);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void saveSession(String session, String email, {bool isAdmin = false}) {
    tokenStorage.setToken(session);
    emailStorage.setEmail(email);
  }

  @override
  void logout() async {
    await tokenStorage.clearToken();
    await authStorage.logout();
  }

  @override
  Future<int> recoverPassword(String email) async {
    try {
      final requestModel = RecoverRequest(email: email);
      final result = await authApi.recoverPassword(requestModel);

      return result.status;
    } catch (e) {
      rethrow;
    }
  }
}
