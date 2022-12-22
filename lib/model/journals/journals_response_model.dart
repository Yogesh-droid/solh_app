class JournalsResponseModel {
  int? totalPosts;
  Previous? previous;
  Previous? next;
  int? rowsPerPage;
  List<Journals>? journals;

  JournalsResponseModel(
      {this.totalPosts,
      this.previous,
      this.next,
      this.rowsPerPage,
      this.journals});

  JournalsResponseModel.fromJson(Map<String, dynamic> json) {
    totalPosts = json['totalPosts'];
    previous = json['previous'] != null
        ? new Previous.fromJson(json['previous'])
        : null;
    next = json['next'] != null ? new Previous.fromJson(json['next']) : null;
    rowsPerPage = json['rowsPerPage'];
    if (json['data'] != null) {
      journals = <Journals>[];
      json['data'].forEach((v) {
        journals!.add(new Journals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPosts'] = this.totalPosts;
    if (this.previous != null) {
      data['previous'] = this.previous!.toJson();
    }
    if (this.next != null) {
      data['next'] = this.next!.toJson();
    }
    data['rowsPerPage'] = this.rowsPerPage;
    if (this.journals != null) {
      data['data'] = this.journals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Previous {
  int? pageNumber;
  int? limit;

  Previous({this.pageNumber, this.limit});

  Previous.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNumber'] = this.pageNumber;
    data['limit'] = this.limit;
    return data;
  }
}

class Journals {
  String? id;
  bool? official;
  String? description;
  String? mediaUrl;
  String? mediaType;
  String? aspectRatio;
  int? likes;
  int? comments;
  bool? isLiked;
  List<String>? likedBy;
  List<Feelings>? feelings;
  String? createdAt;
  String? updatedAt;
  int? length;
  String? d;
  Null? bestComment;
  Group? group;
  bool? anonymousJournal;
  PostedBy? postedBy;

  Journals(
      {this.id,
      this.official,
      this.description,
      this.aspectRatio,
      this.mediaUrl,
      this.mediaType,
      this.likes,
      this.comments,
      this.isLiked,
      this.likedBy,
      this.feelings,
      this.createdAt,
      this.updatedAt,
      this.length,
      this.d,
      this.bestComment,
      this.group,
      this.anonymousJournal,
      this.postedBy});

  Journals.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    official = json['official'];
    description = json['description'];
    aspectRatio = json['aspectRatio'];
    mediaUrl = json['mediaUrl'];
    mediaType = json['mediaType'];
    likes = json['likes'];
    comments = json['comments'];
    isLiked = json['isLiked'];
    likedBy = json['likedBy'].cast<String>();
    if (json['feelings'] != null) {
      feelings = <Feelings>[];
      json['feelings'].forEach((v) {
        feelings!.add(new Feelings.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    length = json['length'];
    d = json['d'];
    bestComment = json['bestComment'];
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
    anonymousJournal = json['anonymousJournal'];
    postedBy = json['postedBy'] != null
        ? new PostedBy.fromJson(json['postedBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['official'] = this.official;
    data['description'] = this.description;
    data['mediaUrl'] = this.mediaUrl;
    data['aspectRatio'] = this.aspectRatio;
    data['mediaType'] = this.mediaType;
    data['likes'] = this.likes;
    data['comments'] = this.comments;
    data['isLiked'] = this.isLiked;
    data['likedBy'] = this.likedBy;
    if (this.feelings != null) {
      data['feelings'] = this.feelings!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['length'] = this.length;
    data['d'] = this.d;
    data['bestComment'] = this.bestComment;
    if (this.group != null) {
      data['group'] = this.group!.toJson();
    }
    data['anonymousJournal'] = this.anonymousJournal;
    if (this.postedBy != null) {
      data['postedBy'] = this.postedBy!.toJson();
    }
    return data;
  }
}

class Feelings {
  String? sId;
  String? feelingName;
  String? createdBy;
  int? iV;
  String? feelingType;

  Feelings(
      {this.sId, this.feelingName, this.createdBy, this.iV, this.feelingType});

  Feelings.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    feelingName = json['feelingName'];
    createdBy = json['createdBy'];
    iV = json['__v'];
    feelingType = json['feelingType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['feelingName'] = this.feelingName;
    data['createdBy'] = this.createdBy;
    data['__v'] = this.iV;
    data['feelingType'] = this.feelingType;
    return data;
  }
}

class Group {
  String? groupName;
  String? groupImage;
  String? sId;

  Group({this.groupName, this.groupImage, this.sId});

  Group.fromJson(Map<String, dynamic> json) {
    groupName = json['groupName'];
    groupImage = json['groupMediaUrl'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupName'] = this.groupName;
    data['groupMediaUrl'] = this.groupImage;
    data['_id'] = this.sId;
    return data;
  }
}

class PostedBy {
  String? sId;
  String? status;
  String? profilePicture;
  String? profilePictureType;
  String? userType;
  String? uid;
  String? userName;
  String? name;
  Anonymous? anonymous;
  bool? isProvider;
  String? id;

  PostedBy(
      {this.sId,
      this.status,
      this.profilePicture,
      this.profilePictureType,
      this.userType,
      this.uid,
      this.userName,
      this.name,
      this.anonymous,
      this.isProvider,
      this.id});

  PostedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    profilePicture = json['profilePicture'];
    profilePictureType = json['profilePictureType'];
    userType = json['userType'];
    uid = json['uid'];
    userName = json['userName'];
    name = json['name'];
    anonymous = json['anonymous'] != null
        ? new Anonymous.fromJson(json['anonymous'])
        : null;
    isProvider = json['isProvider'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['status'] = this.status;
    data['profilePicture'] = this.profilePicture;
    data['profilePictureType'] = this.profilePictureType;
    data['userType'] = this.userType;
    data['uid'] = this.uid;
    data['userName'] = this.userName;
    data['name'] = this.name;
    if (this.anonymous != null) {
      data['anonymous'] = this.anonymous!.toJson();
    }
    data['isProvider'] = this.isProvider;
    data['id'] = this.id;
    return data;
  }
}

class Anonymous {
  String? sId;
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

/* import 'package:solh/model/journals/get_jouranal_comment_model.dart';

class JournalsResponseModel {
  List<Journals>? journals;
  int? totalPages;
  int? totalJournals;

  JournalsResponseModel({this.journals, this.totalPages, this.totalJournals});

  JournalsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['journals'] != null) {
      journals = <Journals>[];
      json['journals'].forEach((v) {
        journals!.add(new Journals.fromJson(v));
      });
    }
    totalPages = json['totalPages'];
    totalJournals = json['totalJournals'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.journals != null) {
      data['journals'] = this.journals!.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = this.totalPages;
    data['totalJournals'] = this.totalJournals;
    return data;
  }
}

class Journals {
  String? id;
  bool? official;
  String? description;
  int? likes;
  int? comments;
  bool? isLiked;
  List<String>? likedBy;
  List<Feelings>? feelings;
  String? createdAt;
  String? updatedAt;
  BestComment? bestComment;
  PostedBy? postedBy;
  bool? anonymousJournal;
  String? mediaHeight;
  String? aspectRatio;
  String? mediaWidth;
  String? mediaUrl;
  String? mediaType;
  Group? group;

  Journals(
      {this.id,
      this.description,
      this.likes,
      this.comments,
      this.isLiked,
      this.likedBy,
      this.official,
      this.feelings,
      this.createdAt,
      this.updatedAt,
      this.bestComment,
      this.postedBy,
      this.anonymousJournal,
      this.mediaUrl,
      this.mediaType,
      this.aspectRatio,
      this.mediaHeight,
      this.mediaWidth,
      this.group});

  Journals.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    description = json['description'];
    likes = json['likes'];
    comments = json['comments'];
    isLiked = json['isLiked'];
    official = json['official'];
    likedBy = json['likedBy'] != null ? json['likedBy'].cast<String>() : null;
    // feelings = json['feelings'] != null
    //     ? new Feelings.fromJson(json['feelings'])
    //     : null;
    feelings = json['feelings'] != null
        ? (json['feelings'] as List).map((i) => Feelings.fromJson(i)).toList()
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    mediaHeight = json['mediaHeight'];
    mediaWidth = json['mediaWidth'];
    aspectRatio = json['aspectRatio'];
    // bestComment = json['bestComment'] != null
    //     ? new BestComment.fromJson(json['bestComment'])
    //     : null;
    postedBy = json['postedBy'] != null
        ? new PostedBy.fromJson(json['postedBy'])
        : null;
    anonymousJournal = json['anonymousJournal'];
    mediaUrl = json['mediaUrl'];
    mediaType = json['mediaType'];
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['likes'] = this.likes;
    data['comments'] = this.comments;
    data['isLiked'] = this.isLiked;
    data['likedBy'] = this.likedBy;
    data['official'] = this.official;
    //data['feelings'] = this.feelings;
    data['feelings'] = this.feelings != null
        ? this.feelings!.map((v) => v.toJson()).toList()
        : null;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['bestComment'] = this.bestComment;
    if (this.postedBy != null) {
      data['postedBy'] = this.postedBy!.toJson();
    }
    data['anonymousJournal'] = this.anonymousJournal;
    data['mediaUrl'] = this.mediaUrl;
    data['mediaType'] = this.mediaType;
    if (this.group != null) {
      data['group'] = this.group!.toJson();
    }
    return data;
  }
}

class Anonymous {
  String? sId;

  String? profilePicture;
  String? profilePictureType;
  String? userName;
  String? primaryAccount;

  Anonymous(
      {this.sId,
      this.profilePicture,
      this.profilePictureType,
      this.userName,
      this.primaryAccount});

  Anonymous.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];

    profilePicture = json['profilePicture'];
    profilePictureType = json['profilePictureType'];
    userName = json['userName'];
    primaryAccount = json['primaryAccount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;

    data['profilePicture'] = this.profilePicture;
    data['profilePictureType'] = this.profilePictureType;
    data['userName'] = this.userName;
    data['primaryAccount'] = this.primaryAccount;
    return data;
  }
}

class Group {
  String? sId;
  String? groupName;
  String? groupImage;

  Group({this.sId, this.groupName, this.groupImage});

  Group.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    groupName = json['groupName'];
    groupImage = json['groupMediaUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    return data;
  }
}

class PostedBy {
  String? sId;
  String? gender;
  String? status;
  List<List>? qualification;
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
  Anonymous? anonymous;
  bool? isProvider;

  PostedBy(
      {this.sId,
      this.gender,
      this.status,
      this.qualification,
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
      this.anonymous,
      this.isProvider});

  PostedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gender = json['gender'];
    status = json['status'];
    // if (json['qualification'] != null) {
    // 	qualification = <List>[];
    // 	json['qualification'].forEach((v) { qualification!.add(new List.fromJson(v)); });
    // }
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
    anonymous =
        json['anonymous'] != null || json['anonymous'].runtimeType == String
            ? new Anonymous.fromJson(json['anonymous'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['gender'] = this.gender;
    data['status'] = this.status;
    // if (this.qualification != null) {
    //   data['qualification'] = this.qualification!.map((v) => v.toJson()).toList();
    // }
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
    return data;
  }
}

class Qualification {
  Qualification();

  Qualification.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class Feelings {
  String? sId;
  String? feelingName;
  String? createdBy;
  int? iV;
  String? feelingType;

  Feelings(
      {this.sId, this.feelingName, this.createdBy, this.iV, this.feelingType});

  Feelings.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    feelingName = json['feelingName'];
    createdBy = json['createdBy'];
    iV = json['__v'];
    feelingType = json['feelingType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['feelingName'] = this.feelingName;
    data['createdBy'] = this.createdBy;
    data['__v'] = this.iV;
    data['feelingType'] = this.feelingType;
    return data;
  }
} */
