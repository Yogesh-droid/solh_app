import 'package:get/get.dart';
import 'package:solh/constants/api.dart';

import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/product_detail/data/model/product_details_model.dart';
import 'package:solh/ui/screens/products/features/product_detail/domain/usecases/product_detail_usecase.dart';

class ProductDetailController extends GetxController {
  final ProductDetailUsecase productDetailUsecase;
  var isLoading = false.obs;
  var productDetail = ProductDetailsModel().obs;
  var error = ''.obs;

  ProductDetailController({required this.productDetailUsecase});

  Future<void> getProductDetail(String id) async {
    try {
      isLoading.value = true;

      final ProductDataState<ProductDetailsModel> dataState =
          await productDetailUsecase.call(RequestParams(
              url: "${APIConstants.api}/api/product/product-details/$id"));

      if (dataState.data != null) {
        productDetail.value = dataState.data!;
      } else {
        error.value = dataState.exception.toString();
      }

      isLoading.value = false;
    } on Exception catch (e) {
      isLoading.value = false;
      error.value = e.toString();
    }
  }
}
