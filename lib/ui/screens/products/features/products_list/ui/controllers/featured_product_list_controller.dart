import 'dart:developer';

import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/products_list/data/models/featured_product_list_model.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/usecases/feaured_product_list_usecase.dart';

import '../../../../../../../constants/api.dart';
import '../../domain/entities/featuredProduct_list_entity.dart';

class FeaturedProductListController extends GetxController {
  final FeaturedProductsListUsecase featuredProductsListUsecase;
  var isLoading = false.obs;
  var featuredProductList = <FeaturedProducts>[].obs;
  var error = ''.obs;

  bool isListEnd = false;

  FeaturedProductListController({required this.featuredProductsListUsecase});

  Future<void> getFeaturedProductList(int pageNo,
      {String? queryParams = '', int? limit = 10}) async {
    final String url =
        "${APIConstants.api}/api/product/feature-product-lis?page=$pageNo&limit=$limit";

    try {
      isLoading.value = true;
      final ProductDataState<FeaturedProductListEntity> productDataState =
          await featuredProductsListUsecase.call(RequestParams(url: url));
      if (productDataState.data != null) {
        featuredProductList.value = productDataState.data!.featuredProducts!;
        isListEnd = productDataState.data!.pages!.next == null;
      } else {
        error.value = productDataState.exception.toString();
        log("Error is ${error.value}");
      }

      isLoading.value = false;
    } on Exception catch (e) {
      log(e.toString());
      error.value = e.toString();
      isLoading.value = false;
    }
  }
}
