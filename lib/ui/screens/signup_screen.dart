import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:vconekt_demo_app/constants/strings.dart';
import 'package:vconekt_demo_app/events/auth_events.dart';
import 'package:vconekt_demo_app/ui/widgets/button_widget.dart';
import 'package:vconekt_demo_app/ui/widgets/image_widget.dart';
import 'package:vconekt_demo_app/ui/widgets/text_field_widget.dart';
import 'package:vconekt_demo_app/constants/style.dart';

import '../../blocs/login_bloc.dart';
import '../../blocs/create_account_bloc.dart';
import '../../constants/colors.dart';
import '../../routes.dart';
import '../../states/auth_states.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  String _email="";

  String _password="";

  String _confirmPassword="";

  bool _agreeToTerms = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CreateAccountBloc, AuthState>(
        listener: (context, state) {
          if (state is CreateAccountLoadingState) {
            EasyLoading.show(status: "Loading...");
          }
          else if (state is CreateAccountErrorState) {
            EasyLoading.showError(state.errorModel.message!);
          }
          else if (state is CreateAccountSuccessState) {
            EasyLoading.showSuccess(state.successModel.message!);
            Navigator.pushNamedAndRemoveUntil(context, Routes.navigationScreen, (route) => false);
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
              kVerticalSpace20,
              ImageWidget(kLogo,fit: BoxFit.contain,height: 0.15.sh,width: 1.sw,isLocalImage: true,),
              kVerticalSpace24,
              Text("Sign Up",style: kDarkBoldExtraLargeStyle),
              kVerticalSpace4,
              Text("Create a new account",style: kDarkNormalStyle),
              kVerticalSpace20,
              TextFieldWidget(
                text: _email,
                labelText: "Email",
                onSaved: (val) {
                  _email = val!;
                },
                onChanged: (val) {
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
              kVerticalSpace16,
              TextFieldWidget(
                text: _password,
                obscureText: true,
                labelText: "Password",
                onSaved: (val) {
                  _password = val!;
                },
                onChanged: (val) {
                  _password = val!;
                },
                validator: (val) {
                  if (val=="" || val==null) {
                    return kPasswordReqMsg;
                  }  else if (val.length < 8){
                    return kPasswordLimitMsg;
                  }else {
                    return null;
                  }
                },
              ),
              kVerticalSpace16,
              TextFieldWidget(
                text: _confirmPassword,
                obscureText: true,
                labelText: "Confirm Password",
                onSaved: (val) {
                  _confirmPassword = val!;
                },
                onChanged: (val) {
                  _confirmPassword = val!;
                },
                validator: (val) {
                  if (val=="" || val==null) {
                    return kPasswordReqMsg;
                  } else if (val.toUpperCase() != _password.toUpperCase()){
                    return kPasswordNotMatchMsg;
                  } else if (val.length < 8){
                    return kPasswordLimitMsg;
                  }
                  else {
                    return null;
                  }
                },
              ),
              kVerticalSpace16,
              Row(
                crossAxisAlignment:CrossAxisAlignment.end,
                children: [
                  Checkbox(value: _agreeToTerms, onChanged: (val){
                    setState(() {
                      _agreeToTerms = val!;
                    });
                  }),
                  Expanded(child: Padding(
                    padding: EdgeInsets.only(bottom:2.w),
                    child: Text("By creating this account you agree to our terms and conditions.",),
                  ))
                ],
              ),
              kVerticalSpace24,
              ButtonWidget(text: "Sign Up", onPressed:_agreeToTerms? _signUp:(){}),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 1.w,
                      width: 50.w,
                      color: Colors.grey.shade300,
                    ),
                    Text(
                      "Or",
                      style: TextStyle(
                          color: kGreyColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      height: 1.w,
                      width: 50.w,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Routes.loginScreen);
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: kBorderRadius30,
                        border: Border.all(width: 1,color: kBlackColor)
                    ),
                    width: 1.sw,
                    height: 45.h,
                    alignment: Alignment.center,
                    child: Text("Log In",style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600,color: kBlackColor),)),
              ),
            ],
          ),
        ),
    ),
    ),),),);
  }

  _signUp() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _formKey.currentState?.save();


      BlocProvider.of<CreateAccountBloc>(context).add(CreateAccount(email: _email,password: _password));
    }
  }
}
