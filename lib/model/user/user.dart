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
  Anonymous? anonymous;
  bool? isProvider;
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
      this.anonymous,
      this.isProvider,
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
    anonymous = json['anonymous'] != null
        ? new Anonymous.fromJson(json['anonymous'])
        : null;
    isProvider = json['isProvider'];
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
    if (this.anonymous != null) {
      data['anonymous'] = this.anonymous!.toJson();
    }
    data['isProvider'] = this.isProvider;
    data['last_name'] = this.lastName;
    return data;
  }
}

class Anonymous {
  String? sId;
  List<String>? connectionsList;
  String? profilePicture;
  String? profilePictureType;
  String? userName;
  String? primaryAccount;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? gender;

  Anonymous(
      {this.sId,
      this.connectionsList,
      this.profilePicture,
      this.profilePictureType,
      this.userName,
      this.primaryAccount,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.gender});

  Anonymous.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['connectionsList'] != null) {
      connectionsList = <String>[];
      json['connectionsList'].forEach((v) {
        connectionsList!.add(v);
      });
    }
    profilePicture = json['profilePicture'];
    profilePictureType = json['profilePictureType'];
    userName = json['userName'];
    primaryAccount = json['primaryAccount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.connectionsList != null) {
      data['connectionsList'] = this.connectionsList!.map((v) => v).toList();
    }
    data['profilePicture'] = this.profilePicture;
    data['profilePictureType'] = this.profilePictureType;
    data['userName'] = this.userName;
    data['primaryAccount'] = this.primaryAccount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['gender'] = this.gender;
    return data;
  }
}
