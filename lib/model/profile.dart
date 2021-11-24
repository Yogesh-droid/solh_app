class ProfileModel {
  bool isSolhExpert;
  bool isSolhAdviser;
  bool isSolhCounselor;
  String id;
  String mobile;
  String uid;
  String gender;
  String name;

  ProfileModel(
      {required this.isSolhAdviser,
      required this.isSolhCounselor,
      required this.isSolhExpert,
      required this.id,
      required this.mobile,
      required this.uid,
      required this.gender,
      required this.name});

  factory ProfileModel.fromJson(Map<String, dynamic> userJson) {
    return ProfileModel(
        isSolhExpert: userJson['isSolhExpert'],
        isSolhAdviser: userJson['isSolhAdviser'],
        isSolhCounselor: userJson['isSolhCounselor'],
        id: userJson['id'],
        mobile: userJson['mobile'],
        uid: userJson['uid'],
        gender: userJson['gender'],
        name: userJson['name']);
  }
}
