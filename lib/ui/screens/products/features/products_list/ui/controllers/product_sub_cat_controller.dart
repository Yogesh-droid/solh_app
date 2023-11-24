import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/entities/product_sub_cat_entity.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/usecases/product_sub_cat_usecase.dart';

class ProductSubCatController extends GetxController {
  final ProductSubCatUsecase productSubCatUsecase;

  var productSubCatEntity = ProductSubCatEntity().obs;
  var isLoading = false.obs;
  var error = ''.obs;

  ProductSubCatController({required this.productSubCatUsecase});

  Future<void> getProductSubCat(String id) async {
    isLoading.value = true;
    try {
      final ProductDataState<ProductSubCatEntity> dataState =
          await productSubCatUsecase
              .call(RequestParams(
                  url:
                      "${APIConstants.api}/api/product/sub-category-by-main/$id"))
              .onError((error, stackTrace) => throw Exception(error));
      if (dataState.data != null) {
        productSubCatEntity.value = dataState.data!;
      } else {
        error.value = dataState.exception.toString();
      }
      isLoading.value = false;
    } on Exception catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }
}
