import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_home/data/model/course_cat_model.dart';
import 'package:solh/features/lms/display/course_home/domain/entities/course_cat_entity.dart';
import 'package:solh/features/lms/display/course_home/domain/usecases/course_cat_usecase.dart';

class CourseCatController extends GetxController {
  final CourseCatUsecase courseCatUsecase;

  var categoryList = <CategoryList>[].obs;
  var isLoading = false.obs;
  var err = ''.obs;

  CourseCatController({required this.courseCatUsecase});

  Future<void> getCourseCategory() async {
    try {
      isLoading.value = true;
      final DataState<CourseCatEntity> dataState = await courseCatUsecase.call(
          RequestParams(url: "${APIConstants.api}/api/lms/user/get-category"));
      if (dataState.data != null) {
        categoryList.value = dataState.data!.categoryList ?? [];
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
