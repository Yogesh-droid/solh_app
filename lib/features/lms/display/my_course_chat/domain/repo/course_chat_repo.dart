import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/my_course_chat/domain/entities/course_chat_entity.dart';

abstract class CourseChatRepo {
  Future<DataState<CourseChatEntity>> getCourseChat(RequestParams params);
}
