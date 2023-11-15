import 'dart:developer';

import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/wishlist/domain/usecase/add_delete_wishlist_item_usecase.dart';

class AddDeleteWishlistItemController extends GetxController {
  AddDeleteWishlistItemUsecase addDeleteWishlistItemUsecase;

  AddDeleteWishlistItemController({required this.addDeleteWishlistItemUsecase});

  var isLoading = false.obs;
  var error = ''.obs;
  Future<void> addDeleteWhishlist(Map<String, dynamic> body) async {
    try {
      isLoading.value = true;
      final ProductDataState dataState =
          await addDeleteWishlistItemUsecase.call(RequestParams(
              url: '${APIConstants.api}/api/product/add-to-wishlist',
              body: body));

      if (dataState.data != null) {
        Utility.showToast("Wishlist updated successfully");
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
