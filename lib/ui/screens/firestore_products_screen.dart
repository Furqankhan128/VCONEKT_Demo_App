import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vconekt_demo_app/blocs/firestore_bloc.dart';
import 'package:vconekt_demo_app/blocs/get_products_by_category_bloc.dart';
import 'package:vconekt_demo_app/events/firestore_event.dart';
import 'package:vconekt_demo_app/events/product_event.dart';
import 'package:vconekt_demo_app/global_variables.dart';
import 'package:vconekt_demo_app/routes.dart';
import 'package:vconekt_demo_app/ui/screens/product_detail_screen.dart';

import '../../blocs/get_products_bloc.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../constants/style.dart';
import '../../models/product_model.dart';
import '../../states/firestore_state.dart';
import '../../states/product_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/app_bar.dart';
import '../widgets/button_widget.dart';
import '../widgets/circular_loader.dart';
import '../widgets/image_widget.dart';

class FireStoreProductsScreen extends StatefulWidget {
  FireStoreProductsScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreProductsScreen> createState() => _FireStoreProductsScreenState();
}

class _FireStoreProductsScreenState extends State<FireStoreProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, title: "FireStore CRUD Operations",actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, Routes.addProductScreen,);
          }, icon: Icon(Icons.add_circle_outline)) 
        ]),
        body: BlocListener<FireStoreBloc, FireStoreState>(
            listener: (context, state) {
              if (state is DeleteProductLoadingState) {
                EasyLoading.show(status: "Loading...");
              }
              else if (state is DeleteProductErrorState) {
                EasyLoading.showError(state.errorModel.message!);
              }
              else if (state is DeleteProductSuccessState) {
                EasyLoading.showSuccess(state.successModel.message!);
              }

            },
            child: StreamBuilder<QuerySnapshot>(
            stream: gDatabase.collection('products').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularLoader(
                    color: kAccentColor,
                  ),
                );
              }
              final documents = snapshot.data?.docs;
              List<FireStoreProduct> fireStoreProducts = [];

              for (var document in documents!) {
                fireStoreProducts.add(FireStoreProduct(
                  title: document.get("title").toString(),
                  price: document.get("price").toString(),
                  productId: document.id,
                ));
              }
              return fireStoreProducts.isNotEmpty
                  ? Column(
                      children: [
                        kVerticalSpace8,
                        Expanded(
                          child: ListView.separated(
                            itemCount: fireStoreProducts.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => OpenContainer(
                                openElevation: 0.0,
                                closedElevation: 0.0,
                                transitionDuration: Duration(milliseconds: 400),
                                closedColor: kPrimaryColor,
                                middleColor: kPrimaryColor,
                                transitionType: ContainerTransitionType.fade,
                                closedBuilder: (context,
                                        VoidCallback openContainer) =>
                                    Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.w),
                                          child: Container(
                                            width: 1.sw,
                                            height: 80.h,
                                            decoration: BoxDecoration(
                                              borderRadius: kBorderRadius12,
                                              color: Colors.grey.shade100,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: ImageWidget(
                                                    kLogo,
                                                    fit: BoxFit.contain,
                                                    isLocalImage: true,
                                                  ),
                                                ),
                                                kHorizontalSpace8,
                                                Expanded(
                                                  flex: 3,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          child: Text(
                                                            fireStoreProducts[index]
                                                                    .title ??
                                                                "",
                                                            style:
                                                                kDarkBoldLargeStyle,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                          )),
                                                      kVerticalSpace4,
                                                      Text(
                                                        "$kCurrency ${fireStoreProducts[index].price}",
                                                        style: kDarkNormalStyle,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical:6.w,horizontal: 20.w),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  Navigator.pushNamed(context, Routes.updateProductScreen,arguments: fireStoreProducts[index]);
                                                },
                                                child: CircleAvatar(
                                                  child: Icon(Icons.edit,color: kWhiteColor,size: kLargeSize),
                                                  backgroundColor: kAccentColor,
                                                  radius: 15.r,
                                                ),
                                              ),
                                              kHorizontalSpace8,
                                              InkWell(
                                                onTap: (){
                                                   showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (context) => AlertDialog(
                                                        buttonPadding: EdgeInsets.zero,
                                                        actionsPadding: EdgeInsets.zero,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(12.r)),
                                                        title: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              MaterialCommunityIcons.information_outline,
                                                              color: Colors.orange,
                                                              size: 50.sp,
                                                            ),
                                                            kVerticalSpace8,
                                                            Text(
                                                              "Confirmation Message",
                                                              style: TextStyle(
                                                                  color: kBlackColor,
                                                                  fontSize: 18.sp,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                          ],
                                                        ),
                                                        content: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              "Are you sure you want to delete this product?",
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                  color: kBlackColor,
                                                                  fontSize: 14.sp,
                                                                  fontWeight: FontWeight.w600),
                                                            ),
                                                            kVerticalSpace24,
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child: ButtonWidget(
                                                                      text: "Yes",
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                        BlocProvider.of<FireStoreBloc>(context).add(DeleteProduct(productId: fireStoreProducts[index].productId));
                                                                      }),
                                                                ),
                                                                kHorizontalSpace20,
                                                                Expanded(
                                                                  child: ButtonWidget(
                                                                      text: "No",
                                                                      onPressed:() {
                                                                        Navigator.pop(context);
                                                                      }),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ));
                                                },
                                                child: CircleAvatar(
                                                  child: Icon(Icons.delete,color: kWhiteColor,size: kLargeSize),
                                                  backgroundColor: kAccentColor,
                                                  radius: 15.r,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                openBuilder: (context, _) => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("No Data Available",style: kDarkBoldLargeStyle),
                                  ],
                                )),
                            separatorBuilder: (context, index) =>
                                kVerticalSpace12,
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      width: 1.sw,
                      height: 0.9.sh,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ImageWidget(
                            kLogo,
                            height: 50.h,
                            width: 50.h,
                            isLocalImage: true,
                            fit: BoxFit.fill,
                          ),
                          kVerticalSpace16,
                          Text(
                            "Products are not available",
                            style: kDarkBoldSmallStyle,
                          )
                        ],
                      ),
                    );
            })));
  }
}
