import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_listing/data/models/course_list_model.dart';
import 'package:solh/features/lms/display/course_listing/domain/entities/course_list_entity.dart';
import 'package:solh/features/lms/display/course_listing/domain/usecases/course_list_usecase.dart';

import '../../../../../../core/data_state/data_state.dart';

class CourseListController extends GetxController {
  final CourseListUsecase courseListUsecase;
  var courseList = <CourseList>[].obs;
  var isEnd = false.obs;
  var isLoading = false.obs;
  var err = ''.obs;

  CourseListController({required this.courseListUsecase});

  Future<void> getCourseList(String catId, int page) async {
    try {
      isLoading.value = true;
      final DataState<CourseListEntity> dataState =
          await courseListUsecase.call(RequestParams(
              url:
                  "${APIConstants.api}/api/lms/user/course-list?page=$page&limit=10&category=$catId"));
      if (dataState.data != null) {
        courseList.value = dataState.data!.courseList ?? [];
        isEnd.value = dataState.data!.pagination!.next == null;
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
