// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../cubits/user_cubit.dart';

class UserState {
  final UserStatus status;
  final UserModel user;
  final String email;
  final int id;
  final List<UserAddress> addressList;

  UserState({
    required this.status,
    required this.user,
    required this.email,
    required this.id,
    required this.addressList,
  });

  UserState copyWith({
    UserStatus? status,
    UserModel? user,
    String? email,
    int? id,
    List<UserAddress>? addressList,
  }) {
    return UserState(
      status: status ?? this.status,
      user: user ?? this.user,
      email: email ?? this.email,
      id: id ?? this.id,
      addressList: addressList ?? this.addressList,
    );
  }
}

abstract class UserStatus {}

class LoadingUserStatus extends UserStatus {}

class InitialUserStatus extends UserStatus {}

class ErrorUserStatus extends UserStatus {}

class OkUserStatus extends UserStatus {}

class SuccessFetchPaymentLinkStatus extends UserStatus {
  final CreatePayResponse model;

  SuccessFetchPaymentLinkStatus({required this.model});
}

class SuccessCreateAddressUserStatus extends UserStatus {}
