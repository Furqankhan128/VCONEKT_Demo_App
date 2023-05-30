
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vconekt_demo_app/blocs/auth_bloc.dart';
import 'package:vconekt_demo_app/events/auth_events.dart';
import 'package:vconekt_demo_app/routes.dart';

import '../../constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  {

  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
        width: 1.sw,
        height: 1.sh,
        alignment: Alignment.center,
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 50.0,
            color: kBlackColor,
            fontFamily: 'Canterbury',
          ),
          child: AnimatedTextKit(

            animatedTexts: [
              ScaleAnimatedText('VCONEKT'),
            ],
            isRepeatingAnimation: false,
            repeatForever: false,
            onFinished: (){

              BlocProvider.of<AuthBloc>(context).add(Authenticate());

            },
          ),
        ),
    ),
      ),
    );
  }
}
