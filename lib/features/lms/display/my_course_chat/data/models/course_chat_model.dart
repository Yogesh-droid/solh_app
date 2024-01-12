import 'package:solh/features/lms/display/my_course_chat/domain/entities/course_chat_entity.dart';

import '../../../course_detail/data/models/course_review_model.dart';

class CourseChatModel extends CourseChatEntity {
  CourseChatModel({super.success, super.conversation, super.pages});

  factory CourseChatModel.fromJson(Map<String, dynamic> json) {
    return CourseChatModel(
        success: json["success"],
        pages: json["pages"] == null ? null : Pages.fromJson(json["pages"]),
        conversation: json["conversation"] == null
            ? null
            : (json["conversation"] as List)
                .map((e) => Conversation.fromJson(e))
                .toList());
  }
}

class Conversation {
  String? author;
  String? authorType;
  String? authorId;
  String? body;
  String? dateTime;
  String? id;
  String? status;

  Conversation(
      {this.author,
      this.authorType,
      this.authorId,
      this.body,
      this.dateTime,
      this.id,
      this.status});

  Conversation.fromJson(Map<String, dynamic> json) {
    author = json["author"];
    authorType = json["authorType"];
    authorId = json["authorId"];
    body = json["body"];
    dateTime = json["dateTime"];
    id = json["_id"];
    status = json["status"];
  }
}
