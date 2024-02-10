import 'package:topparcel/data/models/requests/registration_request.dart';
import 'package:topparcel/data/models/requests/update_password_request.dart';
import 'package:topparcel/data/models/response/update_password_response.dart';

abstract class AuthRepository {
  Future<bool> isAuthorised();
  Future<Map<String, String>> login(String login, String password);
  Future<int> recoverPassword(String email);
  Future<void> deleteAccount(String login);
  Future<Map<String, String>> registration(RegistrationRequest requestModel);
  Future<UpdatePasswordResponse> updatePassword(
      UpdatePasswordRequest requestModel);
  void saveSession(String session, String email);
  void logout();
}
