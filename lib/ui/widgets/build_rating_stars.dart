
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

Widget buildRatingStars(double ratings,{iconSize=12.0}){
  List<Widget> stars=[];
  for(int i=1;i<=5;i++){
    if(ratings>=i){
      stars.add(Icon(MaterialCommunityIcons.star,color: Colors.amber,size: iconSize,));
    }else if((i-ratings)<1){
      stars.add(Icon(MaterialCommunityIcons.star_half,color: Colors.amber,size: iconSize,));
    }else{
      stars.add(Icon(MaterialCommunityIcons.star_outline,color: Colors.amber,size: iconSize,));
    }
  }

  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: stars,
  );
}