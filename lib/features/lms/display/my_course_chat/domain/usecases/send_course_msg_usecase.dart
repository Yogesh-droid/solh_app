import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/features/lms/display/my_course_chat/domain/repo/send_course_msg_repo.dart';

class SendCourseMsgUsecase extends Usecase {
  final SendCourseMsgRepo sendCourseMsgRepo;

  SendCourseMsgUsecase({required this.sendCourseMsgRepo});
  @override
  Future<DataState<Map<String, dynamic>>> call(params) async {
    return await sendCourseMsgRepo.sendMessage(params);
  }
}
