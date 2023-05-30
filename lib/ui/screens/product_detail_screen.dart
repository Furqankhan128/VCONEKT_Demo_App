import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vconekt_demo_app/ui/screens/photo_view_screen.dart';
import 'package:vconekt_demo_app/ui/widgets/button_widget.dart';

import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../constants/style.dart';
import '../../models/product_model.dart';
import '../widgets/app_bar.dart';
import '../widgets/build_rating_stars.dart';
import '../widgets/image_loader.dart';
import '../widgets/image_widget.dart';
class ProductDetailScreen extends StatefulWidget {

  ProductDetailScreen(this.product);

  final Product product;

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  late Product _product;
  void _loadProduct(product){
    _product=product;
    _current=0;
    _qty=1;
  }

  late int _current;
  int? _qty;

@override
  void initState() {

  _loadProduct(widget.product);

  // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context,title: "Overview"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 0.45.sh,
                      viewportFraction: 1,
                      initialPage: _current,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }
                      ,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration:
                      Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                    ),
                    items: _product.images.map((img) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=> PhotoViewScreen(
                                    galleryItems: _product
                                        .images,
                                    backgroundDecoration: const BoxDecoration(
                                      color: Colors.black,
                                    ),
                                    loadingBuilder: (
                                        BuildContext context,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress !=
                                          null)
                                        return ImageLoader();
                                      else
                                        return Container();
                                    },
                                    initialIndex: _current,
                                    scrollDirection: Axis
                                        .horizontal,
                                  ),
                                  )

                              );
                            },
                            child: ImageWidget(img, fit: BoxFit.cover,


                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),

                  Padding(
                    padding: kScreenPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _product.images.map((img) {
                        int index = _product.images.indexOf(img);
                        return Container(
                          width:  10.r,
                          height: 10.r,
                          margin: EdgeInsets.only(right: 4.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: kAccentColor,width: 0.5.w),
                            shape: BoxShape.circle,
                            color: _current == index
                                ? kAccentColor
                                : Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: kScreenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    Text(
                      _product.title??"",
                      style: kBlackHeading3Style,
                      textAlign: TextAlign.center,),
                    kVerticalSpace4,
                    Center(child: buildRatingStars(_product.rating??5.0,iconSize: kIconSize)),

                    kVerticalSpace8,
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween,
                      children: [
                        _product.discountPercentage != null ?
                        FittedBox(
                          fit:BoxFit.scaleDown,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                  "${_product.price!-(_product.price!*_product.discountPercentage!/100)}",
                                  style: kProductOverviewPriceTextStyle),
                              kVerticalSpace4,
                              Row(
                                children: [
                                  Text(
                                    "$kCurrency ${_product.price}",
                                    style: kDarkNormalStyle.copyWith(
                                      decoration: TextDecoration
                                          .lineThrough,
                                    ),),
                                  kHorizontalSpace4,
                                  Text(
                                      "(${_product
                                          .discountPercentage}% Off)",
                                      style: kDarkNormalStyle
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ) : FittedBox(
                          fit:BoxFit.scaleDown,
                          child: Text(
                              "$kCurrency ${_product.price}",
                              style: kProductOverviewPriceTextStyle),
                        ),


                      ],

                    ),
                    kVerticalSpace4,

                    Column(
                      children: [

                        Row(children: [
                          InkWell(
                            onTap: () {
                              if (_qty! > 1) {
                                setState(() {
                                  _qty=_qty!-1;
                                });
                              }
                            },
                            child: Container(
                              height: 40.w,
                              width: 40.w,
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(
                                color: kGreyColor,
                                border: Border.all(
                                    width: 0.5.w,
                                    color: kAccentColor),
                              ),
                              child: Icon(MaterialCommunityIcons.minus,size: kIconSize,),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 40.w,
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5.w,
                                    color: kAccentColor),
                              ),
                              child:
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "$_qty", style: kBlackHeading3Style,),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _qty= _qty!+1;
                              });
                            },
                            child: Container(
                              height: 40.w,
                              width: 40.w,
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(
                                color: kGreyColor,
                                border: Border.all(
                                    width: 0.5.w,
                                    color: kAccentColor),
                              ),
                              child: Icon(MaterialCommunityIcons.plus,size: kIconSize,),
                            ),
                          )
                        ],),

                        kVerticalSpace8,
                        ButtonWidget(
            text: "Add to cart",
                            onPressed: (){},
                        icon: MaterialCommunityIcons.cart_plus,)
                      ],),


                    kVerticalSpace8,
                    Text("Description", style: kBlackHeading3Style,),

                    kVerticalSpace4,
                    Text(_product.description??"",
                      style: kDarkNormalStyle,),
                    kVerticalSpace12,
                  ],
                ),
              )
            ],
          ),),);
  }



}
