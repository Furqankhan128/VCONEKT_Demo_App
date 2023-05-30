import 'package:equatable/equatable.dart';

import '../models/error_model.dart';
import '../models/success_model.dart';

abstract class AuthState extends Equatable {}

class AuthInitialState extends AuthState {
  AuthInitialState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AuthLoadingState extends AuthState {
  AuthLoadingState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoggedInState extends AuthState {
  LoggedInState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoggingOutState extends AuthState {
  LoggingOutState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LogOutState extends AuthState {
  LogOutState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AuthErrorState extends AuthState {
  final ErrorModel errorModel;
  AuthErrorState({required this.errorModel});
  @override
  // TODO: implement props
  List<Object> get props => [errorModel];
}


class LoginUserLoadingState extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginUserSuccessState extends AuthState {
  final SuccessModel successModel;

  LoginUserSuccessState({required this.successModel});
  @override
  // TODO: implement props
  List<Object> get props => [successModel];
}

class LoginUserErrorState extends AuthState {
  final ErrorModel errorModel;

  LoginUserErrorState({required this.errorModel});
  @override
  // TODO: implement props
  List<Object> get props => [errorModel];
}

class CreateAccountLoadingState extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CreateAccountSuccessState extends AuthState {
  final SuccessModel successModel;

  CreateAccountSuccessState({required this.successModel});
  @override
  // TODO: implement props
  List<Object> get props => [successModel];
}

class CreateAccountErrorState extends AuthState {
  final ErrorModel errorModel;

  CreateAccountErrorState({required this.errorModel});
  @override
  // TODO: implement props
  List<Object> get props => [errorModel];
}

class ResetPasswordLoadingState extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ResetPasswordSuccessState extends AuthState {
  final SuccessModel successModel;

  ResetPasswordSuccessState({required this.successModel});
  @override
  // TODO: implement props
  List<Object> get props => [successModel];
}

class ResetPasswordErrorState extends AuthState {
  final ErrorModel errorModel;

  ResetPasswordErrorState({required this.errorModel});
  @override
  // TODO: implement props
  List<Object> get props => [errorModel];
}
