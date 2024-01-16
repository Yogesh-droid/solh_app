import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/my_course_details/data/models/course_faq_model.dart';
import 'package:solh/features/lms/display/my_course_details/domain/entities/course_faq_entity.dart';
import 'package:solh/features/lms/display/my_course_details/domain/usecases/course_faq_usercase.dart';

class CourseFaqController extends GetxController {
  final CourseFaqUsecase courseFaqUsecase;
  var isLoading = false.obs;
  var err = ''.obs;
  var faqs = <Faqs>[].obs;
  

  CourseFaqController({required this.courseFaqUsecase});

  Future<void> getCourseFaq(String id) async {
    try {
      isLoading.value = true;
      final DataState<CourseFaqEntity> dataState =
          await courseFaqUsecase.call(RequestParams(
              url: "${APIConstants.api}/api/lms/user/course-faqs/$id"));
      if (dataState.data != null) {
        faqs.value = dataState.data!.faqs ?? [];
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