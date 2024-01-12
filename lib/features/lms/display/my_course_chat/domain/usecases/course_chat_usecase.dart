import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/features/lms/display/my_course_chat/domain/entities/course_chat_entity.dart';
import 'package:solh/features/lms/display/my_course_chat/domain/repo/course_chat_repo.dart';

class CourseChatUsecase extends Usecase {
  final CourseChatRepo courseChatRepo;

  CourseChatUsecase({required this.courseChatRepo});
  @override
  Future<DataState<CourseChatEntity>> call(params) async {
    return await courseChatRepo.getCourseChat(params);
  }
}
