 
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:vconekt_demo_app/constants/colors.dart';
import 'package:vconekt_demo_app/ui/widgets/button_widget.dart';

import '../../constants/style.dart'; 

buildWarningDialog(BuildContext context, {title, message}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            buttonPadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  MaterialCommunityIcons.information_outline,
                  color: Colors.orange,
                  size: 50.sp,
                ),
                kVerticalSpace8,
                Text(
                  title ?? "Warning",
                  style: TextStyle(
                      color: kBlackColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message ?? "Are you sure",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kBlackColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
                kVerticalSpace24,
                Row(
                  children: [
                    Expanded(
                      child: ButtonWidget(
                        text: "No",
                        onPressed: () {
                          return Navigator.of(context).pop(false);
                        },
                      ),
                    ),
                    kHorizontalSpace12,
                    Expanded(
                        child: ButtonWidget(
                      text: "Yes",
                      onPressed: () {
                        return Navigator.of(context).pop(true);
                      },
                    )),
                  ],
                )
              ],
            ),
          ));
}

buildAlertDialog(
  BuildContext context, {
  title,
  message,
  buttonText,
      onTap,
}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            buttonPadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  MaterialCommunityIcons.information_outline,
                  color: Colors.orange,
                  size: 50.sp,
                ),
                kVerticalSpace8,
                Text(
                  title ?? '',
                  style: TextStyle(
                      color: kBlackColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kBlackColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
                kVerticalSpace24,
                ButtonWidget(
                    text: buttonText ?? "OK",
                    onPressed:onTap?? () {
                      Navigator.pop(context);
                    })
              ],
            ),
          ));
}

