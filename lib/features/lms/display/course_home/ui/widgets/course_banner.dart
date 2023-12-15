import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CourseBanner extends StatelessWidget {
  const CourseBanner({super.key, required this.images});
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: images.length,
            itemBuilder: (context, index, index2) => Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(imageUrl: images[index])),
                ),
            options: CarouselOptions(
                autoPlay: true, enlargeFactor: 0.7, height: 200))
      ],
    );
  }
}
