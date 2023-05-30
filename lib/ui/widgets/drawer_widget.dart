 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:vconekt_demo_app/constants/strings.dart';

import '../../constants/colors.dart';
import '../../constants/style.dart';
import 'image_widget.dart';

 class DrawerWidget extends StatefulWidget {
   const DrawerWidget({Key? key}) : super(key: key);

   @override
   State<DrawerWidget> createState() => _DrawerWidgetState();
 }


 class _DrawerWidgetState extends State<DrawerWidget> {



   @override
   Widget build(BuildContext context) {




     return SizedBox(
       width: 0.8.sw,
       child: SafeArea(
         child: Drawer(backgroundColor:   Theme.of(context).scaffoldBackgroundColor,
           child: SingleChildScrollView(
             child: Column(
               children: [

                 Padding(padding: EdgeInsetsDirectional.only(start: 32.w,end: 32.w,bottom: 16.w),child:
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   children: [
                     kVerticalSpace16,
                     ImageWidget(kLogo,isLocalImage: true,
                       fit: BoxFit.scaleDown,
                       height: 0.15.sh,
                     ),
                   ],
                 ),
                 ),

                 Divider(color: kGreyColor,thickness: 1.w, ),

                 kVerticalSpace8,

                 DrawerItem(text: "Home",icon: MaterialCommunityIcons.home,onTap: (){
                   // Get.offAndToNamed(Routes.navigationScreen,arguments: 0);
                 },isSelected: true,),

                 kVerticalSpace12,

                 Text("App Version 1.0.0",style: TextStyle(color: kGreyColor,fontSize: 13.sp),),

                 kVerticalSpace24,
               ],
             ),
           ),
         ),
       ),
     );
   }
 }


class DrawerItem extends StatelessWidget {
  DrawerItem({Key? key,required this.icon,required this.text,required this.onTap,this.isSelected=false}) : super(key: key);

  final String text;
  final IconData icon;
  final Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: onTap,
      child:Container(
        height: 45.h,
        alignment: Alignment.center,
        padding: EdgeInsetsDirectional.only(start: 32.w),
        margin: EdgeInsetsDirectional.only(end: 12.w,top: 8.w),
        decoration: BoxDecoration(
            color: isSelected? kAccentColor:Colors.transparent,
            borderRadius: BorderRadiusDirectional.horizontal(end: Radius.circular(30.r))
        ),
        child: Row
          (
          children: [
            Icon(icon,color: kWhiteColor,size: 24.sp,),
            kHorizontalSpace12,
            Text(text,style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14.sp,fontWeight: FontWeight.w500,color: isSelected?kWhiteColor:kBlackColor),),

          ],
        ),
      )
    );
  }
}

