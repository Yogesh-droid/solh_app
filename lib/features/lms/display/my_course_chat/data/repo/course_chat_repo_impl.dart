import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/my_course_chat/data/models/course_chat_model.dart';
import 'package:solh/features/lms/display/my_course_chat/domain/entities/course_chat_entity.dart';
import 'package:solh/features/lms/display/my_course_chat/domain/repo/course_chat_repo.dart';
import 'package:solh/services/network/network.dart';

class CourseChatRepoImpl implements CourseChatRepo {
  @override
  Future<DataState<CourseChatEntity>> getCourseChat(
      RequestParams params) async {
    try {
      final Map<String, dynamic> res =
          await Network.makeGetRequestWithToken(params.url);
      if (res['success']) {
        final value = CourseChatModel.fromJson(res);
        return DataSuccess(data: value);
      } else {
        return DataError(
            exception: Exception(res['message'] ?? 'Something went wrong'));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
