import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/my_course_details/domain/usecases/add_course_review_usecase.dart';

class AddCourseReviewController extends GetxController {
  final AddCourseReviewUsecase addCourseReviewUsecase;

  AddCourseReviewController({required this.addCourseReviewUsecase});

  var msg = ''.obs;
  var isSubmittingReview = false.obs;
  var error = ''.obs;
  var selectedRating = 0.obs;

  Future<void> submitReview(
      {required String courseId, String? review, required int rating}) async {
    try {
      isSubmittingReview.value = true;
      final DataState<Map<String, dynamic>> dataState =
          await addCourseReviewUsecase.call(RequestParams(
              url: "${APIConstants.api}/api/product/submit-review",
              apiMethods: ApiMethods.post,
              body: {
            "productId": courseId,
            "review": review,
            "rating": rating
          }));
      if (dataState.data != null) {
        msg.value = dataState.data!['message'];
      } else {
        error.value = dataState.exception.toString();
      }
    } on Exception catch (e) {
      error.value = e.toString();
    }
  }
}
