import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../blocs/auth_bloc.dart';
import '../../global_variables.dart';
import '../../routes.dart';
import '../../states/auth_states.dart';

class GlobalListener extends StatelessWidget {
  final child;

  GlobalListener({this.child});
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<AuthBloc, AuthState>(listener: (context, state) async {
        if (state is LoggedInState) {
          EasyLoading.dismiss();
          Navigator.pushNamedAndRemoveUntil(gNavigatorKey.currentContext!,
              Routes.navigationScreen, (route) => false);
        }
        else if (state is LoggingOutState) {
          EasyLoading.show(status: "Signing out...");
        }
        else if (state is AuthErrorState) {
          EasyLoading.showError("Authentication Error");
        }
        else if (state is AuthLoadingState) {
          EasyLoading.show(status: "Loading...");
        } else if (state is LogOutState) {
          EasyLoading.dismiss();
          Navigator.pushNamedAndRemoveUntil(gNavigatorKey.currentContext!,
              Routes.loginScreen, (route) => false);
        }
      }),
    ], child: child);
  }
}
