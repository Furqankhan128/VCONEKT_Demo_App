
import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/auth_events.dart';
import '../global_variables.dart';
import '../models/error_model.dart';
import '../models/success_model.dart';
import '../states/auth_states.dart';
import '../user_session.dart';

class LoginBloc extends Bloc<AuthEvent, AuthState> {
  LoginBloc(AuthState initialState) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginUser) {

      yield LoginUserLoadingState();

      try {

         await  gFirebaseAuth.signInWithEmailAndPassword(email: event.email, password:event.password).then((value) async{

           await UserSession.create(value.user?.uid);
        });


        yield LoginUserSuccessState(successModel: SuccessModel(title: "Success",
            message: "Logged In Successfully."));
      } catch (e) {
        yield LoginUserErrorState(errorModel: ErrorModel(
            message: e.toString(),
            title: "Error",
            errorCode: 500
        ));
      }

    }
  }
}
