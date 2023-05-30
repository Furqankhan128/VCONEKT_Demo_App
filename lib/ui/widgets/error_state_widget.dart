import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:vconekt_demo_app/constants/colors.dart';
import 'package:vconekt_demo_app/ui/widgets/button_widget.dart';

import '../../constants/style.dart';

class ErrorStateWidget extends StatelessWidget {
  final double? size;
  final String? text;
  final bool showIcon;
  dynamic Function() onRetry;
  ErrorStateWidget({this.text, this.size, required this.onRetry, this.showIcon = true});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          showIcon
              ? Image.asset(
                  "images/splash.png",
                  color: kGreyColor,
                width: size??70.w,
                height: size??70.w,
                )
              : Container(),
          kVerticalSpace12,
          Text(
            text??"",
            style: TextStyle(color: kGreyColor, fontSize: 14.sp),
            textAlign: TextAlign.center,
          ),
          onRetry != null
              ? ButtonWidget(
                  text: "Retry",
                  onPressed: onRetry,
                  icon: MaterialCommunityIcons.refresh,
                )
              : Container()
        ],
      ),
    );
  }
}
