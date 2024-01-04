import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/my_course_details/data/models/my_course_detail_model.dart';
import 'package:solh/features/lms/display/my_course_details/domain/entities/my_course_detail_entity.dart';
import 'package:solh/features/lms/display/my_course_details/domain/usecases/my_course_detail_usecase.dart';

class MyCourseDetailController extends GetxController {
  final MyCourseDetailUsecase myCourseDetailUsecase;
  var isLoading = false.obs;
  var err = ''.obs;
  var sectionList = <SectionList>[].obs;

  MyCourseDetailController({required this.myCourseDetailUsecase});

  Future<void> getMyCourseDetail(String id) async {
    try {
      isLoading.value = true;
      final DataState<MyCourseDetailEntity> dataState =
          await myCourseDetailUsecase.call(RequestParams(
              url: "${APIConstants.api}/api/lms/user/course-section-list/$id"));
      if (dataState.data != null) {
        sectionList.value = dataState.data!.sectionList ?? [];
        isLoading.value = false;
      } else {
        isLoading.value = false;
        err.value = dataState.exception.toString();
      }
    } on Exception catch (e) {
      err.value = e.toString();
      isLoading.value = false;
    }
  }
}
