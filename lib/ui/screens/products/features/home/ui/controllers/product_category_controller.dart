import 'dart:developer';
import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/home/domain/entities/product_category_entity.dart';
import 'package:solh/ui/screens/products/features/home/domain/usecases/products_category_usecase.dart';

class ProductsCategoryController extends GetxController {
  final ProductsCategoryUsecase productsCategoryUsecase;

  ProductsCategoryController({required this.productsCategoryUsecase});

  var productCategoryList = <ProductCategoryEntity>[].obs;
  var error = ''.obs;
  var isLoading = false.obs;

  Future<void> getProductsCategories() async {
    try {
      isLoading.value = true;
      final ProductDataState<List<ProductCategoryEntity>> dataState =
          await productsCategoryUsecase.call(RequestParams(
              url: '${APIConstants.api}/api/product/sub-main-category'));

      if (dataState.data != null) {
        productCategoryList.value = dataState.data!;
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
