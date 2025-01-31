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
  List<UserCountryAvailableTimezones>? userCountryAvailableTimezones;
  List<UserOrganisations>? userOrganisations;

  Body(
      {this.user,
      this.percentProfile,
      this.userMoveEmptyScreenEmpty,
      this.userCountryAvailableTimezones,
      this.userOrganisations});

  Body.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    percentProfile = json['percentProfile'];
    userMoveEmptyScreenEmpty = json['userMoveEmptyScreenEmpty'];
    if (json['userCountryAvailableTimezones'] != null) {
      userCountryAvailableTimezones = <UserCountryAvailableTimezones>[];
      json['userCountryAvailableTimezones'].forEach((v) {
        userCountryAvailableTimezones!
            .add(new UserCountryAvailableTimezones.fromJson(v));
      });
    }
    if (json['userOrganisations'] != null) {
      userOrganisations = <UserOrganisations>[];
      json['userOrganisations'].forEach((v) {
        userOrganisations!.add(new UserOrganisations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class UserCountryAvailableTimezones {
  String? zone;
  String? offset;

  UserCountryAvailableTimezones({this.zone, this.offset});
  UserCountryAvailableTimezones.fromJson(Map<String, dynamic> json) {
    zone = json['zone'] != null ? json['zone'] : null;
    offset = json['offset'] != null ? json['offset'] : null;
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
  bool? sosChatSupport;
  bool? isLiveStreamEnable;
  String? deviceId;
  List<String>? hiddenPosts;
  List<String>? issueList;
  String? chatStatus;
  String? specialization;
  String? utmCompaign;
  String? utmMedium;
  String? utmSource;
  String? deviceType;
  String? onesignalDeviceId;
  String? userCountry;
  String? userTimezone;
  String? userTimezoneOffset;
  String? id;
  int? psychologicalCapital;

  User(
      {this.sId,
      this.sosChatSupport,
      this.isLiveStreamEnable,
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
      this.userTimezone,
      this.userTimezoneOffset,
      this.issueList,
      this.psychologicalCapital,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gender = json['gender'];
    if (json['issueList'] != null) {
      issueList = <String>[];
      json['issueList'].forEach((v) {
        issueList!.add(v);
      });
    }
    sosChatSupport = json['sosChatSupport'];
    isLiveStreamEnable = json['isLiveStreamEnable'];
    psychologicalCapital = json['psychologicalCapital'];
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
    userTimezone = json['userTimezone'];
    userTimezoneOffset = json['userTimezoneOffset'];
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
    data['userTimezone'] = this.userTimezone;
    data['userTimezoneOffset'] = this.userTimezoneOffset;
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

class UserOrganisations {
  String? sId;
  String? status;
  String? user;
  Organisation? organisation;
  Orgusercategories? orgusercategories;
  String? selectedLocOption;
  bool? isDefault;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserOrganisations(
      {this.sId,
      this.status,
      this.user,
      this.organisation,
      this.isDefault,
      this.createdAt,
      this.updatedAt,
      this.orgusercategories,
      this.selectedLocOption,
      this.iV});

  UserOrganisations.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    user = json['user'];
    organisation = json['organisation'] != null
        ? new Organisation.fromJson(json['organisation'])
        : null;
    orgusercategories = json['Orgusercategories'] != null
        ? new Orgusercategories.fromJson(json['Orgusercategories'])
        : null;
    isDefault = json['isDefault'];
    selectedLocOption = json['selectedLocOption'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['status'] = this.status;
    data['user'] = this.user;
    if (this.organisation != null) {
      data['organisation'] = this.organisation!.toJson();
    }
    data['isDefault'] = this.isDefault;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Organisation {
  String? sId;
  String? logo;
  String? name;
  List<String>? themeColors;

  Organisation({this.sId, this.logo, this.name, this.themeColors});

  Organisation.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    logo = json['logo'];
    name = json['name'];
    if (json['theme'] != null) {
      themeColors = [];
      json['theme'].forEach((v) {
        themeColors!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['logo'] = this.logo;
    return data;
  }
}

class Orgusercategories {
  String? sId;
  String? organisation;
  String? label;
  List<Options>? options;
  String? status;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? selectedOption;
  List<OptionsLoc>? optionsLoc;

  Orgusercategories(
      {this.sId,
      this.organisation,
      this.label,
      this.options,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.optionsLoc,
      this.selectedOption});

  Orgusercategories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    organisation = json['organisation'];
    label = json['label'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
    if (json['optionsLoc'] != null) {
      optionsLoc = <OptionsLoc>[];
      json['optionsLoc'].forEach((v) {
        optionsLoc!.add(new OptionsLoc.fromJson(v));
      });
    }
    status = json['status'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    selectedOption = json['selectedOption'];
  }
}

class Options {
  String? name;
  String? status;
  String? sId;

  Options({this.name, this.status, this.sId});

  Options.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['status'] = this.status;
    data['_id'] = this.sId;
    return data;
  }
}

class OptionsLoc {
  String? name;
  String? status;
  String? sId;

  OptionsLoc({this.name, this.status, this.sId});

  OptionsLoc.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['status'] = this.status;
    data['_id'] = this.sId;
    return data;
  }
}
  

// /* class MyProfileModel {
//   int? code;
//   bool? isRedisCached;
//   bool? success;
//   Body? body;

//   MyProfileModel({this.code, this.isRedisCached, this.success, this.body});

//   MyProfileModel.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     isRedisCached = json['isRedisCached'];
//     success = json['success'];
//     body = json['body'] != null ? new Body.fromJson(json['body']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['isRedisCached'] = this.isRedisCached;
//     data['success'] = this.success;
//     if (this.body != null) {
//       data['body'] = this.body!.toJson();
//     }
//     return data;
//   }
// }

// class Body {
//   User? user;
//   int? percentProfile;
//   List? userMoveEmptyScreenEmpty;

//   Body({this.user, this.percentProfile, this.userMoveEmptyScreenEmpty});

//   Body.fromJson(Map<String, dynamic> json) {
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     percentProfile = json['percentProfile'].toInt();
//     userMoveEmptyScreenEmpty = json['userMoveEmptyScreenEmpty'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     return data;
//   }
// }

// class User {
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
//   List<Null>? reports;
//   Anonymous? anonymous;
//   String? chatSocketId;
//   bool? featured;
//   bool? isProvider;
//   String? deviceId;
//   List<String>? hiddenPosts;
//   List<String>? issueList;
//   String? chatStatus;
//   String? specialization;
//   String? utmCompaign;
//   String? utmMedium;
//   String? utmSource;
//   String? deviceType;
//   String? onesignalDeviceId;
//   String? userCountry;
//   String? id;

//   User(
//       {this.sId,
//       this.gender,
//       this.reviews,
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
//       this.likes,
//       this.posts,
//       this.bio,
//       this.createdAt,
//       this.updatedAt,
//       this.iV,
//       this.lastName,
//       this.reports,
//       this.anonymous,
//       this.chatSocketId,
//       this.featured,
//       this.isProvider,
//       this.deviceId,
//       this.hiddenPosts,
//       this.chatStatus,
//       this.specialization,
//       this.utmCompaign,
//       this.utmMedium,
//       this.utmSource,
//       this.deviceType,
//       this.onesignalDeviceId,
//       this.userCountry,
//       this.issueList,
//       this.id});

//   User.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     gender = json['gender'];
//     if (json['issueList'] != null) {
//       issueList = <String>[];
//       json['issueList'].forEach((v) {
//         issueList!.add(v);
//       });
//     }
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
//     anonymous = json['anonymous'] != null
//         ? new Anonymous.fromJson(json['anonymous'])
//         : null;
//     chatSocketId = json['chatSocketId'];
//     featured = json['featured'];
//     isProvider = json['isProvider'];
//     deviceId = json['deviceId'];
//     if (json['hiddenPosts'] != null) {
//       hiddenPosts = <String>[];
//       json['hiddenPosts'].forEach((v) {
//         hiddenPosts!.add(v);
//       });
//     }
//     chatStatus = json['chatStatus'];
//     specialization = json['specialization'];
//     utmCompaign = json['utm_compaign'];
//     utmMedium = json['utm_medium'];
//     utmSource = json['utm_source'];
//     deviceType = json['deviceType'];
//     onesignalDeviceId = json['onesignal_device_id'];
//     userCountry = json['user_country'];
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
//     if (this.anonymous != null) {
//       data['anonymous'] = this.anonymous!.toJson();
//     }
//     data['chatSocketId'] = this.chatSocketId;
//     data['featured'] = this.featured;
//     data['isProvider'] = this.isProvider;
//     data['deviceId'] = this.deviceId;
//     if (this.hiddenPosts != null) {
//       data['hiddenPosts'] = this.hiddenPosts!.map((v) => v).toList();
//     }
//     data['chatStatus'] = this.chatStatus;
//     data['specialization'] = this.specialization;
//     data['utm_compaign'] = this.utmCompaign;
//     data['utm_medium'] = this.utmMedium;
//     data['utm_source'] = this.utmSource;
//     data['deviceType'] = this.deviceType;
//     data['onesignal_device_id'] = this.onesignalDeviceId;
//     data['user_country'] = this.userCountry;
//     data['id'] = this.id;
//     return data;
//   }
// }

// class Anonymous {
//   String? sId;
//   List<String>? connectionsList;
//   String? profilePicture;
//   String? profilePictureType;
//   String? userName;
//   String? primaryAccount;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//   String? gender;

//   Anonymous(
//       {this.sId,
//       this.connectionsList,
//       this.profilePicture,
//       this.profilePictureType,
//       this.userName,
//       this.primaryAccount,
//       this.createdAt,
//       this.updatedAt,
//       this.iV,
//       this.gender});

//   Anonymous.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     if (json['connectionsList'] != null) {
//       connectionsList = <String>[];
//       json['connectionsList'].forEach((v) {
//         connectionsList!.add(v);
//       });
//     }
//     profilePicture = json['profilePicture'];
//     profilePictureType = json['profilePictureType'];
//     userName = json['userName'];
//     primaryAccount = json['primaryAccount'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     gender = json['gender'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     if (this.connectionsList != null) {
//       data['connectionsList'] = this.connectionsList!.map((v) => v).toList();
//     }
//     data['profilePicture'] = this.profilePicture;
//     data['profilePictureType'] = this.profilePictureType;
//     data['userName'] = this.userName;
//     data['primaryAccount'] = this.primaryAccount;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     data['gender'] = this.gender;
//     return data;
//   }
// }


// /* class MyProfileModel {
//   int? code;
//   bool? isRedisCached;
//   bool? success;
//   Body? body;

//   MyProfileModel({this.code, this.isRedisCached, this.success, this.body});

//   MyProfileModel.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     isRedisCached = json['isRedisCached'];
//     success = json['success'];
//     body = json['body'] != null ? new Body.fromJson(json['body']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['isRedisCached'] = this.isRedisCached;
//     data['success'] = this.success;
//     if (this.body != null) {
//       data['body'] = this.body!.toJson();
//     }
//     return data;
//   }
// }

// class Body {
//   User? user;
//   int? percentProfile;
//   List? userMoveEmptyScreenEmpty;

//   Body({this.user, this.percentProfile, this.userMoveEmptyScreenEmpty});

//   Body.fromJson(Map<String, dynamic> json) {
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     percentProfile = json['percentProfile'].toInt();
//     userMoveEmptyScreenEmpty = json['userMoveEmptyScreenEmpty'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     return data;
//   }
// }

// class User {
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
//   List<Null>? reports;
//   Anonymous? anonymous;
//   String? chatSocketId;
//   bool? featured;
//   bool? isProvider;
//   String? deviceId;
//   List<String>? hiddenPosts;
//   List<String>? issueList;
//   String? chatStatus;
//   String? specialization;
//   String? utmCompaign;
//   String? utmMedium;
//   String? utmSource;
//   String? deviceType;
//   String? onesignalDeviceId;
//   String? userCountry;
//   String? id;

//   User(
//       {this.sId,
//       this.gender,
//       this.reviews,
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
//       this.likes,
//       this.posts,
//       this.bio,
//       this.createdAt,
//       this.updatedAt,
//       this.iV,
//       this.lastName,
//       this.reports,
//       this.anonymous,
//       this.chatSocketId,
//       this.featured,
//       this.isProvider,
//       this.deviceId,
//       this.hiddenPosts,
//       this.chatStatus,
//       this.specialization,
//       this.utmCompaign,
//       this.utmMedium,
//       this.utmSource,
//       this.deviceType,
//       this.onesignalDeviceId,
//       this.userCountry,
//       this.issueList,
//       this.id});

//   User.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     gender = json['gender'];
//     if (json['issueList'] != null) {
//       issueList = <String>[];
//       json['issueList'].forEach((v) {
//         issueList!.add(v);
//       });
//     }
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
//     anonymous = json['anonymous'] != null
//         ? new Anonymous.fromJson(json['anonymous'])
//         : null;
//     chatSocketId = json['chatSocketId'];
//     featured = json['featured'];
//     isProvider = json['isProvider'];
//     deviceId = json['deviceId'];
//     if (json['hiddenPosts'] != null) {
//       hiddenPosts = <String>[];
//       json['hiddenPosts'].forEach((v) {
//         hiddenPosts!.add(v);
//       });
//     }
//     chatStatus = json['chatStatus'];
//     specialization = json['specialization'];
//     utmCompaign = json['utm_compaign'];
//     utmMedium = json['utm_medium'];
//     utmSource = json['utm_source'];
//     deviceType = json['deviceType'];
//     onesignalDeviceId = json['onesignal_device_id'];
//     userCountry = json['user_country'];
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
//     if (this.anonymous != null) {
//       data['anonymous'] = this.anonymous!.toJson();
//     }
//     data['chatSocketId'] = this.chatSocketId;
//     data['featured'] = this.featured;
//     data['isProvider'] = this.isProvider;
//     data['deviceId'] = this.deviceId;
//     if (this.hiddenPosts != null) {
//       data['hiddenPosts'] = this.hiddenPosts!.map((v) => v).toList();
//     }
//     data['chatStatus'] = this.chatStatus;
//     data['specialization'] = this.specialization;
//     data['utm_compaign'] = this.utmCompaign;
//     data['utm_medium'] = this.utmMedium;
//     data['utm_source'] = this.utmSource;
//     data['deviceType'] = this.deviceType;
//     data['onesignal_device_id'] = this.onesignalDeviceId;
//     data['user_country'] = this.userCountry;
//     data['id'] = this.id;
//     return data;
//   }
// }

// class Anonymous {
//   String? sId;
//   List<String>? connectionsList;
//   String? profilePicture;
//   String? profilePictureType;
//   String? userName;
//   String? primaryAccount;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//   String? gender;

//   Anonymous(
//       {this.sId,
//       this.connectionsList,
//       this.profilePicture,
//       this.profilePictureType,
//       this.userName,
//       this.primaryAccount,
//       this.createdAt,
//       this.updatedAt,
//       this.iV,
//       this.gender});

//   Anonymous.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     if (json['connectionsList'] != null) {
//       connectionsList = <String>[];
//       json['connectionsList'].forEach((v) {
//         connectionsList!.add(v);
//       });
//     }
//     profilePicture = json['profilePicture'];
//     profilePictureType = json['profilePictureType'];
//     userName = json['userName'];
//     primaryAccount = json['primaryAccount'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     gender = json['gender'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     if (this.connectionsList != null) {
//       data['connectionsList'] = this.connectionsList!.map((v) => v).toList();
//     }
//     data['profilePicture'] = this.profilePicture;
//     data['profilePictureType'] = this.profilePictureType;
//     data['userName'] = this.userName;
//     data['primaryAccount'] = this.primaryAccount;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     data['gender'] = this.gender;
//     return data;
//   }
// }
// */


