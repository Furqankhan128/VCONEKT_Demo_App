import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../constants/colors.dart';

initEasyLoading() {

  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1500)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 40.w
    ..radius = 10.r
    ..successWidget = Icon(
      MaterialCommunityIcons.check_circle_outline,
      color: Colors.green,
      size: 50.sp,
    )
    ..errorWidget = Icon(
      MaterialCommunityIcons.close_circle_outline,
      color: Colors.red,
      size: 50.sp,
    )
    ..infoWidget = Icon(
      MaterialCommunityIcons.information_outline,
      color: Colors.lightBlueAccent,
      size: 50.sp,
    )
    ..progressColor = kPrimaryColor
    ..maskType = EasyLoadingMaskType.custom
    ..backgroundColor = Colors.transparent
    ..indicatorColor = kPrimaryColor
    ..toastPosition = EasyLoadingToastPosition.bottom
    ..textColor = kWhiteColor
    ..fontSize = 14
    ..maskColor = Colors.black38
    ..userInteractions = false
    ..dismissOnTap = false;

  return EasyLoading.init();
}
