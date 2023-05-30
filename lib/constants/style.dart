
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../global_variables.dart';
import 'colors.dart';

final kDoubleExtraLargeSize = 24.sp;
final kExtraLargeSize = 18.sp;
final kLargeSize = 16.sp;
final kMediumSize = 13.sp;
final kNormalSize = 14.sp;
final kSmallSize = 12.sp;
final kExtraSmallSize = 10.sp;
final kDoubleExtraSmallSize = 8.sp;

var kIconSize = 22.sp;
var kProductOverviewPriceTextStyle = TextStyle(color: Colors.green,fontSize: 16.sp,fontWeight: FontWeight.w600);

final kTextFieldStyle = TextStyle(color:Theme.of(gNavigatorKey.currentContext!).textTheme.titleSmall?.color, fontSize: 16.sp, fontWeight: FontWeight.w500);


final kAppBarStyle=TextStyle(color: kWhiteColor, fontSize: 18.sp, fontWeight: FontWeight.w700);

final kHintStyle = TextStyle(color: kGreyColor, fontSize: 16.sp, fontWeight: FontWeight.w500);

final kErrorStyle = TextStyle(  color: Colors.red, height: 0.4.h, fontSize: 12.sp, fontWeight: FontWeight.w500,);

final kBoxPadding = EdgeInsets.symmetric(vertical: 4.w,horizontal: 8.w);

final kCardPadding = EdgeInsets.symmetric(vertical: 16.w,horizontal: 8.w);

final kVerticalScreenPadding = EdgeInsets.symmetric(vertical: 16.w);

final kHorizontalScreenPadding = EdgeInsets.symmetric(horizontal: 16.w);

final kScreenPadding = EdgeInsets.all(16.w);

final kCardElevation = 4.w;

final kTextFieldIconSize = 25.sp;

final kMenuIconSize = 30.sp;

final kTextFieldHeight = 40.h;

final kBorderRadius4 = BorderRadius.circular(4.r);
final kBorderRadius8 = BorderRadius.circular(8.r);
final kBorderRadius12 = BorderRadius.circular(12.r);
final kBorderRadius16 = BorderRadius.circular(16.r);
final kBorderRadius30 = BorderRadius.circular(30.r);
final kBorderRadius50 = BorderRadius.circular(50.r);

final kCardBorderRadius = kBorderRadius8;

final kTextFieldBorderRadius = kBorderRadius4;

var kHeading3Size = 16.sp;

var kBlackHeading3Style = TextStyle(color: kBlackColor,fontSize: kHeading3Size,fontWeight: FontWeight.w600);

final kDarkBoldSmallStyle = TextStyle(fontSize: 12.sp,color: kBlackColor,fontWeight: FontWeight.bold);
final kDarkBoldNormalStyle = TextStyle(fontSize:kNormalSize,color: kBlackColor,fontWeight: FontWeight.bold);
final kDarkBoldLargeStyle = TextStyle(fontSize:kLargeSize,color: kBlackColor,fontWeight: FontWeight.bold);
final kDarkBoldExtraLargeStyle = TextStyle(fontSize:kExtraLargeSize,color: kBlackColor,fontWeight: FontWeight.bold);

final kLightBoldSmallStyle = TextStyle(fontSize: 12.sp,color: kWhiteColor,fontWeight: FontWeight.bold);
final kLightBoldNormalStyle = TextStyle(fontSize:kNormalSize,color: kWhiteColor,fontWeight: FontWeight.bold);
final kLightBoldLargeStyle = TextStyle(fontSize:kLargeSize,color: kWhiteColor,fontWeight: FontWeight.bold);

final kDarkLightBoldNormalStyle = TextStyle(fontSize:kNormalSize,color: kBlackColor,fontWeight: FontWeight.bold);

final kDarkExtraSmallStyle = TextStyle(fontSize:kExtraSmallSize,color: kBlackColor);
final kDarkSmallStyle = TextStyle(fontSize:kSmallSize,color: kBlackColor);
final kDarkNormalStyle = TextStyle(fontSize:kNormalSize,color: kBlackColor);
final kDarkLargeStyle = TextStyle(fontSize:kLargeSize,color: kBlackColor);
final kDarkExtraLargeStyle = TextStyle(fontSize:kExtraLargeSize,color: kBlackColor);

final kLightSmallStyle = TextStyle(fontSize:kSmallSize,color: kWhiteColor);


final kVerticalSpace4 = SizedBox(
  height: 4.h,
);
final kVerticalSpace6 = SizedBox(
  height: 6.h,
);
final kVerticalSpace8 = SizedBox(
  height: 8.h,
);
final kVerticalSpace12 = SizedBox(
  height: 12.h,
);
final kVerticalSpace16 = SizedBox(
  height: 16.h,
);
final kVerticalSpace20 = SizedBox(
  height: 20.h,
);
final kVerticalSpace24 = SizedBox(
  height: 24.h,
);
final kVerticalSpace28 = SizedBox(
  height: 28.h,
);final kVerticalSpace50 = SizedBox(
  height: 50.h,
);
final kHorizontalSpace4 = SizedBox(
  width: 4.w,
);
final kHorizontalSpace8 = SizedBox(
  width: 8.w,
);
final kHorizontalSpace12 = SizedBox(
  width: 12.w,
);
final kHorizontalSpace16 = SizedBox(
  width: 16.w,
);
final kHorizontalSpace20 = SizedBox(
  width: 20.w,
);
final kHorizontalSpace24 = SizedBox(
  width: 24.w,
);
final kHorizontalSpace28 = SizedBox(
  width: 28.w,
);
