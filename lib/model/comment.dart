class CommentModel {
  String id;
  String commentBody;
  String commentBy;
  String createdAt;
  User user;

  CommentModel(
      {required this.commentBody,
      required this.commentBy,
      required this.createdAt,
      required this.id,
      required this.user});

  factory CommentModel.fromJson(Map<String, dynamic> commentJson) {
    return CommentModel(
        commentBody: commentJson["commentBody"],
        id: commentJson["_id"],
        commentBy: commentJson["commentBy"],
        createdAt: commentJson["createdAt"],
        user: User.fromJson(commentJson["user"]));
  }
}

class User {
  String name;
  String uid;
  String userType;
  String profilePicture;

  User({
    required this.userType,
    required this.name,
    required this.uid,
    required this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> userJson) {
    return User(
      userType: userJson["userType"],
      name: userJson["name"],
      uid: userJson["uid"],
      profilePicture: userJson["profilePicture"],
    );
  }
}
