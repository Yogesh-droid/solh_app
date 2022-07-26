class PeopleYouMayKnowModel {
  bool? success;
  int? count;
  List<Reccomendation>? reccomendation;

  PeopleYouMayKnowModel({this.success, this.count, this.reccomendation});

  PeopleYouMayKnowModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    count = json['count'];
    if (json['reccomendation'] != null) {
      reccomendation = <Reccomendation>[];
      json['reccomendation'].forEach((v) {
        reccomendation!.add(new Reccomendation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['count'] = this.count;
    if (this.reccomendation != null) {
      data['reccomendation'] =
          this.reccomendation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reccomendation {
  String? sId;
  String? gender;
  String? status;
  List<String>? connectionsList;
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
  bool? isProvider;
  List<Null>? reports;
  String? id;
  String? anonymous;

  Reccomendation(
      {this.sId,
      this.gender,
      this.status,
      this.connectionsList,
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
      this.lastName,
      this.isProvider,
      this.reports,
      this.id,
      this.anonymous});

  Reccomendation.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gender = json['gender'];
    status = json['status'];
    connectionsList = json['connectionsList'].cast<String>();
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
    isProvider = json['isProvider'];
    // if (json['reports'] != null) {
    //   reports = <Null>[];
    //   json['reports'].forEach((v) {
    //     reports!.add(new Null.fromJson(v));
    //   });
    // }
    id = json['id'];
    anonymous = json['anonymous'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['gender'] = this.gender;
    data['status'] = this.status;
    data['connectionsList'] = this.connectionsList;
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
    data['isProvider'] = this.isProvider;
    // if (this.reports != null) {
    //   data['reports'] = this.reports!.map((v) => v.toJson()).toList();
    // }
    data['id'] = this.id;
    data['anonymous'] = this.anonymous;
    return data;
  }
}
