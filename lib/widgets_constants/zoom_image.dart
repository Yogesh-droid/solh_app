import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ZoomImage extends StatelessWidget {
  ZoomImage({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Hero(
              tag: 'profile',
              child: CachedNetworkImage(
                fit: BoxFit.fitWidth,
                imageUrl: image,
              ))),
    );
  }
}
