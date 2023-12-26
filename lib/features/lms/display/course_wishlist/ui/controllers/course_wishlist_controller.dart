import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/features/lms/display/course_wishlist/domain/entities/course_wishlist_entity.dart';
import 'package:solh/features/lms/display/course_wishlist/domain/usecases/course_wishlist_usecase.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';

class CourseWishlistController extends GetxController {
  final CourseWishlistUseCase courseWishlistUseCase;
  CourseWishlistController({required this.courseWishlistUseCase});
  var courseWishlist = CourseWishlistEntity().obs;
  var isEnd = false.obs;
  var isLoading = false.obs;
  var err = ''.obs;

  Future<void> getCourseWishList() async {
    try {
      isLoading.value = true;
      final DataState<CourseWishlistEntity> dataState =
          await courseWishlistUseCase.call(RequestParams(
              url: "${APIConstants.api}/api/lms/user/get-wishlist"));
      if (dataState.data != null) {
        courseWishlist.value = dataState.data!;
        isLoading.value = false;
      } else {
        err.value = dataState.exception.toString();
        isLoading.value = false;
      }
    } on Exception catch (e) {
      err.value = e.toString();
      isLoading.value = false;
    }
  }
}
