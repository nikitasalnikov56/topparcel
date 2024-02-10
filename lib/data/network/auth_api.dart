import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:topparcel/data/models/requests/login_request.dart';
import 'package:topparcel/data/models/requests/recover_request.dart';
import 'package:topparcel/data/models/requests/registration_request.dart';
import 'package:topparcel/data/models/requests/update_password_request.dart';
import 'package:topparcel/data/models/response/login_response.dart';
import 'package:topparcel/data/models/response/recover_reponse.dart';
import 'package:topparcel/data/models/response/registration_response.dart';
import 'package:topparcel/data/models/response/update_password_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('api/auth')
  Future<LoginResponse> login(@Body() LoginRequest requestModel);

  @POST('api/deleteAccount')
  Future<LoginResponse> deleteAccount(@Body() LoginRequest requestModel);

  @POST('api/register')
  Future<RegistrationResponse> registration(
      @Body() RegistrationRequest requestModel);

  @POST('api/recover')
  Future<RecoverResponse> recoverPassword(@Body() RecoverRequest requestModel);

  @POST('api/updateUser')
  Future<UpdatePasswordResponse> updatePassword(
      @Body() UpdatePasswordRequest requestModel);
}
