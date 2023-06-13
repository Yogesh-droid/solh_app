class GlobalSearchModel {
  bool? success;
  List<Providers>? providers;
  List<Providers>? allideProviders;
  List<Connection>? connection;
  List<GroupCount>? groupCount;
  List<PostCount>? postCount;

  GlobalSearchModel(
      {this.success,
      this.providers,
      this.allideProviders,
      this.connection,
      this.groupCount,
      this.postCount});

  GlobalSearchModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['providers'] != null) {
      providers = <Providers>[];
      json['providers'].forEach((v) {
        providers!.add(new Providers.fromJson(v));
      });
    }
    if (json['allideProviders'] != null) {
      allideProviders = <Providers>[];
      json['allideProviders'].forEach((v) {
        allideProviders!.add(new Providers.fromJson(v));
      });
    }
    if (json['connection'] != null) {
      connection = <Connection>[];
      json['connection'].forEach((v) {
        connection!.add(new Connection.fromJson(v));
      });
    }
    if (json['groupCount'] != null) {
      groupCount = <GroupCount>[];
      json['groupCount'].forEach((v) {
        groupCount!.add(new GroupCount.fromJson(v));
      });
    }
    if (json['postCount'] != null) {
      postCount = <PostCount>[];
      json['postCount'].forEach((v) {
        postCount!.add(new PostCount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.providers != null) {
      data['providers'] = this.providers!.map((v) => v.toJson()).toList();
    }
    if (this.allideProviders != null) {
      data['allideProviders'] =
          this.allideProviders!.map((v) => v.toJson()).toList();
    }
    if (this.connection != null) {
      data['connection'] = this.connection!.map((v) => v.toJson()).toList();
    }
    if (this.groupCount != null) {
      data['groupCount'] = this.groupCount!.map((v) => v.toJson()).toList();
    }
    if (this.postCount != null) {
      data['postCount'] = this.postCount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Providers {
  String? sId;
  String? name;
  String? prefix;
  String? preview;
  Profession? profession;
  String? fee;
  List<String>? education;
  int? experience;
  String? bio;
  int? apptCount;
  String? profilePicture;
  String? packageType;
  int? feeAmount;
  String? feeCurrency;
  String? status;

  Providers(
      {this.sId,
      this.name,
      this.prefix,
      this.preview,
      this.profession,
      this.fee,
      this.education,
      this.experience,
      this.bio,
      this.apptCount,
      this.profilePicture,
      this.packageType,
      this.feeAmount,
      this.feeCurrency,
      this.status});

  Providers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    profession = json['profession'] != null
        ? new Profession.fromJson(json['profession'])
        : null;
    fee = json['fee'];
    prefix = json['prefix'];
    preview = json['preview'];
    education = json['education'].cast<String>();
    experience = json['experience'];
    bio = json['bio'];
    apptCount = json['apptCount'];
    profilePicture = json['profilePicture'];
    packageType = json['packageType'];
    feeAmount = json['feeAmount'];
    feeCurrency = json['feeCurrency'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.profession != null) {
      data['profession'] = this.profession!.toJson();
    }
    data['fee'] = this.fee;
    data['education'] = this.education;
    data['experience'] = this.experience;
    data['bio'] = this.bio;
    data['apptCount'] = this.apptCount;
    data['profilePicture'] = this.profilePicture;
    data['packageType'] = this.packageType;
    data['feeAmount'] = this.feeAmount;
    data['feeCurrency'] = this.feeCurrency;
    data['status'] = this.status;
    return data;
  }
}

class Profession {
  String? sId;
  String? name;

  Profession({this.sId, this.name});

  Profession.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class Connection {
  String? specialization;
  String? chatSocketId;
  String? chatStatus;
  String? chatWith;
  String? userCountry;
  String? userTimezone;
  String? userTimezoneOffset;
  String? utmSource;
  String? utmCompaign;
  String? utmMedium;
  List<String>? issueList;
  String? issueOther;
  String? orgType;
  String? orgName;
  bool? sosChatSupport;
  int? psychologicalCapital;
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
  String? deviceId;
  bool? featured;
  List<Null>? hiddenPosts;
  bool? isProvider;
  List<Null>? reports;
  String? onesignalDeviceId;
  String? anonymous;
  String? deviceType;
  String? id;

  Connection(
      {this.specialization,
      this.chatSocketId,
      this.chatStatus,
      this.chatWith,
      this.userCountry,
      this.userTimezone,
      this.userTimezoneOffset,
      this.utmSource,
      this.utmCompaign,
      this.utmMedium,
      this.issueList,
      this.issueOther,
      this.orgType,
      this.orgName,
      this.sosChatSupport,
      this.psychologicalCapital,
      this.sId,
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
      this.deviceId,
      this.featured,
      this.hiddenPosts,
      this.isProvider,
      this.reports,
      this.onesignalDeviceId,
      this.anonymous,
      this.deviceType,
      this.id});

  Connection.fromJson(Map<String, dynamic> json) {
    specialization = json['specialization'];
    chatSocketId = json['chatSocketId'];
    chatStatus = json['chatStatus'];
    chatWith = json['chatWith'];
    userCountry = json['user_country'];
    userTimezone = json['userTimezone'];
    userTimezoneOffset = json['userTimezoneOffset'];
    utmSource = json['utm_source'];
    utmCompaign = json['utm_compaign'];
    utmMedium = json['utm_medium'];
    issueList = json['issueList'].cast<String>();
    issueOther = json['issueOther'];
    orgType = json['orgType'];
    orgName = json['orgName'];
    sosChatSupport = json['sosChatSupport'];
    psychologicalCapital = json['psychologicalCapital'];
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
    deviceId = json['deviceId'];
    featured = json['featured'];
    isProvider = json['isProvider'];
    onesignalDeviceId = json['onesignal_device_id'];
    anonymous = json['anonymous'];
    deviceType = json['deviceType'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['specialization'] = this.specialization;
    data['chatSocketId'] = this.chatSocketId;
    data['chatStatus'] = this.chatStatus;
    data['chatWith'] = this.chatWith;
    data['user_country'] = this.userCountry;
    data['userTimezone'] = this.userTimezone;
    data['userTimezoneOffset'] = this.userTimezoneOffset;
    data['utm_source'] = this.utmSource;
    data['utm_compaign'] = this.utmCompaign;
    data['utm_medium'] = this.utmMedium;
    data['issueList'] = this.issueList;
    data['issueOther'] = this.issueOther;
    data['orgType'] = this.orgType;
    data['orgName'] = this.orgName;
    data['sosChatSupport'] = this.sosChatSupport;
    data['psychologicalCapital'] = this.psychologicalCapital;
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
    data['deviceId'] = this.deviceId;
    data['featured'] = this.featured;
    data['isProvider'] = this.isProvider;
    data['onesignal_device_id'] = this.onesignalDeviceId;
    data['anonymous'] = this.anonymous;
    data['deviceType'] = this.deviceType;
    data['id'] = this.id;
    return data;
  }
}

class GroupCount {
  String? sId;
  List<String>? groupMembers;
  List<String>? groupTags;
  String? groupType;
  Null journalCount;
  String? groupName;
  String? groupDescription;
  String? groupMediaUrl;
  String? groupMediaType;
  List<String>? defaultAdmin;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? featured;
  String? groupStatus;
  List<String>? anonymousMembers;
  String? id;

  GroupCount(
      {this.sId,
      this.groupMembers,
      this.groupTags,
      this.groupType,
      this.journalCount,
      this.groupName,
      this.groupDescription,
      this.groupMediaUrl,
      this.groupMediaType,
      this.defaultAdmin,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.featured,
      this.groupStatus,
      this.anonymousMembers,
      this.id});

  GroupCount.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    groupMembers = json['groupMembers'].cast<String>();
    groupTags = json['groupTags'].cast<String>();
    groupType = json['groupType'];
    journalCount = json['journalCount'];
    groupName = json['groupName'];
    groupDescription = json['groupDescription'];
    groupMediaUrl = json['groupMediaUrl'];
    groupMediaType = json['groupMediaType'];
    defaultAdmin = json['defaultAdmin'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    featured = json['featured'];
    groupStatus = json['groupStatus'];
    anonymousMembers = json['anonymousMembers'].cast<String>();
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['groupMembers'] = this.groupMembers;
    data['groupTags'] = this.groupTags;
    data['groupType'] = this.groupType;
    data['journalCount'] = this.journalCount;
    data['groupName'] = this.groupName;
    data['groupDescription'] = this.groupDescription;
    data['groupMediaUrl'] = this.groupMediaUrl;
    data['groupMediaType'] = this.groupMediaType;
    data['defaultAdmin'] = this.defaultAdmin;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['featured'] = this.featured;
    data['groupStatus'] = this.groupStatus;
    data['anonymousMembers'] = this.anonymousMembers;
    data['id'] = this.id;
    return data;
  }
}

class PostCount {
  String? aspectRatio;
  String? mediaHeight;
  String? mediaWidth;
  int? featuredOrder;
  String? sId;
  String? description;
  String? postedBy;
  int? likes;
  List<String>? likedBy;
  int? comments;
  String? date;
  String? time;
  List<String>? feelings;
  List<Null>? children;
  String? journalType;
  bool? isLiked;
  UserId? userId;
  GroupCount? groupPostedIn;
  String? postIn;
  bool? anonymousJournal;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? status;
  String? id;
  String? mediaUrl;
  String? mediaType;

  PostCount(
      {this.aspectRatio,
      this.mediaHeight,
      this.mediaWidth,
      this.featuredOrder,
      this.sId,
      this.description,
      this.postedBy,
      this.likes,
      this.likedBy,
      this.comments,
      this.date,
      this.time,
      this.feelings,
      this.children,
      this.journalType,
      this.isLiked,
      this.userId,
      this.groupPostedIn,
      this.postIn,
      this.anonymousJournal,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.status,
      this.id,
      this.mediaUrl,
      this.mediaType});

  PostCount.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspectRatio'];
    mediaHeight = json['mediaHeight'];
    mediaWidth = json['mediaWidth'];
    featuredOrder = json['featuredOrder'];
    sId = json['_id'];
    description = json['description'];
    postedBy = json['postedBy'];
    likes = json['likes'];
    likedBy = json['likedBy'].cast<String>();
    comments = json['comments'];
    date = json['date'];
    time = json['time'];
    feelings = json['feelings'].cast<String>();
    journalType = json['journalType'];
    isLiked = json['isLiked'];
    userId =
        json['userId'] != null ? new UserId.fromJson(json['userId']) : null;
    groupPostedIn = json['groupPostedIn'] != null
        ? new GroupCount.fromJson(json['groupPostedIn'])
        : null;
    postIn = json['postIn'];
    anonymousJournal = json['anonymousJournal'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    status = json['status'];
    id = json['id'];
    mediaUrl = json['mediaUrl'];
    mediaType = json['mediaType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aspectRatio'] = this.aspectRatio;
    data['mediaHeight'] = this.mediaHeight;
    data['mediaWidth'] = this.mediaWidth;
    data['featuredOrder'] = this.featuredOrder;
    data['_id'] = this.sId;
    data['description'] = this.description;
    data['postedBy'] = this.postedBy;
    data['likes'] = this.likes;
    data['likedBy'] = this.likedBy;
    data['comments'] = this.comments;
    data['date'] = this.date;
    data['time'] = this.time;
    data['feelings'] = this.feelings;
    data['journalType'] = this.journalType;
    data['isLiked'] = this.isLiked;
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    if (this.groupPostedIn != null) {
      data['groupPostedIn'] = this.groupPostedIn!.toJson();
    }
    data['postIn'] = this.postIn;
    data['anonymousJournal'] = this.anonymousJournal;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['status'] = this.status;
    data['id'] = this.id;
    data['mediaUrl'] = this.mediaUrl;
    data['mediaType'] = this.mediaType;
    return data;
  }
}

class UserId {
  String? chatWith;
  String? userTimezone;
  String? userTimezoneOffset;
  bool? sosChatSupport;
  int? psychologicalCapital;
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
  List<String>? hiddenPosts;
  String? onesignalDeviceId;
  String? deviceType;
  String? userCountry;
  String? chatSocketId;
  String? chatStatus;
  String? specialization;
  String? utmCompaign;
  String? utmMedium;
  String? utmSource;
  List<String>? issueList;
  String? issueOther;
  String? orgName;
  String? orgType;
  String? id;
  List<Null>? issuesList;

  UserId(
      {this.chatWith,
      this.userTimezone,
      this.userTimezoneOffset,
      this.sosChatSupport,
      this.psychologicalCapital,
      this.sId,
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
      this.issueList,
      this.issueOther,
      this.orgName,
      this.orgType,
      this.id,
      this.issuesList});

  UserId.fromJson(Map<String, dynamic> json) {
    chatWith = json['chatWith'];
    userTimezone = json['userTimezone'];
    userTimezoneOffset = json['userTimezoneOffset'];
    sosChatSupport = json['sosChatSupport'];
    psychologicalCapital = json['psychologicalCapital'];
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
    anonymous = json['anonymous'];
    featured = json['featured'];
    deviceId = json['deviceId'];
    hiddenPosts = json['hiddenPosts'].cast<String>();
    onesignalDeviceId = json['onesignal_device_id'];
    deviceType = json['deviceType'];
    userCountry = json['user_country'];
    chatSocketId = json['chatSocketId'];
    chatStatus = json['chatStatus'];
    specialization = json['specialization'];
    utmCompaign = json['utm_compaign'];
    utmMedium = json['utm_medium'];
    utmSource = json['utm_source'];
    issueList = json['issueList'].cast<String>();
    issueOther = json['issueOther'];
    orgName = json['orgName'];
    orgType = json['orgType'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chatWith'] = this.chatWith;
    data['userTimezone'] = this.userTimezone;
    data['userTimezoneOffset'] = this.userTimezoneOffset;
    data['sosChatSupport'] = this.sosChatSupport;
    data['psychologicalCapital'] = this.psychologicalCapital;
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
    data['anonymous'] = this.anonymous;
    data['featured'] = this.featured;
    data['deviceId'] = this.deviceId;
    data['hiddenPosts'] = this.hiddenPosts;
    data['onesignal_device_id'] = this.onesignalDeviceId;
    data['deviceType'] = this.deviceType;
    data['user_country'] = this.userCountry;
    data['chatSocketId'] = this.chatSocketId;
    data['chatStatus'] = this.chatStatus;
    data['specialization'] = this.specialization;
    data['utm_compaign'] = this.utmCompaign;
    data['utm_medium'] = this.utmMedium;
    data['utm_source'] = this.utmSource;
    data['issueList'] = this.issueList;
    data['issueOther'] = this.issueOther;
    data['orgName'] = this.orgName;
    data['orgType'] = this.orgType;
    data['id'] = this.id;
    return data;
  }
}




/* class GlobalSearchModel {
  bool? success;
  List<Connection>? connection;
  List<GroupCount>? groupCount;
  List<PostCount>? postCount;

  GlobalSearchModel(
      {this.success, this.connection, this.groupCount, this.postCount});

  GlobalSearchModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['connection'] != null) {
      connection = <Connection>[];
      json['connection'].forEach((v) {
        connection!.add(new Connection.fromJson(v));
      });
    }
    if (json['groupCount'] != null) {
      groupCount = <GroupCount>[];
      json['groupCount'].forEach((v) {
        groupCount!.add(new GroupCount.fromJson(v));
      });
    }
    if (json['postCount'] != null) {
      postCount = <PostCount>[];
      json['postCount'].forEach((v) {
        postCount!.add(new PostCount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.connection != null) {
      data['connection'] = this.connection!.map((v) => v.toJson()).toList();
    }
    if (this.groupCount != null) {
      data['groupCount'] = this.groupCount!.map((v) => v.toJson()).toList();
    }
    if (this.postCount != null) {
      data['postCount'] = this.postCount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Connection {
  bool? isProvider;
  List<Null>? reports;
  bool? featured;
  List<Null>? hiddenPosts;
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
  String? id;
  String? deviceId;
  String? chatSocketId;
  int? featuredOrder;
  String? onesignalDeviceId;

  Connection(
      {this.isProvider,
      this.reports,
      this.featured,
      this.hiddenPosts,
      this.sId,
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
      this.id,
      this.deviceId,
      this.chatSocketId,
      this.featuredOrder,
      this.onesignalDeviceId});

  Connection.fromJson(Map<String, dynamic> json) {
    isProvider = json['isProvider'];
    // if (json['reports'] != null) {
    //   reports = <Null>[];
    //   json['reports'].forEach((v) {
    //     reports!.add(new Null.fromJson(v));
    //   });
    // }
    featured = json['featured'];
    // if (json['hiddenPosts'] != null) {
    //   hiddenPosts = <Null>[];
    //   json['hiddenPosts'].forEach((v) {
    //     hiddenPosts!.add(new Null.fromJson(v));
    //   });
    // }
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
    id = json['id'];
    deviceId = json['deviceId'];
    chatSocketId = json['chatSocketId'];
    featuredOrder = json['featuredOrder'];
    onesignalDeviceId = json['onesignal_device_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isProvider'] = this.isProvider;
    // if (this.reports != null) {
    //   data['reports'] = this.reports!.map((v) => v.toJson()).toList();
    // }
    data['featured'] = this.featured;
    // if (this.hiddenPosts != null) {
    //   data['hiddenPosts'] = this.hiddenPosts!.map((v) => v.toJson()).toList();
    // }
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
    data['id'] = this.id;
    data['deviceId'] = this.deviceId;
    data['chatSocketId'] = this.chatSocketId;
    data['featuredOrder'] = this.featuredOrder;
    data['onesignal_device_id'] = this.onesignalDeviceId;
    return data;
  }
}

class GroupCount {
  String? groupStatus;
  String? sId;
  List<String>? groupMembers;
  List<String>? groupTags;
  String? groupType;
  Null? journalCount;
  String? groupName;
  String? groupDescription;
  String? groupMediaUrl;
  String? groupMediaType;
  List<String>? defaultAdmin;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? featured;
  String? id;

  GroupCount(
      {this.groupStatus,
      this.sId,
      this.groupMembers,
      this.groupTags,
      this.groupType,
      this.journalCount,
      this.groupName,
      this.groupDescription,
      this.groupMediaUrl,
      this.groupMediaType,
      this.defaultAdmin,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.featured,
      this.id});

  GroupCount.fromJson(Map<String, dynamic> json) {
    groupStatus = json['groupStatus'];
    sId = json['_id'];
    groupMembers = json['groupMembers'].cast<String>();
    groupTags = json['groupTags'].cast<String>();
    groupType = json['groupType'];
    journalCount = json['journalCount'];
    groupName = json['groupName'];
    groupDescription = json['groupDescription'];
    groupMediaUrl = json['groupMediaUrl'];
    groupMediaType = json['groupMediaType'];
    defaultAdmin = json['defaultAdmin'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    featured = json['featured'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupStatus'] = this.groupStatus;
    data['_id'] = this.sId;
    data['groupMembers'] = this.groupMembers;
    data['groupTags'] = this.groupTags;
    data['groupType'] = this.groupType;
    data['journalCount'] = this.journalCount;
    data['groupName'] = this.groupName;
    data['groupDescription'] = this.groupDescription;
    data['groupMediaUrl'] = this.groupMediaUrl;
    data['groupMediaType'] = this.groupMediaType;
    data['defaultAdmin'] = this.defaultAdmin;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['featured'] = this.featured;
    data['id'] = this.id;
    return data;
  }
}

class PostCount {
  String? userStatus;
  String? sId;
  String? description;
  String? mediaUrl;
  String? mediaType;
  String? postedBy;
  int? likes;
  List<String>? likedBy;
  int? comments;
  String? date;
  String? time;
  List<String>? feelings;
  List<Null>? children;
  String? journalType;
  bool? isLiked;
  UserId? userId;
  GroupPostedIn? groupPostedIn;
  String? postIn;
  bool? anonymousJournal;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? id;

  PostCount(
      {this.userStatus,
      this.sId,
      this.description,
      this.mediaUrl,
      this.mediaType,
      this.postedBy,
      this.likes,
      this.likedBy,
      this.comments,
      this.date,
      this.time,
      this.feelings,
      this.children,
      this.journalType,
      this.isLiked,
      this.userId,
      this.groupPostedIn,
      this.postIn,
      this.anonymousJournal,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.id});

  PostCount.fromJson(Map<String, dynamic> json) {
    userStatus = json['userStatus'];
    sId = json['_id'];
    description = json['description'];
    mediaUrl = json['mediaUrl'];
    mediaType = json['mediaType'];
    postedBy = json['postedBy'];
    likes = json['likes'];
    likedBy = json['likedBy'].cast<String>();
    comments = json['comments'];
    date = json['date'];
    time = json['time'];
    feelings = json['feelings'].cast<String>();
    // if (json['children'] != null) {
    //   children = <Null>[];
    //   json['children'].forEach((v) {
    //     children!.add(new Null.fromJson(v));
    //   });
    // }
    journalType = json['journalType'];
    isLiked = json['isLiked'];
    userId =
        json['userId'] != null ? new UserId.fromJson(json['userId']) : null;
    groupPostedIn = json['groupPostedIn'] != null
        ? new GroupPostedIn.fromJson(json['groupPostedIn'])
        : null;
    postIn = json['postIn'];
    anonymousJournal = json['anonymousJournal'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userStatus'] = this.userStatus;
    data['_id'] = this.sId;
    data['description'] = this.description;
    data['mediaUrl'] = this.mediaUrl;
    data['mediaType'] = this.mediaType;
    data['postedBy'] = this.postedBy;
    data['likes'] = this.likes;
    data['likedBy'] = this.likedBy;
    data['comments'] = this.comments;
    data['date'] = this.date;
    data['time'] = this.time;
    data['feelings'] = this.feelings;
    // if (this.children != null) {
    //   data['children'] = this.children!.map((v) => v.toJson()).toList();
    // }
    data['journalType'] = this.journalType;
    data['isLiked'] = this.isLiked;
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    if (this.groupPostedIn != null) {
      data['groupPostedIn'] = this.groupPostedIn!.toJson();
    }
    data['postIn'] = this.postIn;
    data['anonymousJournal'] = this.anonymousJournal;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['id'] = this.id;
    return data;
  }
}

class UserId {
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
  String? id;

  UserId(
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
      this.id});

  UserId.fromJson(Map<String, dynamic> json) {
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
    //   data['reports'] = this.reports!.map((v) => v.toJson()).toList();
    // }
    data['anonymous'] = this.anonymous;
    data['featured'] = this.featured;
    data['deviceId'] = this.deviceId;
    // if (this.hiddenPosts != null) {
    //   data['hiddenPosts'] = this.hiddenPosts!.map((v) => v.toJson()).toList();
    // }
    data['onesignal_device_id'] = this.onesignalDeviceId;
    data['id'] = this.id;
    return data;
  }
}

class GroupPostedIn {
  String? groupStatus;
  String? sId;
  List<String>? groupMembers;
  List<String>? groupTags;
  String? groupType;
  Null? journalCount;
  String? groupName;
  String? groupMediaUrl;
  String? groupMediaType;
  List<String>? defaultAdmin;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? featured;
  String? id;

  GroupPostedIn(
      {this.groupStatus,
      this.sId,
      this.groupMembers,
      this.groupTags,
      this.groupType,
      this.journalCount,
      this.groupName,
      this.groupMediaUrl,
      this.groupMediaType,
      this.defaultAdmin,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.featured,
      this.id});

  GroupPostedIn.fromJson(Map<String, dynamic> json) {
    groupStatus = json['groupStatus'];
    sId = json['_id'];
    groupMembers = json['groupMembers'].cast<String>();
    groupTags = json['groupTags'].cast<String>();
    groupType = json['groupType'];
    journalCount = json['journalCount'];
    groupName = json['groupName'];
    groupMediaUrl = json['groupMediaUrl'];
    groupMediaType = json['groupMediaType'];
    defaultAdmin = json['defaultAdmin'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    featured = json['featured'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupStatus'] = this.groupStatus;
    data['_id'] = this.sId;
    data['groupMembers'] = this.groupMembers;
    data['groupTags'] = this.groupTags;
    data['groupType'] = this.groupType;
    data['journalCount'] = this.journalCount;
    data['groupName'] = this.groupName;
    data['groupMediaUrl'] = this.groupMediaUrl;
    data['groupMediaType'] = this.groupMediaType;
    data['defaultAdmin'] = this.defaultAdmin;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['featured'] = this.featured;
    data['id'] = this.id;
    return data;
  }
}
 */