import 'package:flutter/material.dart';
import 'package:olgooproductform/feature/domain/auth/entity/user.entity.dart';

@immutable
abstract class AuthStatus {}

class InintialAuthStatus extends AuthStatus {}

class LoadingAuthStatus extends AuthStatus {}

class NeedOTPStatus extends AuthStatus {}

class SuccessSendResignOTP extends AuthStatus {}

class SuccessResigned extends AuthStatus {

  SuccessResigned();
}

class SuccessAuthStatus extends AuthStatus {
  final UserEntity user;
  SuccessAuthStatus({required this.user});
}

class SuccessRegisterUser extends AuthStatus {
  final UserEntity user;
  SuccessRegisterUser({required this.user});
}

class ErrorAuthStatus extends AuthStatus {
  final String errorMessage;
  ErrorAuthStatus(this.errorMessage);
}
