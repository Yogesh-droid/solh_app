/* class UserModel {
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
} */

class UserModel {
  String? sId;
  String? gender;
  String? status;
  String? profilePicture;
  String? profilePictureType;
  String? userType;
  bool? isSolhExpert;
  bool? isSolhAdviser;
  bool? isSolhCounselor;
  String? mobile;
  String? uid;
  String? firstName;
  String? userName;
  String? dob;
  String? email;
  String? name;
  int? experience;
  int? connections;
  int? ratings;
  int? reviews;
  int? likes;
  int? posts;
  String? bio;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? lastName;

  UserModel(
      {this.sId,
      this.gender,
      this.status,
      this.profilePicture,
      this.profilePictureType,
      this.userType,
      this.isSolhExpert,
      this.isSolhAdviser,
      this.isSolhCounselor,
      this.mobile,
      this.uid,
      this.firstName,
      this.userName,
      this.dob,
      this.email,
      this.name,
      this.experience,
      this.connections,
      this.ratings,
      this.reviews,
      this.likes,
      this.posts,
      this.bio,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.lastName});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gender = json['gender'];
    status = json['status'];
    profilePicture = json['profilePicture'];
    profilePictureType = json['profilePictureType'];
    userType = json['userType'];
    isSolhExpert = json['isSolhExpert'];
    isSolhAdviser = json['isSolhAdviser'];
    isSolhCounselor = json['isSolhCounselor'];
    mobile = json['mobile'];
    uid = json['uid'];
    firstName = json['first_name'];
    userName = json['userName'];
    dob = json['dob'];
    email = json['email'];
    name = json['name'];
    experience = json['experience'];
    connections = json['connections'];
    ratings = json['ratings'];
    reviews = json['reviews'];
    likes = json['likes'];
    posts = json['posts'];
    bio = json['bio'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['gender'] = this.gender;
    data['status'] = this.status;
    data['profilePicture'] = this.profilePicture;
    data['profilePictureType'] = this.profilePictureType;
    data['userType'] = this.userType;
    data['isSolhExpert'] = this.isSolhExpert;
    data['isSolhAdviser'] = this.isSolhAdviser;
    data['isSolhCounselor'] = this.isSolhCounselor;
    data['mobile'] = this.mobile;
    data['uid'] = this.uid;
    data['first_name'] = this.firstName;
    data['userName'] = this.userName;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['name'] = this.name;
    data['experience'] = this.experience;
    data['connections'] = this.connections;
    data['ratings'] = this.ratings;
    data['reviews'] = this.reviews;
    data['likes'] = this.likes;
    data['posts'] = this.posts;
    data['bio'] = this.bio;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['last_name'] = this.lastName;
    return data;
  }
}
