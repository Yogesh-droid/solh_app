import 'package:solh/model/user/journal-user.dart';

class JournalModel {
  String description;
  // String journalType;
  String? imageUrl;
  int likes;
  int comments;
  String feelings;
  JournalUserModel postedBy;

  JournalModel(
      {required this.feelings,
      required this.likes,
      required this.comments,
      // required this.journalType,
      required this.description,
      required this.imageUrl,
      required this.postedBy});

  factory JournalModel.fromJson(Map<String, dynamic> postJson) {
    return JournalModel(
      feelings: postJson["feelings"],
      likes: postJson["likes"],
      comments: postJson["comments"],
      imageUrl: postJson["image"],
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
