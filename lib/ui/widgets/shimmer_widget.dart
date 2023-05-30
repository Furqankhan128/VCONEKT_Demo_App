import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import '../../constants/colors.dart';

class ShimmerWidget extends StatelessWidget {
  final child;
  const ShimmerWidget({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: Colors.grey.shade100,
      highlightColor: kAccentColor.withOpacity(0.2),
      child: child,
    );
  }
}
