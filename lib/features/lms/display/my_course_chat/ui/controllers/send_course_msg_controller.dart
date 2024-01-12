import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/my_course_chat/domain/usecases/send_course_msg_usecase.dart';

class SendCourseMsgController extends GetxController {
  final SendCourseMsgUsecase sendCourseMsgUsecase;

  var isSending = false.obs;
  var mgs = ''.obs;
  var success = false.obs;

  SendCourseMsgController({required this.sendCourseMsgUsecase});

  Future<void> sendMessage(
      {required String courseId, required String message}) async {
    try {
      isSending.value = true;
      final DataState<Map<String, dynamic>> dataState =
          await sendCourseMsgUsecase.call(RequestParams(
              url: "${APIConstants.api}/api/lms/user/send-message",
              body: {"courseId": courseId, "message": message}));
      if (dataState.data != null) {
        mgs.value = dataState.data!['message'];
        isSending.value = false;
        success.value = true;
      } else {
        success.value = false;
        mgs.value = dataState.exception.toString();
        isSending.value = false;
      }
    } on Exception catch (e) {
      isSending.value = false;
      mgs.value = e.toString();
      success.value = false;
    }
  }
}
