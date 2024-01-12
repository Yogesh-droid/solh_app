import '../../../course_detail/data/models/course_review_model.dart';
import '../../data/models/course_chat_model.dart';

class CourseChatEntity {
  final bool? success;
  final List<Conversation>? conversation;
  final Pages? pages;

  CourseChatEntity({
    this.success,
    this.conversation,
    this.pages,
  });
}
