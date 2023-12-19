import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_home/data/model/featured_course_model.dart';
import 'package:solh/features/lms/display/course_home/domain/entities/featured_course_entity.dart';
import 'package:solh/features/lms/display/course_home/domain/usecases/featured_course_usecase.dart';

class FeaturedCourseController extends GetxController {
  final FeaturedCourseUsecase featuredCourseUsecase;
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var featuredCourseList = <CourseList>[].obs;
  var err = ''.obs;
  var isEnd = false.obs;

  FeaturedCourseController({required this.featuredCourseUsecase});

  Future<void> getFeaturedCourse(int page) async {
    try {
      if (page == 1) {
        isLoading.value = true;
      } else {
        isLoadingMore.value = true;
      }
      final DataState<FeaturedCourseEntity> dataState =
          await featuredCourseUsecase.call(RequestParams(
              url:
                  "${APIConstants.api}/api/lms/user/trending-course-list?page=$page&limit=10"));
      if (dataState.data != null) {
        featuredCourseList.value = dataState.data!.courseList ?? [];
        isEnd.value = dataState.data!.pagination!.next == null;
        isLoading.value = false;
        isLoadingMore.value = false;
      } else {
        err.value = dataState.exception.toString();
        isLoading.value = false;
        isLoadingMore.value = false;
      }
    } on Exception catch (e) {
      err.value = e.toString();
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }
}
