class JournalUserModel {
  // String compressedProfileImageUrl;
  bool isSolhExpert;
  bool isSolhAdviser;
  bool isSolhCounselor;
  String name;

  // String username;
  // String uid;

  JournalUserModel({
    // required this.compressedProfileImageUrl,
    // required this.username,
    required this.name,
    required this.isSolhExpert,
    required this.isSolhAdviser,
    required this.isSolhCounselor,
    // required this.uid,
  });

  factory JournalUserModel.fromJson(Map<String, dynamic> journalUser) {
    return JournalUserModel(
      name: journalUser["name"],
      isSolhAdviser: journalUser["isSolhAdviser"],
      isSolhCounselor: journalUser["isSolhCounselor"],
      isSolhExpert: journalUser["isSolhExpert"],
      // username: journalUser["username"],
      // uid: journalUser["uid"],
      // compressedProfileImageUrl: journalUser["compressedProfileImage"],
    );
  }
}
