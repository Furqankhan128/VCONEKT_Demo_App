import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vconekt_demo_app/constants/strings.dart';

import '../../constants/colors.dart';
import '../../constants/style.dart';

class NoDataFoundWidget extends StatelessWidget {
  final String? text;
  final double? size;
  final bool showIcon;
  NoDataFoundWidget({this.text, this.size, this.showIcon = true});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.w),
        child: showIcon
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    kLogo,
                    height: size ?? 70.w,
                    width: size ?? 70.w,
                    color: kGreyColor,
                  ),
                  kVerticalSpace12,
                  Text(
                    text ?? "No records found",
                    style: TextStyle(color: kGreyColor, fontSize: 14.sp),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            : Text(
                text ?? "No records found",
                style: TextStyle(color: kGreyColor, fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
