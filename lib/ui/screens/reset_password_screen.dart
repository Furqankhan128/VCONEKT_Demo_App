import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:vconekt_demo_app/constants/colors.dart';
import 'package:vconekt_demo_app/constants/strings.dart';
import 'package:vconekt_demo_app/events/auth_events.dart';
import 'package:vconekt_demo_app/routes.dart';
import 'package:vconekt_demo_app/ui/widgets/button_widget.dart';
import 'package:vconekt_demo_app/ui/widgets/image_widget.dart';
import 'package:vconekt_demo_app/ui/widgets/text_field_widget.dart';
import 'package:vconekt_demo_app/constants/style.dart';

import '../../blocs/login_bloc.dart';
import '../../blocs/reset_password_bloc.dart';
import '../../states/auth_states.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {


  String _email="";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ResetPasswordBloc, AuthState>(
          listener: (context, state) {
            if (state is ResetPasswordLoadingState) {
              EasyLoading.show(status: "Loading...");
            }
            else if (state is ResetPasswordErrorState) {
              EasyLoading.showError(state.errorModel.message!);
            }
            else if (state is ResetPasswordSuccessState) {
              EasyLoading.showSuccess(state.successModel.message!);
              Navigator.pushNamedAndRemoveUntil(context, Routes.loginScreen, (route) => false);
            }

          },
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(

            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kVerticalSpace28,
                  ImageWidget(kLogo,fit: BoxFit.contain,height: 0.15.sh,width: 1.sw,isLocalImage: true,),
                  kVerticalSpace50,
                  Text("Reset Password",style: kDarkBoldExtraLargeStyle),
                  kVerticalSpace4,
                  Text("Please write your verified email so that we will send a password reset link to you email.",style: kDarkNormalStyle),
                  kVerticalSpace28,
                  TextFieldWidget(
                    text: _email,
                    labelText: "Email",
                    onSaved: (val) {
                      _email = val!;
                    },onChanged: (val) {
                    _email = val!;
                  },
                    validator: (val) {
                      if (val=="" || val==null) {
                        return kRequired;
                      } else if (!RegExp(kEmailRegExp)
                          .hasMatch(val)) {
                        return kEmailReqMsg;
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  kVerticalSpace24,
                  ButtonWidget(text: "Reset Password", onPressed: _resetPassword),


                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  _resetPassword() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _formKey.currentState?.save();

      BlocProvider.of<ResetPasswordBloc>(context).add(ResetPassword(email: _email));
    }
  }
}
