

import '../models/success_model.dart';

abstract class AuthEvent {
  AuthEvent();
}

class Authenticate extends AuthEvent {
  Authenticate();
}

class LoginUser extends AuthEvent {
  final String email;
  final String password;

  LoginUser({required this.email,required this.password});
}

class LoggedIn extends AuthEvent {
  final SuccessModel successModel;
  LoggedIn(this.successModel);
}

class LogOut extends AuthEvent {
  LogOut();
}

class CreateAccount extends AuthEvent {
  final String email;
  final String password;
  CreateAccount({required this.email, required this.password});
}


class ResetPassword extends AuthEvent {
  final String email;
  ResetPassword({required this.email});
}

