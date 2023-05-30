
import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vconekt_demo_app/blocs/get_products_bloc.dart';
import 'package:vconekt_demo_app/blocs/get_products_by_category_bloc.dart';
import 'package:vconekt_demo_app/constants/style.dart';
import 'package:vconekt_demo_app/events/product_event.dart';
import 'package:vconekt_demo_app/routes.dart';
import 'package:vconekt_demo_app/states/product_state.dart';
import 'package:vconekt_demo_app/ui/screens/product_detail_screen.dart';
import 'package:vconekt_demo_app/ui/screens/products_by_category_screen.dart';
import 'package:vconekt_demo_app/ui/screens/products_screen.dart';
import 'package:vconekt_demo_app/ui/widgets/drawer_widget.dart';

import '../../blocs/get_categories_bloc.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../events/category_event.dart';
import '../../states/category_state.dart';
import '../widgets/image_widget.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  int _current = 0;

  FocusNode focusNode = FocusNode();


@override
  void initState() {
  if(BlocProvider.of<GetCategoriesBloc>(context).state is !GetCategoriesSuccessState){
    BlocProvider.of<GetCategoriesBloc>(context).add(GetCategories());
  }
  if(BlocProvider.of<GetProductsBloc>(context).state is !GetProductsSuccessState){
    BlocProvider.of<GetProductsBloc>(context).add(GetProducts());
  }

  super.initState();
  }




  Future<void> _refreshCategories() async{
    BlocProvider.of<GetCategoriesBloc>(context).add(GetCategories());
  }
  Future<void> _refreshProducts() async{
    BlocProvider.of<GetProductsBloc>(context).add(GetProducts());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 0.3.sh,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    enlargeCenterPage: false,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    initialPage: _current,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                  items: List.generate(3, (index) => Builder(
                    builder: (BuildContext context) {
                      return Stack(
                        children: [
                          ImageWidget(
                            "images/s${index+1}.jpg",
                            fit: BoxFit.fill,
                            isLocalImage: true,
                          ),
                        ],
                      );
                    },
                  )).toList(),
                ),
                Positioned(
                  left: 8,
                  top: 8,
                  child: Builder(
                    builder: (context) => Container(
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        shape: BoxShape.circle
                      ),
                      child: IconButton(
                        iconSize: kMenuIconSize,
                          color: kBlackColor,
                          icon: const Icon(
                            Icons.menu,
                          ),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          }),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 1.sw,
                    height: 20.h,
                    decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50.r),
                          topLeft: Radius.circular(50.r),
                        )),
                  ),
                )
              ],
            ),


            BlocBuilder<GetCategoriesBloc, CategoryState>(
              builder: (context, state) {
                if (state is GetCategoriesLoadingState) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Shimmer.fromColors(
                          child: Container(
                            height: 20.h,
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: kBorderRadius12,

                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                          ),
                          highlightColor: Colors.grey.shade300,
                          baseColor: kWhiteColor,
                        ),
                        kVerticalSpace8,
                        Padding(
                          padding:
                          EdgeInsets.only(right: 8.w, left: 8.w, bottom: 16.w),
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1,
                                crossAxisCount: 3,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8),
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kWhiteColor,
                                    borderRadius: kBorderRadius12
                                  ), ),
                                highlightColor: Colors.grey.shade300,
                                baseColor: kWhiteColor,
                              );
                            },
                            shrinkWrap: true,
                            itemCount:  6 ,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                else if (state is GetCategoriesSuccessState) {

                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                          "Categories",
                              style: kDarkBoldExtraLargeStyle,
                            ),
                            Spacer(),
                            IconButton(icon: Icon(Icons.refresh,color: kAccentColor,size: 25.sp,), onPressed: _refreshCategories),

                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 12.w, left: 12.w, bottom: 16.w),
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 1,
                              crossAxisCount:3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8),
                          itemBuilder: (context, index) {
                             return  OpenContainer(
                               openElevation: 0,
                                 closedElevation: 0,
                                 transitionDuration: Duration(milliseconds: 400),
                                 closedColor: kPrimaryColor,
                                 middleColor: kPrimaryColor,
                                 transitionType: ContainerTransitionType.fadeThrough,
                                 closedBuilder: (context, VoidCallback openContainer)=>Card(
                                   color: Colors.grey.shade100,
                                   margin: EdgeInsets.symmetric(
                                       horizontal: 2.w, vertical: 2.w),
                                   shape: RoundedRectangleBorder(
                                       borderRadius: kBorderRadius12),
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,

                                     children: [
                                       ImageWidget(
                                         kLogo,
                                         fit: BoxFit.fill,
                                         width: 40.w,
                                         height: 40.w,
                                         isLocalImage: true,
                                       ),
                                       kVerticalSpace8,
                                       FittedBox(
                                         fit: BoxFit.contain,
                                         child: Text(
                                           state.categoryModel.categories[index].toUpperCase(),
                                           maxLines: 2,
                                           overflow: TextOverflow.ellipsis,
                                           textAlign: TextAlign.center,
                                           style: kDarkBoldSmallStyle,
                                         ),
                                       ),
                                       kVerticalSpace8,
                                     ],
                                   ),
                                 ),
                                 openBuilder: (context,_)=> ProductsByCategoryScreen(category: state.categoryModel.categories[index])
                             )


                               ;
                             },
                          shrinkWrap: true,
                          itemCount: state.categoryModel.categories.length > 6
                              ? 6
                              : state.categoryModel.categories.length,
                        ),
                      ),
                    ],
                  );
                }
                else if (state is GetCategoriesErrorState) {
                  return Container(
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
                            onPressed: _refreshCategories),
                        Text(
                          "Refresh Categories",
                          style: kDarkBoldNormalStyle,
                        )
                      ],
                    ),
                  );
                }
                else {
                  return Container(
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
                            onPressed: _refreshCategories),
                        Text(
                          "Refresh Categories",
                          style: kDarkBoldNormalStyle,
                        )
                      ],
                    ),
                  );
                }
              },
            ),

            BlocBuilder<GetProductsBloc, ProductState>(
              builder: (context, state) {
                if (state is GetProductsLoadingState) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Shimmer.fromColors(
                          child: Container(
                            height: 40.h,
                              color: kWhiteColor,
                          ),
                          highlightColor: Colors.grey.shade300,
                          baseColor: kWhiteColor,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12.w),
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
                        ),
                      ],
                    ),
                  );
                }
                else if (state is GetProductsSuccessState) {

                  return
                    state.productModel.products.isNotEmpty ?
                    Column(
                      children: [
                        Container(
                          width: 1.sw,
                          height: 40.h,
                          color: Colors.grey.shade300,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                              "Latest Products",
                                style: kDarkBoldExtraLargeStyle,
                              ),
                              Spacer(),
                              IconButton(icon: Icon(Icons.refresh,color: kAccentColor,size: 25.sp,), onPressed: _refreshProducts),
                              GestureDetector(
                                onTap: () {
                                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductsScreen(products: state.productModel.products,)));
                                },
                                child: Text(
                "See All",
                                  style: kDarkLightBoldNormalStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        kVerticalSpace12,
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 5,
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
                            tag: state.productModel.products[index].productId.toString(),
                            child: ImageWidget(

                              state.productModel.products[index].thumbnail,
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
                                  child: Text(state.productModel.products[index].title??"",style: kDarkBoldLargeStyle,overflow: TextOverflow.ellipsis,)),
                              kVerticalSpace4,
                              Text("$kCurrency ${state.productModel.products[index].price}" ,style: kDarkNormalStyle,),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                openBuilder: (context,_)=> ProductDetailScreen(state.productModel.products[index])
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
                else if (state is GetProductsErrorState) {
                  return Container(
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
                            onPressed: _refreshProducts),
                        Text(
                         "Retry",
                          style: kDarkBoldNormalStyle,
                        )
                      ],
                    ),
                  );
                }
                else {
                  return Container(
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
                            onPressed: _refreshProducts),
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

          ],
        ),
      ),
    );
  }
}
