import 'dart:developer';

import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/home/domain/entities/feature_product_entity.dart';
import 'package:solh/ui/screens/products/features/home/domain/entities/product_category_entity.dart';
import 'package:solh/ui/screens/products/features/home/domain/usecases/feature_products_usecase.dart';

class FeatureProductsController extends GetxController {
  final FeatureProductsUsecase featureProductsUsecase;
  FeatureProductsController({required this.featureProductsUsecase});
  var isLoading = false.obs;
  var error = ''.obs;
  var featureProductList = <FeatureProductsEntity>[].obs;

  Future<void> getFeatureProducts() async {
    try {
      isLoading.value = true;
      final ProductDataState<List<FeatureProductsEntity>> dataState =
          await featureProductsUsecase.call(RequestParams(
              url:
                  '${APIConstants.api}/api/product/feature-product-list?page=1&limit=10'));

      if (dataState.data != null) {
        featureProductList.value = dataState.data!;
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
