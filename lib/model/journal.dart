import 'package:solh/model/user/journal-user.dart';

class JournalModel {
  String description;
  // String journalType;
  String createdAt;
  String id;
  String? mediaUrl;
  String? mediaType;
  int likes;
  int comments;
  bool isLiked;
  String feelings;
  JournalUserModel postedBy;

  JournalModel(
      {required this.createdAt,
      required this.id,
      required this.mediaType,
      required this.feelings,
      required this.isLiked,
      required this.likes,
      required this.comments,
      // required this.journalType,
      required this.description,
      required this.mediaUrl,
      required this.postedBy});

  factory JournalModel.fromJson(Map<String, dynamic> postJson) {
    // print("best comment:" + postJson["bestComment"].toString());
    return JournalModel(
      createdAt: postJson["createdAt"],
      id: postJson["id"],
      isLiked: postJson["isLiked"],
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

enum JournalType {
  Publicaly,
  My_Diary,
}

extension ParseToString on JournalType {
  String toShortString() {
    return this.toString().substring(this.toString().indexOf('.') + 1);
  }
}
