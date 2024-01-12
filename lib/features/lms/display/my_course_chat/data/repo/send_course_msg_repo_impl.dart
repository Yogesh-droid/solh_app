import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/my_course_chat/domain/repo/send_course_msg_repo.dart';
import 'package:solh/services/network/network.dart';

class SendCourseMsgRepoImpl implements SendCourseMsgRepo {
  @override
  Future<DataState<Map<String, dynamic>>> sendMessage(
      RequestParams params) async {
    try {
      final Map<String, dynamic> res = await Network.makePostRequestWithToken(
          url: params.url, body: params.body!);
      if (res['success']) {
        return DataSuccess(data: res);
      } else {
        return DataError(
            exception: Exception(res['message'] ?? 'Something went wrong'));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
