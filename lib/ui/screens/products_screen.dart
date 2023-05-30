import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vconekt_demo_app/blocs/get_products_by_category_bloc.dart';
import 'package:vconekt_demo_app/events/product_event.dart';
import 'package:vconekt_demo_app/global_variables.dart';
import 'package:vconekt_demo_app/ui/screens/product_detail_screen.dart';

import '../../blocs/get_products_bloc.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../constants/style.dart';
import '../../models/product_model.dart';
import '../../states/product_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/app_bar.dart';
import '../widgets/image_widget.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key,required this.products}) : super(key: key);

  List<Product> products = [];


  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: buildAppBar(context,title: "Products"),
      body: products.isNotEmpty ?
      Column(
        children: [

          kVerticalSpace8,
          Expanded(
            child: ListView.separated(
              itemCount: products.length,
              shrinkWrap: true,
              itemBuilder: (context,index)=>
                  OpenContainer(
                      openElevation: 0.0,
                      closedElevation: 0.0,
                      transitionDuration: Duration(milliseconds: 400),
                      closedColor: kPrimaryColor,
                      middleColor: kPrimaryColor,
                      transitionType: ContainerTransitionType.fade,
                      closedBuilder: (context, VoidCallback openContainer)=>Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Container(
                          width: 1.sw,
                          height: 80.h,
                          decoration: BoxDecoration(
                            borderRadius: kBorderRadius12,
                            color: Colors.grey.shade100,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: ImageWidget(

                                  products[index].thumbnail,
                                  height: 80.h,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              kHorizontalSpace8,
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(products[index].title??"",style: kDarkBoldLargeStyle,overflow: TextOverflow.ellipsis,)),
                                    kVerticalSpace4,
                                    Text("$kCurrency ${products[index].price}" ,style: kDarkNormalStyle,),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      openBuilder: (context,_)=> ProductDetailScreen(products[index])
                  )
              ,
              separatorBuilder: (context,index)=>kVerticalSpace12,
            ),
          ),
        ],
      ):
      SizedBox(
        width: 1.sw,
        height: 0.9.sh,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageWidget(kLogo, height: 50.h,width: 50.h,isLocalImage: true,fit: BoxFit.fill,),
            Text("Products are not available",style: kDarkBoldSmallStyle,)
          ],
        ),
      ),
    );
  }
}
