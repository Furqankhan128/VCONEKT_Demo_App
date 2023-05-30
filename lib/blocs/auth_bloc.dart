
import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/auth_events.dart';
import '../states/auth_states.dart';
import '../user_session.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthState initialState) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is Authenticate) {
      yield AuthLoadingState();

      if (await UserSession.exist()) {
        yield LoggedInState();
      } else {
        yield LogOutState();
      }
    }


    else if (event is LogOut) {
      yield LoggingOutState();
      await UserSession.logout();
      yield LogOutState();
    }
  }

}
