import 'dart:developer';

import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/home/domain/entities/product_home_carousel_entity.dart';
import 'package:solh/ui/screens/products/features/home/domain/usecases/products_home_carousel_usecase.dart';

class ProductsHomeCarouselController extends GetxController {
  final ProductsHomeCarouselUsecase productsHomeCarouselUsecase;

  ProductsHomeCarouselController({required this.productsHomeCarouselUsecase});

  var homeCarouselBanners = <ProductHomeCarouselEntity>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  Future<void> getBanners() async {
    try {
      isLoading.value = true;
      final ProductDataState<List<ProductHomeCarouselEntity>> bannerData =
          await productsHomeCarouselUsecase.call(RequestParams(
              url: "${APIConstants.api}/api/product/product-banner"));

      if (bannerData.data != null) {
        isLoading.value = false;
        homeCarouselBanners.value = bannerData.data!;
      } else {
        isLoading.value = false;
        error.value = bannerData.exception.toString();
      }
    } on Exception catch (e) {
      log(e.toString());
      isLoading.value = false;
      error.value = e.toString();
    }
  }
}
