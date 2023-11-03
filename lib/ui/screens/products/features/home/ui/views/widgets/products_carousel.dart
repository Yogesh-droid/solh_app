import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/ui/screens/home/home_controller.dart';

class ProductsCarousel extends StatelessWidget {
  ProductsCarousel({super.key});

  final CarouselController buttonCarouselController = CarouselController();
  HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _controller.isHomeProductsCarouselLoading.value
          ? Container()
          : (CarouselSlider(
              items: _controller
                  .homePageCarouselModel.value.packageCarouselList!
                  .map((e) => Image.network(e.image ?? ''))
                  .toList(),
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                autoPlay: false,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                initialPage: 1,
              ),
            ));
    });
  }
}
