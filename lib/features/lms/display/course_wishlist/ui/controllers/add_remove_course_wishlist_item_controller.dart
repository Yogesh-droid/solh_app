import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/features/lms/display/course_wishlist/domain/usecases/add_remove_course_wishlist_item_usecase.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';

class AddRemoveCourseWishlistItemController extends GetxController {
  AddRemoveCourseWishlistItemUsecase addRemoveCourseWishlistItemUsecase;

  AddRemoveCourseWishlistItemController(
      {required this.addRemoveCourseWishlistItemUsecase});

  var message = ''.obs;
  var isLoading = false.obs;
  var currentCourseRemoval = '';
  var isAdded = false.obs;

  Future<void> addRemoveCourseWishlistItem(String courseId) async {
    isAdded.value = false;
    try {
      isLoading.value = true;
      final DataState<Map<String, dynamic>> dataState =
          await addRemoveCourseWishlistItemUsecase.call(RequestParams(
              body: {"courseId": courseId},
              url: "${APIConstants.api}/api/lms/user/add-to-wishlist"));
      if (dataState.data != null) {
        isLoading.value = false;
        isAdded.value = dataState.data!['code'] == 201;
        Utility.showToast(dataState.data!['message']);
      }
    } on Exception catch (e) {
      isAdded.value = false;
      Utility.showToast(e.toString());
      isLoading.value = false;
      rethrow;
    }
  }
}
