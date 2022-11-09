class ConnectScreenModel {
  bool? success;
  User? user;
  int? journalLikeCount;
  int? commentCount;

  ConnectScreenModel(
      {this.success, this.user, this.journalLikeCount, this.commentCount});

  ConnectScreenModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    journalLikeCount = json['journalLikeCount'];
    commentCount = json['commentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['journalLikeCount'] = this.journalLikeCount;
    data['commentCount'] = this.commentCount;
    return data;
  }
}

class User {
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
  String? anonymous;
  bool? featured;
  String? deviceId;
  List<Null>? hiddenPosts;
  String? onesignalDeviceId;
  String? deviceType;
  String? userCountry;
  String? chatSocketId;
  String? chatStatus;
  String? specialization;
  String? utmCompaign;
  String? utmMedium;
  String? utmSource;
  String? id;

  User(
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
      this.anonymous,
      this.featured,
      this.deviceId,
      this.hiddenPosts,
      this.onesignalDeviceId,
      this.deviceType,
      this.userCountry,
      this.chatSocketId,
      this.chatStatus,
      this.specialization,
      this.utmCompaign,
      this.utmMedium,
      this.utmSource,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
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
    anonymous = json['anonymous'];
    featured = json['featured'];
    deviceId = json['deviceId'];
    // if (json['hiddenPosts'] != null) {
    //   hiddenPosts = <Null>[];
    //   json['hiddenPosts'].forEach((v) {
    //     hiddenPosts!.add(new Null.fromJson(v));
    //   });
    // }
    onesignalDeviceId = json['onesignal_device_id'];
    deviceType = json['deviceType'];
    userCountry = json['user_country'];
    chatSocketId = json['chatSocketId'];
    chatStatus = json['chatStatus'];
    specialization = json['specialization'];
    utmCompaign = json['utm_compaign'];
    utmMedium = json['utm_medium'];
    utmSource = json['utm_source'];
    id = json['id'];
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
    //   data['reports'] = this.reports!.map((v) => v!.toJson()).toList();
    // }
    data['anonymous'] = this.anonymous;
    data['featured'] = this.featured;
    data['deviceId'] = this.deviceId;
    // if (this.hiddenPosts != null) {
    //   data['hiddenPosts'] = this.hiddenPosts!.map((v) => v.toJson()).toList();
    // }
    data['onesignal_device_id'] = this.onesignalDeviceId;
    data['deviceType'] = this.deviceType;
    data['user_country'] = this.userCountry;
    data['chatSocketId'] = this.chatSocketId;
    data['chatStatus'] = this.chatStatus;
    data['specialization'] = this.specialization;
    data['utm_compaign'] = this.utmCompaign;
    data['utm_medium'] = this.utmMedium;
    data['utm_source'] = this.utmSource;
    data['id'] = this.id;
    return data;
  }
}
