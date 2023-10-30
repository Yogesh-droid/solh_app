import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsCarousel extends StatelessWidget {
  ProductsCarousel({super.key});

  final CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Image.network("https://picsum.photos/seed/picsum/300/200"),
      ],
      carouselController: buttonCarouselController,
      options: CarouselOptions(
        autoPlay: false,
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
        initialPage: 1,
      ),
    );
  }
}
