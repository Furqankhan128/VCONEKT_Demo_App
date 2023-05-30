
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vconekt_demo_app/constants/colors.dart';

class ImageLoader extends StatelessWidget {



  const ImageLoader();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 20.r,
        width: 20.r,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(kBlackColor),
          strokeWidth: 2.3.r,
        ),
      ),
    );
  }
}
