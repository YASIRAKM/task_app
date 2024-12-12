import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageViewWidget extends StatelessWidget {
  final String url;
  double imageHight;
  double imageWidth;
  bool isCircularImage;
  BoxFit fit;

  ImageViewWidget(
      {super.key,
      required this.url,
      this.imageHight = 150,
      this.imageWidth = 150,
      this.isCircularImage = false,
      this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      imageBuilder: (context, imageProvider) {
        return Container(
          height: imageHight,
          width: imageWidth,
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: fit,
                image: imageProvider,
              ),
              shape: BoxShape.circle),
        );
      },
      placeholder: (context, url) => Container(
          height: imageHight,
          width: imageWidth,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: const Center(
            child: CupertinoActivityIndicator(),
          )),
      errorWidget: (context, url, error) => Container(
          height: imageHight,
          width: imageWidth,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: const Center(child: Icon(Icons.error))),
    );
  }
}
