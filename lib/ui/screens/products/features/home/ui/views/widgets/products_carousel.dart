import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/bottom-navigation/bottom_navigator_controller.dart';
import 'package:solh/ui/screens/home/home_controller.dart';

class ProductsCarousel extends StatelessWidget {
  ProductsCarousel({super.key});

  final CarouselController buttonCarouselController = CarouselController();
  final HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _controller.isHomeProductsCarouselLoading.value
          ? Container()
          : _controller.productsHomeCarousel.value.banner != null
              ? _controller.productsHomeCarousel.value.banner!.isEmpty
                  ? const SizedBox.shrink()
                  : (_controller.productsHomeCarousel.value.banner!.length == 1
                      ? GestureDetector(
                          onTap: () => Get.find<BottomNavigatorController>()
                              .activeIndex
                              .value = 3,
                          // onTap: () => Navigator.of(context)
                          //     .pushNamed(AppRoutes.productsHome),
                          child: AspectRatio(
                            aspectRatio: 3 / 2,
                            child: Image.network(_controller
                                    .productsHomeCarousel
                                    .value
                                    .banner![0]
                                    .bannerImage ??
                                ''),
                          ),
                        )
                      : CarouselSlider(
                          items: _controller.productsHomeCarousel.value.banner!
                              .map((e) => GestureDetector(
                                  onTap: () =>
                                      Get.find<BottomNavigatorController>()
                                          .activeIndex
                                          .value = 3,
                                  child: Image.network(e.bannerImage ?? '')))
                              .toList(),
                          carouselController: buttonCarouselController,
                          options: CarouselOptions(
                            autoPlay: false,
                            enableInfiniteScroll: true,
                            enlargeCenterPage: true,
                            initialPage: 1,
                          ),
                        ))
              : const SizedBox();
    });
  }
}
