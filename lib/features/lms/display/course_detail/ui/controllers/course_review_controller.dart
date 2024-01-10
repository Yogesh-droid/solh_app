import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_detail/data/models/course_review_model.dart';
import 'package:solh/features/lms/display/course_detail/domain/entities/course_review_entity.dart';
import 'package:solh/features/lms/display/course_detail/domain/usecases/course_review_usecase.dart';

class CourseReviewController extends GetxController {
  final CourseReviewUsecase courseReviewUsecase;

  CourseReviewController({required this.courseReviewUsecase});

  var isLoading = false.obs;
  var reviewList = <Reviews>[].obs;
  var err = ''.obs;

  var isLast = false.obs;
  var isLoadingMore = false.obs;

  Future<void> getReviews(
      {required String courseId, required int pageNo}) async {
    try {
      if (pageNo == 1) {
        isLoading.value = true;
      } else {
        isLoadingMore.value = true;
      }
      final DataState<CourseReviewEntity> dataState =
          await courseReviewUsecase.call(RequestParams(
              url:
                  "${APIConstants.api}/api/lms/user/get-rating?courseId=$courseId&page=$pageNo"));
      if (dataState.data != null) {
        isLoading.value = false;
        isLoadingMore.value = false;
        isLast.value = dataState.data!.pages!.next == null;
        if (pageNo > 1) {
          reviewList.addAll(dataState.data!.reviews ?? []);
          reviewList.refresh();
        } else {
          reviewList.value = dataState.data!.reviews ?? [];
        }
      } else {
        err.value = dataState.exception.toString();
        isLoading.value = false;
        isLoadingMore.value = false;
      }
    } on Exception catch (e) {
      isLoading.value = false;
      isLoadingMore.value = false;
      err.value = e.toString();
    }
  }
}
