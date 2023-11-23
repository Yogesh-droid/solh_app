import 'dart:developer';

import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/products_list/data/models/product_list_model.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/entities/product_list_entity.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/usecases/product_list_usecase.dart';

class ProductsListController extends GetxController {
  final ProductListUsecase productListUsecase;

  ProductsListController({required this.productListUsecase});
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var productList = <Products>[].obs;
  var error = ''.obs;

  bool isListEnd = false;

  Future<void> getProductList(String categoryId, int pageNo,
      {String? queryParams = '', int? limit = 10}) async {
    if (isLoadingMore.value) {
      return;
    }
    final String url =
        "${APIConstants.api}/api/product/product-list?category=$categoryId&page=$pageNo$queryParams&limit=$limit";
    try {
      if (pageNo > 1) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
      }
      final ProductDataState<ProductListEntity> productDataState =
          await productListUsecase.call(RequestParams(url: url));
      if (productDataState.data != null) {
        if (pageNo > 1) {
          productList.addAll(productDataState.data!.products!);
          productList.refresh();
          isLoadingMore.value = false;
        } else {
          productList.value = productDataState.data!.products!;
          isLoading.value = false;
        }
        isListEnd = productDataState.data!.pages!.next == null;
      } else {
        error.value = productDataState.exception.toString();
        log("Error is ${error.value}");
        isLoading.value = false;
        isLoadingMore.value = false;
      }
    } on Exception catch (e) {
      log(e.toString());
      error.value = e.toString();
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }
}
