
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../constants/colors.dart';

AppBar buildAppBar(BuildContext context,
    {List<Widget>? actions,
    String? title,
      PreferredSizeWidget? bottom,
    Widget? child,
    bool elevation = true,
    backButton = true,
    Color? color,
    double height=50,Widget? leading,center=false}) {


  return AppBar(
    leading: leading,
    backgroundColor: color ?? kPrimaryColor,
    toolbarHeight: height,
    bottom: bottom,
    brightness: Brightness.dark,
    titleSpacing: 16.w,
    automaticallyImplyLeading: backButton,
    title: child ??
        Text(
          (title ?? '').toUpperCase(),
          style: TextStyle(
              color: kBlackColor,
              fontWeight: FontWeight.w600,
              fontSize: 18.sp),
        ),
    centerTitle: center,
    shadowColor: kGreyColor,
    elevation: elevation ? 4.w : 0,
    iconTheme: new IconThemeData(
        color: kBlackColor,
        size: 25.sp),
    actions: actions,
  );
}
