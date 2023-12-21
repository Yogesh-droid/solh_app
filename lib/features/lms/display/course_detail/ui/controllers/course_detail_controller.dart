import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_detail/domain/entities/course_details_entity.dart';
import 'package:solh/features/lms/display/course_detail/domain/usecases/course_detail_usecase.dart';

class CourseDetailController extends GetxController {
  final CourseDetailUsecase courseDetailUsecase;

  var isLoading = false.obs;
  var courseDetailEntity = CourseDetailsEntity().obs;
  var err = ''.obs;

  CourseDetailController({required this.courseDetailUsecase});

  Future<void> getCourseDetail(String courseId) async {
    try {
      isLoading.value = true;
      final DataState<CourseDetailsEntity> dataState =
          await courseDetailUsecase.call(RequestParams(
              url:
                  "${APIConstants.api}/api/lms/user/course-details/$courseId"));
      if (dataState.data != null) {
        courseDetailEntity.value = dataState.data!;
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
