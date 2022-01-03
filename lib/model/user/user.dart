class UserModel {
  bool isSolhExpert;
  bool isSolhAdviser;
  bool isSolhCounselor;
  String profilePictureUrl;
  String dob;
  String mobile;
  String uid;
  String gender;
  String name;
  String bio;
  String firstName;
  String lastName;
  int connections;
  int reviews;
  String userType;

  UserModel(
      {required this.userType,
      required this.dob,
      required this.firstName,
      required this.lastName,
      required this.profilePictureUrl,
      required this.isSolhAdviser,
      required this.isSolhCounselor,
      required this.isSolhExpert,
      required this.mobile,
      required this.uid,
      required this.gender,
      required this.bio,
      required this.connections,
      required this.reviews,
      required this.name});

  factory UserModel.fromJson(Map<String, dynamic> userJson) {
    return UserModel(
        userType: userJson["userType"],
        dob: userJson["dob"],
        firstName: userJson["first_name"],
        lastName: userJson["last_name"],
        profilePictureUrl: userJson["profilePicture"],
        connections: userJson["connections"],
        reviews: userJson["reviews"],
        isSolhExpert: userJson['isSolhExpert'],
        isSolhAdviser: userJson['isSolhAdviser'],
        isSolhCounselor: userJson['isSolhCounselor'],
        bio: userJson['bio'],
        mobile: userJson['mobile'],
        uid: userJson['uid'],
        gender: userJson['gender'],
        name: userJson['name']);
  }
}
