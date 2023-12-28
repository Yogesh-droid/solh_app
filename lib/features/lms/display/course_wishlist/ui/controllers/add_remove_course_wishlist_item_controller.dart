import 'dart:developer';

import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/features/lms/display/course_wishlist/domain/usecases/add_remove_course_wishlist_item_usecase.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';

class AddRemoveCourseWishlistItemController extends GetxController {
  AddRemoveCourseWishlistItemUsecase addRemoveCourseWishlistItemUsecase;

  AddRemoveCourseWishlistItemController(
      {required this.addRemoveCourseWishlistItemUsecase});

  var isLoading = false.obs;
  var currentCourseRemoval = '';
  Future<(bool, String)> addRemoveCourseWishlistItem(String courseId) async {
    try {
      isLoading.value = true;
      final (bool, String) dataState =
          await addRemoveCourseWishlistItemUsecase.call(RequestParams(
              body: {"courseId": courseId},
              url: "${APIConstants.api}/api/lms/user/add-to-wishlist"));
      log(dataState.toString());
      isLoading.value = false;

      return (dataState.$1, dataState.$2);
    } on Exception catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }
}
