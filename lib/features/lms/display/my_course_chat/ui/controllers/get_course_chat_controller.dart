import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/my_course_chat/domain/entities/course_chat_entity.dart';
import 'package:solh/features/lms/display/my_course_chat/domain/usecases/course_chat_usecase.dart';

import '../../data/models/course_chat_model.dart';

class GetCourseChatController extends GetxController {
  final CourseChatUsecase chatUsecase;

  GetCourseChatController({required this.chatUsecase});

  var isLoading = false.obs;
  var err = ''.obs;
  var conversationList = <Conversation>[].obs;

  Future<void> getCourseChat(String courseId) async {
    try {
      isLoading.value = true;
      final DataState<CourseChatEntity> dataState = await chatUsecase.call(
          RequestParams(
              url:
                  "${APIConstants.api}/api/lms/user/get-chat?courseId=$courseId"));

      if (dataState.data != null) {
        isLoading.value = false;
        conversationList.value = dataState.data!.conversation ?? [];
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
