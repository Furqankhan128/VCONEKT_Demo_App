
import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/auth_events.dart';
import '../global_variables.dart';
import '../models/error_model.dart';
import '../models/success_model.dart';
import '../states/auth_states.dart';
import '../user_session.dart';

class ResetPasswordBloc extends Bloc<AuthEvent, AuthState> {
  ResetPasswordBloc(AuthState initialState) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is ResetPassword) {
      yield ResetPasswordLoadingState();

      try {
        await gFirebaseAuth.sendPasswordResetEmail(email: event.email);
        yield ResetPasswordSuccessState(successModel: SuccessModel(title: "Success",
            message: "A link has been sent to your email address please verify your email."));
      } catch (e) {
        yield ResetPasswordErrorState(errorModel: ErrorModel(
            message: "An error occurred while trying to send email for verification",
            title: "Error",
            errorCode: 404
        ));
      }
    }
  }
}