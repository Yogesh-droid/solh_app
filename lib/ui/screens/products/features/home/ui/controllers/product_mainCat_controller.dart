import 'dart:developer';

import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/home/domain/entities/product_mainCat_entity.dart';
import 'package:solh/ui/screens/products/features/home/domain/usecases/product_mainCat_usecase.dart';

class ProductMainCatController extends GetxController {
  final ProductMainCatUsecase productMainCatUsecase;

  ProductMainCatController({required this.productMainCatUsecase});
  var mainCatList = <ProductMainCatEntity>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  Future<void> getMainCat() async {
    try {
      isLoading.value = true;
      final ProductDataState<List<ProductMainCatEntity>> productDataState =
          await productMainCatUsecase.call(RequestParams(
              url: "${APIConstants.api}/api/product/main-category"));

      if (productDataState.data != null) {
        isLoading.value = false;
        mainCatList.value = productDataState.data!;
      } else {
        isLoading.value = false;
        error.value = productDataState.exception.toString();
      }
    } on Exception catch (e) {
      log(e.toString());
      isLoading.value = false;
      error.value = e.toString();
    }
  }
}
