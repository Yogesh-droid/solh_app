import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/my_course_details/domain/usecases/update_lecture_track_usecase.dart';

class UpdateLectureTrackController extends GetxController {
  final UpdateLectureTrackUsecase updateLectureTrackUsecase;
  var isUpdating = false.obs;
  var message = ''.obs;
  var success = false.obs;

  UpdateLectureTrackController({required this.updateLectureTrackUsecase});

  Future<void> updateLectureTrack(
      {required String courseId,
      required String lectureId,
      required String sectionId}) async {
    try {
      isUpdating.value = true;
      final DataState<Map<String, dynamic>> dataState =
          await updateLectureTrackUsecase.call(RequestParams(
              url: "${APIConstants.api}/api/lms/user/update-course-progress",
              body: {
            "courseId": courseId,
            "sectionId": sectionId,
            "lectureId": lectureId
          }));
      if (dataState.data != null) {
        isUpdating.value = false;
        success.value = true;
        message.value = dataState.data!['message'];
      } else {
        success.value = false;
        isUpdating.value = false;
        message.value = dataState.exception.toString();
      }
    } on Exception catch (e) {
      success.value = false;
      isUpdating.value = false;
      message.value = e.toString();
    }
  }
}
