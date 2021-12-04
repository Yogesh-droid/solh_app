class JournalUserModel {
  // String compressedProfileImageUrl;
  bool isSolhExpert;
  bool isSolhAdviser;
  bool isSolhCounselor;
  String name;
  String profilePictureUrl;
  // String profilePictureUrl;
  // String username;
  // String uid;

  JournalUserModel({
    // required this.compressedProfileImageUrl,
    // required this.username,
    required this.name,
    required this.isSolhExpert,
    required this.isSolhAdviser,
    required this.isSolhCounselor,
    required this.profilePictureUrl,
    // required this.uid,
  });

  factory JournalUserModel.fromJson(Map<String, dynamic> journalUser) {
    return JournalUserModel(
      profilePictureUrl: journalUser["profilePicture"],
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
