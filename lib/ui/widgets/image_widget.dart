
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/strings.dart';


class ImageWidget extends StatelessWidget {
  final url;
  final double width;
  final double height;
  final isLocalImage;
  final bool isProfileImage;
  final file;
  final fit;
  final bgColor;
  final bool isCircular;
  final bool isProfilePlaceHolder;

  ImageWidget(this.url,
      {this.isCircular = false,
      this.bgColor,
      this.width = double.infinity,
      this.file,
      this.height = double.infinity,
      this.isLocalImage = false,
      this.isProfileImage = false,
      this.fit = BoxFit.contain,
      this.isProfilePlaceHolder=false});

  @override
  Widget build(BuildContext context) {
    if (file != null) {
      return ClipRRect(
          borderRadius: isCircular
              ? BorderRadius.circular(width + height / 2)
              : BorderRadius.zero,
          child: Image.file(
            file,
            width: width,
            height: height,
            fit: fit,
          ));
    }
    else if (isLocalImage) {
      return ClipRRect(
          borderRadius: isCircular
              ? BorderRadius.circular(width + height / 2)
              : BorderRadius.zero,
          child: Image.asset(
            url,
            width: width,
            height: height,
            fit: fit,
          ));
    }
    else {
      try{
        return ClipRRect(
          borderRadius: isCircular
              ? BorderRadius.circular(width + height / 2)
              : BorderRadius.zero,
          child: CachedNetworkImage(
            imageUrl: url ?? "",
            width: width,
            height: height,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                color: bgColor,
                image: DecorationImage(
                  image: imageProvider,
                  fit: fit,
                ),
              ),
            ),
            placeholder: (context, url) => Image.asset(kLogo),
            errorWidget: (context, url, error) => Image.asset(kLogo),
          ),
        );
      }catch(ex){
        return ClipRRect(
          borderRadius: isCircular
              ? BorderRadius.circular(width + height / 2)
              : BorderRadius.zero,
          child: Container(
              width: width,
              height: height,
              color: kGreyColor,
              child: Image.asset(kLogo)
          )
        );
      }

    }
  }
}
