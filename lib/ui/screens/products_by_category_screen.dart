import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vconekt_demo_app/blocs/get_products_by_category_bloc.dart';
import 'package:vconekt_demo_app/events/product_event.dart';
import 'package:vconekt_demo_app/global_variables.dart';
import 'package:vconekt_demo_app/ui/screens/product_detail_screen.dart';
import 'package:vconekt_demo_app/ui/widgets/app_bar.dart';

import '../../blocs/get_products_bloc.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../constants/style.dart';
import '../../models/product_model.dart';
import '../../states/product_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/image_widget.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  ProductsByCategoryScreen({Key? key, required this.category}) : super(key: key);

  final String category;

  @override
  State<ProductsByCategoryScreen> createState() => _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {


  @override
  void initState() {
    BlocProvider.of<GetProductsByCategoryBloc>(context).add(GetProductsByCategory(category: widget.category));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: buildAppBar(context,title: widget.category),
      body: BlocBuilder<GetProductsByCategoryBloc, ProductState>(
          builder: (context, state) {
            if (state is GetProductsByCategoryLoadingState) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index)=>Shimmer.fromColors(
                    baseColor: kWhiteColor,
                    highlightColor: Colors.grey.shade300,
                    child: Container(color: kWhiteColor,width: 1.sw,height: 120.h,
                    ),
                  ),
                  separatorBuilder: (context,index)=>kVerticalSpace8,
                ),
              );
            }
            else if (state is GetProductsByCategorySuccessState) {

              return
                state.productModel.categoryProducts.isNotEmpty ?
                Column(
                  children: [
                    kVerticalSpace8,
                    ListView.separated(
                      itemCount: state.productModel.categoryProducts.length,
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
                                        child: Hero(
                                          tag: state.productModel.categoryProducts[index].productId.toString(),
                                          child: ImageWidget(

                                            state.productModel.categoryProducts[index].thumbnail,
                                            height: 80.h,
                                            fit: BoxFit.fill,
                                          ),
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
                                                child: Text(state.productModel.categoryProducts[index].title??"",style: kDarkBoldLargeStyle,overflow: TextOverflow.ellipsis,)),
                                            kVerticalSpace4,
                                            Text("$kCurrency ${state.productModel.categoryProducts[index].price}" ,style: kDarkNormalStyle,),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              openBuilder: (context,_)=> ProductDetailScreen(state.productModel.categoryProducts[index])
                          )
                      ,
                      separatorBuilder: (context,index)=>kVerticalSpace8,
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
                );
            }
            else if (state is GetProductsByCategoryErrorState) {
              return SizedBox(
                height: 0.2.sh,
                width: 1.sw,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        iconSize: 70.sp,

                        icon: Icon(
                          Icons.refresh,
                          color: kAccentColor,
                          size: 70.sp,
                        ),
                        onPressed: (){
                          BlocProvider.of<GetProductsByCategoryBloc>(context).add(GetProductsByCategory(category: widget.category));
                        }),
                    Text(
                      "Retry",
                      style: kDarkBoldNormalStyle,
                    )
                  ],
                ),
              );
            }
            else {
              return SizedBox(
                height: 0.2.sh,
                width: 1.sw,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        iconSize: 70.sp,

                        icon: Icon(
                          Icons.refresh,
                          color: kAccentColor,
                          size: 70.sp,
                        ),
                        onPressed: (){
                          BlocProvider.of<GetProductsByCategoryBloc>(context).add(GetProductsByCategory(category: widget.category));
                        }),
                    Text(
                      "Retry",
                      style: kDarkBoldNormalStyle,
                    )
                  ],
                ),
              );
            }
          },
        ),
    );
  }
}
