
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';
import '../../constants/style.dart';

class ButtonWidget extends StatelessWidget {

  final String text;
  final IconData? icon;
  final Function() onPressed;
  final bool elevation;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final double? fontSize;

  const ButtonWidget(
      {Key? key,
      required this.text,
      this.elevation=false,
        this.height,
      this.backgroundColor,
      required this.onPressed,
      this.icon,
      this.width,
        this.fontSize=16,
      this.borderRadius,

      }):
        super(key: key);


  @override
  Widget build(BuildContext context) {
    return
     SizedBox(
      width: width??1.sw,
      height: height??45.h,
      child: icon==null?  ElevatedButton(
        onPressed: onPressed,
        child:   Text(text,style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600,color: kWhiteColor,fontSize: fontSize),textAlign: TextAlign.center),
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor??kAccentColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? kBorderRadius30),
            textStyle:Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600,color: kWhiteColor)),
      ):
      ElevatedButton.icon(
        onPressed: onPressed,
        label:   Text(text,style: Theme.of(context).textTheme.subtitle1?.copyWith(color: kWhiteColor),textAlign: TextAlign.center),
        icon: Icon(icon,color: kWhiteColor,size: 18.sp,),
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor?? kAccentColor, elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? kBorderRadius30),
            textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(color: kWhiteColor)),
      )
      ,
    );
  }
}

