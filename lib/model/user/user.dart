// class UserModel {
//   String? sId;
//   String? gender;
//   String? status;
//   List<String>? connectionsList;
//   String? profilePicture;
//   String? profilePictureType;
//   String? userType;
//   bool? isSolhExpert;
//   bool? isSolhAdviser;
//   bool? isSolhCounselor;
//   String? mobile;
//   String? uid;
//   String? firstName;
//   String? userName;
//   String? dob;
//   String? email;
//   String? name;
//   int? experience;
//   int? connections;
//   int? ratings;
//   int? reviews;
//   int? likes;
//   int? posts;
//   String? bio;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//   String? lastName;
//   String? anonymous;
//   bool? isProvider;
//   List<Null>? reports;
//   String? id;

//   UserModel(
//       {this.sId,
//       this.gender,
//       this.status,
//       this.connectionsList,
//       this.profilePicture,
//       this.profilePictureType,
//       this.userType,
//       this.isSolhExpert,
//       this.isSolhAdviser,
//       this.isSolhCounselor,
//       this.mobile,
//       this.uid,
//       this.firstName,
//       this.userName,
//       this.dob,
//       this.email,
//       this.name,
//       this.experience,
//       this.connections,
//       this.ratings,
//       this.reviews,
//       this.likes,
//       this.posts,
//       this.bio,
//       this.createdAt,
//       this.updatedAt,
//       this.iV,
//       this.lastName,
//       this.anonymous,
//       this.isProvider,
//       this.reports,
//       this.id});

//   UserModel.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     gender = json['gender'];
//     status = json['status'];
//     connectionsList = json['connectionsList'].cast<String>();
//     profilePicture = json['profilePicture'];
//     profilePictureType = json['profilePictureType'];
//     userType = json['userType'];
//     isSolhExpert = json['isSolhExpert'];
//     isSolhAdviser = json['isSolhAdviser'];
//     isSolhCounselor = json['isSolhCounselor'];
//     mobile = json['mobile'];
//     uid = json['uid'];
//     firstName = json['first_name'];
//     userName = json['userName'];
//     dob = json['dob'];
//     email = json['email'];
//     name = json['name'];
//     experience = json['experience'];
//     connections = json['connections'];
//     ratings = json['ratings'];
//     reviews = json['reviews'];
//     likes = json['likes'];
//     posts = json['posts'];
//     bio = json['bio'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     lastName = json['last_name'];
//     anonymous = json['anonymous'];
//     isProvider = json['isProvider'];
//     // if (json['reports'] != null) {
//     //   reports = <Null>[];
//     //   json['reports'].forEach((v) {
//     //     reports!.add(new Null.fromJson(v));
//     //   });
//     // }
//     id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['gender'] = this.gender;
//     data['status'] = this.status;
//     data['connectionsList'] = this.connectionsList;
//     data['profilePicture'] = this.profilePicture;
//     data['profilePictureType'] = this.profilePictureType;
//     data['userType'] = this.userType;
//     data['isSolhExpert'] = this.isSolhExpert;
//     data['isSolhAdviser'] = this.isSolhAdviser;
//     data['isSolhCounselor'] = this.isSolhCounselor;
//     data['mobile'] = this.mobile;
//     data['uid'] = this.uid;
//     data['first_name'] = this.firstName;
//     data['userName'] = this.userName;
//     data['dob'] = this.dob;
//     data['email'] = this.email;
//     data['name'] = this.name;
//     data['experience'] = this.experience;
//     data['connections'] = this.connections;
//     data['ratings'] = this.ratings;
//     data['reviews'] = this.reviews;
//     data['likes'] = this.likes;
//     data['posts'] = this.posts;
//     data['bio'] = this.bio;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     data['last_name'] = this.lastName;
//     data['anonymous'] = this.anonymous;
//     data['isProvider'] = this.isProvider;
//     // if (this.reports != null) {
//     //   data['reports'] = this.reports!.map((v) => v.toJson()).toList();
//     // }
//     data['id'] = this.id;
//     return data;
//   }
// }

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
  dynamic dob;
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
  dynamic anonymous;
  bool? isProvider;
  String? updatedAt;
  int? iV;
  String? lastName;
  int? journalLikeCount;
  int? commentCount;
  String? connectionCount;
  List<String>? hiddenposts;

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
      this.lastName,
      this.journalLikeCount,
      this.commentCount,
      this.connectionCount,
      this.hiddenposts});

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
        ? json['anonymous'] is Map
            ? new Anonymous.fromJson(json['anonymous'])
            : json['anonymous']
        : null;
    isProvider = json['isProvider'];
    iV = json['__v'];
    lastName = json['last_name'];
    journalLikeCount = json['journalLikeCount'];
    commentCount = json['commentCount'];
    connectionCount = json['connectionCount'];
    hiddenposts = json['hiddenposts'] != null
        ? new List<String>.from(json['hiddenposts'])
        : null;
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
