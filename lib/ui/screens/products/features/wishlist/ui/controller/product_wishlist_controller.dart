import 'dart:developer';

import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/wishlist/domain/entity/product_wishlist_items_entity.dart';
import 'package:solh/ui/screens/products/features/wishlist/domain/usecase/product_wishlist_usecase.dart';

class ProductWishlistController extends GetxController {
  ProductWishlistUsecase productWishlistUsecase;
  ProductWishlistController({required this.productWishlistUsecase});
  var isLoading = false.obs;
  var error = ''.obs;

  var wishlistItems = [].obs;

  Future<void> getWishlistProducts() async {
    try {
      isLoading.value = true;
      final ProductDataState<List<ProductWishlistEntity>> dataState =
          await productWishlistUsecase.call(RequestParams(
              url: 'http://192.168.1.12:3000/api/product/get-wishlist'));

      if (dataState.data != null) {
        wishlistItems.value = dataState.data!;
      } else {
        error.value = dataState.exception.toString();
        log(dataState.exception.toString());
      }
      isLoading.value = false;
    } on Exception catch (e) {
      isLoading.value = false;
      error.value = e.toString();
      log(e.toString());
    }
  }
}
