class MyProfileModel {
  int? code;
  bool? isRedisCached;
  bool? success;
  Body? body;

  MyProfileModel({this.code, this.isRedisCached, this.success, this.body});

  MyProfileModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    isRedisCached = json['isRedisCached'];
    success = json['success'];
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['isRedisCached'] = this.isRedisCached;
    data['success'] = this.success;
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    return data;
  }
}

class Body {
  User? user;
  int? percentProfile;
  List? userMoveEmptyScreenEmpty;

  Body({this.user, this.percentProfile, this.userMoveEmptyScreenEmpty});

  Body.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    percentProfile = json['percentProfile'].toInt();
    userMoveEmptyScreenEmpty = json['userMoveEmptyScreenEmpty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
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
  List<Null>? reports;
  Anonymous? anonymous;
  String? chatSocketId;
  bool? featured;
  bool? isProvider;
  String? deviceId;
  List<String>? hiddenPosts;
  String? chatStatus;
  String? specialization;
  String? utmCompaign;
  String? utmMedium;
  String? utmSource;
  String? deviceType;
  String? onesignalDeviceId;
  String? userCountry;
  String? id;

  User(
      {this.sId,
      this.gender,
      this.reviews,
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
      this.likes,
      this.posts,
      this.bio,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.lastName,
      this.reports,
      this.anonymous,
      this.chatSocketId,
      this.featured,
      this.isProvider,
      this.deviceId,
      this.hiddenPosts,
      this.chatStatus,
      this.specialization,
      this.utmCompaign,
      this.utmMedium,
      this.utmSource,
      this.deviceType,
      this.onesignalDeviceId,
      this.userCountry,
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
    anonymous = json['anonymous'] != null
        ? new Anonymous.fromJson(json['anonymous'])
        : null;
    chatSocketId = json['chatSocketId'];
    featured = json['featured'];
    isProvider = json['isProvider'];
    deviceId = json['deviceId'];
    if (json['hiddenPosts'] != null) {
      hiddenPosts = <String>[];
      json['hiddenPosts'].forEach((v) {
        hiddenPosts!.add(v);
      });
    }
    chatStatus = json['chatStatus'];
    specialization = json['specialization'];
    utmCompaign = json['utm_compaign'];
    utmMedium = json['utm_medium'];
    utmSource = json['utm_source'];
    deviceType = json['deviceType'];
    onesignalDeviceId = json['onesignal_device_id'];
    userCountry = json['user_country'];
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
    if (this.anonymous != null) {
      data['anonymous'] = this.anonymous!.toJson();
    }
    data['chatSocketId'] = this.chatSocketId;
    data['featured'] = this.featured;
    data['isProvider'] = this.isProvider;
    data['deviceId'] = this.deviceId;
    if (this.hiddenPosts != null) {
      data['hiddenPosts'] = this.hiddenPosts!.map((v) => v).toList();
    }
    data['chatStatus'] = this.chatStatus;
    data['specialization'] = this.specialization;
    data['utm_compaign'] = this.utmCompaign;
    data['utm_medium'] = this.utmMedium;
    data['utm_source'] = this.utmSource;
    data['deviceType'] = this.deviceType;
    data['onesignal_device_id'] = this.onesignalDeviceId;
    data['user_country'] = this.userCountry;
    data['id'] = this.id;
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
