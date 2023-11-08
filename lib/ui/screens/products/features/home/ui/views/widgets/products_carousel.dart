import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/routes/routes.dart';
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
          : _controller.productsHomeCarousel.value.banner != null
              ? (_controller.productsHomeCarousel.value.banner!.length == 1
                  ? GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamed(AppRoutes.productsHome),
                      child: AspectRatio(
                        aspectRatio: 3 / 2,
                        child: Image.network(_controller.productsHomeCarousel
                                .value.banner![0].bannerImage ??
                            ''),
                      ),
                    )
                  : CarouselSlider(
                      items: _controller.productsHomeCarousel.value.banner!
                          .map((e) => GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .pushNamed(AppRoutes.productsHome),
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
              : SizedBox();
    });
  }
}
