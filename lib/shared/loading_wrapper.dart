import 'package:flutter/material.dart';
import 'package:product_hunt/core/resources/colors.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWrapper extends StatelessWidget {
  final Widget child;

  const LoadingWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kMysticColor,
      highlightColor: kMysticColor.withOpacity(.1),
      child: child,
    );
  }
}
