
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vconekt_demo_app/blocs/create_account_bloc.dart';
import 'package:vconekt_demo_app/blocs/firestore_bloc.dart';
import 'package:vconekt_demo_app/blocs/get_categories_bloc.dart';
import 'package:vconekt_demo_app/blocs/get_firestore_products_bloc.dart';
import 'package:vconekt_demo_app/blocs/get_products_by_category_bloc.dart';
import 'package:vconekt_demo_app/blocs/reset_password_bloc.dart';
import 'package:vconekt_demo_app/routes.dart';
import 'package:vconekt_demo_app/states/auth_states.dart';
import 'package:vconekt_demo_app/states/category_state.dart';
import 'package:vconekt_demo_app/states/firestore_state.dart';
import 'package:vconekt_demo_app/states/product_state.dart';
import 'package:vconekt_demo_app/ui/screens/add_product_screen.dart';
import 'package:vconekt_demo_app/ui/screens/edit_product_screen.dart';
import 'package:vconekt_demo_app/ui/screens/firestore_products_screen.dart';
import 'package:vconekt_demo_app/ui/screens/login_screen.dart';
import 'package:vconekt_demo_app/ui/screens/navigation_screen.dart';
import 'package:vconekt_demo_app/ui/screens/reset_password_screen.dart';
import 'package:vconekt_demo_app/ui/screens/signup_screen.dart';
import 'package:vconekt_demo_app/ui/screens/splash_screen.dart';
import 'package:vconekt_demo_app/ui/widgets/global_listener.dart';
import 'package:vconekt_demo_app/ui/widgets/init_easy_loading.dart';



import 'blocs/auth_bloc.dart';
import 'blocs/get_products_bloc.dart';
import 'blocs/login_bloc.dart';
import 'constants/colors.dart';
import 'constants/style.dart';
import 'global_variables.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color(0xffffffff),systemNavigationBarColor: Color(0xffffffff),
    statusBarIconBrightness: Brightness.dark),
    );

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: blocProviders(),
    child: ScreenUtilInit(
        builder: (context,_) => GlobalListener(
    child: MaterialApp(
          navigatorKey: gNavigatorKey,
          builder: initEasyLoading(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: kPrimaryColor,
              dividerTheme: const DividerThemeData(color: Colors.grey),
              floatingActionButtonTheme:  FloatingActionButtonThemeData(
                  backgroundColor: kAccentColor),
              buttonTheme:  ButtonThemeData(buttonColor: kAccentColor),
            cardTheme: CardTheme(
                shadowColor: Colors.grey,
                elevation: kCardElevation,
                shape: RoundedRectangleBorder(
                  borderRadius: kCardBorderRadius,
                )),
            scaffoldBackgroundColor: kPrimaryColor,
            tabBarTheme: TabBarTheme(
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: kBlackColor,
                labelColor: kWhiteColor,
                labelPadding: EdgeInsets.only(top: 2.h),
                unselectedLabelStyle: kHintStyle,
                indicator: BoxDecoration(
                    color: kAccentColor, borderRadius: kBorderRadius30),
                labelStyle: kHintStyle),
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
            }),
            fontFamily: 'Roboto',),
          initialRoute: Routes.splashScreen,
          onGenerateRoute: _onGenerateRoute,
        ))));
  }
}

blocProviders() {
  return [
    BlocProvider(create: (context) => AuthBloc(AuthInitialState())),
    BlocProvider(create: (context) => LoginBloc(AuthInitialState())),
    BlocProvider(create: (context) => ResetPasswordBloc(AuthInitialState())),
    BlocProvider(create: (context) => CreateAccountBloc(AuthInitialState())),
    BlocProvider(create: (context) => GetProductsBloc(ProductInitialState())),
    BlocProvider(create: (context) => GetCategoriesBloc(CategoryInitialState())),
    BlocProvider(create: (context) => GetProductsByCategoryBloc(ProductInitialState())),
    BlocProvider(create: (context) => FireStoreBloc(FireStoreInitialState())),
    BlocProvider(create: (context) => GetFireStoreProductsBloc(FireStoreInitialState())),
  ];
}

Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splashScreen:
      return CustomPageRoute(
          builder: (context) => SplashScreen(), settings: settings);
    case Routes.loginScreen:
      return CustomPageRoute(
          builder: (context) => LoginScreen(), settings: settings);
    case Routes.signUpScreen:
      return CustomPageRoute(
          builder: (context) => SignUpScreen(), settings: settings);
    case Routes.resetPasswordScreen:
      return CustomPageRoute(
          builder: (context) => ResetPasswordScreen(), settings: settings);
    case Routes.navigationScreen:
      return CustomPageRoute(
          builder: (context) => NavigationScreen(), settings: settings);
    case Routes.addProductScreen:
      return CustomPageRoute(
          builder: (context) => AddProductScreen(), settings: settings);
      case Routes.updateProductScreen:
    return CustomPageRoute(
        builder: (context) => EditProductScreen(), settings: settings);
      default:
      return null;
  }
}

class CustomPageRoute extends MaterialPageRoute {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  CustomPageRoute({builder, settings})
      : super(builder: builder, settings: settings);
}
