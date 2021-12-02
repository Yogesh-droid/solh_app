import 'package:solh/model/user/journal-user.dart';

class JournalModel {
  String description;
  // String journalType;
  String id;
  String? mediaUrl;
  String mediaType;
  int likes;
  int comments;
  String feelings;
  JournalUserModel postedBy;

  JournalModel(
      {required this.id,
      required this.mediaType,
      required this.feelings,
      required this.likes,
      required this.comments,
      // required this.journalType,
      required this.description,
      required this.mediaUrl,
      required this.postedBy});

  factory JournalModel.fromJson(Map<String, dynamic> postJson) {
    return JournalModel(
      id: postJson["id"],
      mediaType: postJson["mediaType"],
      feelings: postJson["feelings"],
      likes: postJson["likes"],
      comments: postJson["comments"],
      mediaUrl: postJson["mediaUrl"],
      postedBy: JournalUserModel.fromJson(postJson["postedBy"]),
      description: postJson["description"],
      // journalType: postJson["journalType"]
    );
  }
}

enum JournalType { Publicaly, My_Diary }

extension ParseToString on JournalType {
  String toShortString() {
    return this.toString().substring(this.toString().indexOf('.') + 1);
  }
}
