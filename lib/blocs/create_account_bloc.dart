import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/auth_events.dart';

import '../global_variables.dart';
import '../models/error_model.dart';
import '../models/success_model.dart';
import '../states/auth_states.dart';

import '../user_session.dart';

class CreateAccountBloc extends Bloc<AuthEvent, AuthState> {
  CreateAccountBloc(AuthState initialState) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is CreateAccount) {
      yield CreateAccountLoadingState();

      try {

        await gFirebaseAuth.createUserWithEmailAndPassword(email: event.email, password: event.password,).then((value) async {
          value.user?.sendEmailVerification();
          await UserSession.create(value.user?.uid);
        });
        yield CreateAccountSuccessState(successModel: SuccessModel(title: "Success",
            message: "An email has been sent to your email address please verify your email."));
      } catch (e) {
        yield CreateAccountErrorState(errorModel: ErrorModel(
            message: "An error occurred while trying to send email for verification",
            title: "Error",
            errorCode: 404
        ));
      }
    }
  }
}