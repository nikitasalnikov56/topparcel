part of '../cubits/auth_cubit.dart';

class AuthState {
  final AuthStatus status;

  AuthState({required this.status});
}

abstract class AuthStatus {}

class LoadingAuthStatus extends AuthStatus {}

class AuthorisedStatus extends AuthStatus {}

class AuthorisationErrorStatus extends AuthStatus {}

class EnterCodeChangedPasswordStatus extends AuthStatus {}

// class ChangedPasswordStatus extends AuthStatus {}

class SuccessChangedPasswordStatus extends AuthStatus {}

class UnauthorisedStatus extends AuthStatus {}

class UpdatingPasswordStatus extends AuthStatus {}

class UpdatedPasswordStatus extends AuthStatus {}

class RegistrationSuccessStatus extends AuthStatus {
  final String name;
  final String email;
  final String password;
  final String phone;

  RegistrationSuccessStatus({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });
}

class ErrorLoginStatus extends AuthStatus {}
