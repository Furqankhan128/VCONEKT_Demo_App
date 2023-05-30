
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/colors.dart';
class CircularLoader extends StatelessWidget {
  final color;

  CircularLoader({this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 20.r,
        width: 20.r,
        child: CircularProgressIndicator(
            strokeWidth: 2.3,
            valueColor: color != null
                ? AlwaysStoppedAnimation<Color>(color)
                : AlwaysStoppedAnimation<Color>(kAccentColor)),
      ),
    );
  }
}
