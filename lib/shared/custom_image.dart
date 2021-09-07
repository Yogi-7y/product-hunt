import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_hunt/core/resources/colors.dart';
import 'package:product_hunt/core/resources/strings.dart';
import 'package:product_hunt/shared/loading_wrapper.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;

  const CustomCachedImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => Center(
          child: LoadingWrapper(
              child: Container(
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ))),
      errorWidget: (_, __, dynamic ___) => const Center(
        child: Text(kSomethingWentWrongMessage),
      ),
      imageBuilder: (context, imageProvider) => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.red,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
