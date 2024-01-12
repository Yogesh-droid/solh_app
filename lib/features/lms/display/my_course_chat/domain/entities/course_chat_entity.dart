import '../../data/models/course_chat_model.dart';

class CourseChatEntity {
  final bool? success;
  final List<Conversation>? conversation;

  CourseChatEntity({this.success, this.conversation});
}
