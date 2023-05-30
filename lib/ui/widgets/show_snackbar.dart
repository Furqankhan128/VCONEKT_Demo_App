import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vconekt_demo_app/constants/colors.dart';

showSnackBar(context, msg, {isError=false,color=kBlackColor}) {
  if (msg != null) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 5),
      // persistent: false,
      builder: (_, controller) {
        return Flash(
            controller: controller,
            backgroundColor: color,
            brightness: Brightness.light,
            boxShadows: const [BoxShadow(blurRadius: 5, color: Colors.grey)],
            barrierBlur: 0,
            barrierColor: Colors.transparent,
            barrierDismissible: true,
            horizontalDismissDirection: HorizontalDismissDirection.horizontal,
            behavior: FlashBehavior.floating,
            position: FlashPosition.top,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.w),
                width: 1.sw,
                child: Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                )));
      },
    );
  }
}

