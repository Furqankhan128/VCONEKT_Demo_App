import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:vconekt_demo_app/constants/colors.dart';
import 'package:vconekt_demo_app/constants/strings.dart';
import 'package:vconekt_demo_app/events/auth_events.dart';
import 'package:vconekt_demo_app/routes.dart';
import 'package:vconekt_demo_app/ui/widgets/button_widget.dart';
import 'package:vconekt_demo_app/ui/widgets/image_widget.dart';
import 'package:vconekt_demo_app/ui/widgets/text_field_widget.dart';
import 'package:vconekt_demo_app/constants/style.dart';
import 'package:vconekt_demo_app/user_session.dart';

import '../../blocs/login_bloc.dart';
import '../../states/auth_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  String _email="";

  String _password="";

  bool? _savePassword = false;


  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();

  bool _init=true;

  @override
  void didChangeDependencies() async{
    if(_init){
      _init=false;
      List<String> data = await UserSession.getCredentials();
      _email = data.first;
      _password = data.last;
      setState(() {

      });
    }
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginUserLoadingState) {
            EasyLoading.show(status: "Loading...");
          }
          else if (state is LoginUserErrorState) {
            EasyLoading.showError(state.errorModel.message!);
          }
          else if (state is LoginUserSuccessState) {
            EasyLoading.dismiss();
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
                    kVerticalSpace28,
                    ImageWidget(kLogo,fit: BoxFit.contain,height: 0.15.sh,width: 1.sw,isLocalImage: true,),
                    kVerticalSpace50,
                    Text("Log In",style: kDarkBoldExtraLargeStyle),
                    kVerticalSpace4,
                    Text("Log in to your account",style: kDarkNormalStyle),
                    kVerticalSpace28,
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
                      hintText: "Password",
                      onSaved: (val) {
                        _password = val!;
                      },
                      onChanged: (val) {
                        _password = val!;
                      },
                      validator: (val) {
                        if (val=="" || val==null) {
                          return kRequired;
                        } else {
                          return null;
                        }
                      },
                    ),
                    kVerticalSpace16,
                    Row(
                      children: [
                        Checkbox(value: _savePassword, onChanged: (val){
                          setState(() {
                            _savePassword = val;
                          });
                        }),
                        Text("Save Password",style: kDarkNormalStyle,),
                        Spacer(),
                        TextButton(onPressed: (){
                          Navigator.pushNamed(context, Routes.resetPasswordScreen);
                        }, child: const Text("Forgot Password")),
                      ],
                    ),
                    kVerticalSpace24,
                    ButtonWidget(text: "Log In", onPressed: _login),
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
                        Navigator.pushNamed(context, Routes.signUpScreen);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: kBorderRadius30,
                          border: Border.all(width: 1,color: kBlackColor)
                        ),
                          width: 1.sw,
                          height: 45.h,
                          alignment: Alignment.center,
                          child: Text("Sign Up",style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600,color: kBlackColor),)),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _login() async{
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _formKey.currentState?.save();

      if(_savePassword!){
        UserSession.saveCredentials(_email, _password);
      }else{
        UserSession.saveCredentials("", "");
      }

      BlocProvider.of<LoginBloc>(context).add(LoginUser(email: _email, password: _password));
    }
  }
}
