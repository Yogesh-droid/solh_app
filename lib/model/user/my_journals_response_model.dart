class MyJournalsResponseModel {
  bool? success;
  int? code;
  Body? body;

  MyJournalsResponseModel({this.success, this.code, this.body});

  MyJournalsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    return data;
  }
}

class Body {
  List<Journals>? journals;
  int? totalPages;
  int? totalJournals;

  Body({this.journals, this.totalPages, this.totalJournals});

  Body.fromJson(Map<String, dynamic> json) {
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
  String? description;
  String? journalType;
  bool? isLiked;
  List<String>? likedBy;
  String? mediaUrl;
  String? mediaType;
  PostedBy? postedBy;
  int? likes;
  int? comments;
  String? feelings;
  String? createdAt;
  Null bestComment;

  Journals(
      {this.description,
      this.journalType,
      this.isLiked,
      this.likedBy,
      this.mediaUrl,
      this.mediaType,
      this.postedBy,
      this.likes,
      this.comments,
      this.feelings,
      this.createdAt,
      this.bestComment});

  Journals.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    journalType = json['journalType'];
    isLiked = json['isLiked'];
    likedBy = json['likedBy'].cast<String>();
    mediaUrl = json['mediaUrl'];
    mediaType = json['mediaType'];
    postedBy = json['postedBy'] != null
        ? new PostedBy.fromJson(json['postedBy'])
        : null;
    likes = json['likes'];
    comments = json['comments'];
    feelings = json['feelings'];
    createdAt = json['createdAt'];
    bestComment = json['bestComment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['journalType'] = this.journalType;
    data['isLiked'] = this.isLiked;
    data['likedBy'] = this.likedBy;
    data['mediaUrl'] = this.mediaUrl;
    data['mediaType'] = this.mediaType;
    if (this.postedBy != null) {
      data['postedBy'] = this.postedBy!.toJson();
    }
    data['likes'] = this.likes;
    data['comments'] = this.comments;
    data['feelings'] = this.feelings;
    data['createdAt'] = this.createdAt;
    data['bestComment'] = this.bestComment;
    return data;
  }
}

class PostedBy {
  String? sId;
  String? gender;
  String? status;
  List<Null>? qualification;
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
      this.lastName});

  PostedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gender = json['gender'];
    status = json['status'];
    // if (json['qualification'] != null) {
    //   qualification = <Null>[];
    //   json['qualification'].forEach((v) {
    //     qualification!.add(new Null.fromJson(v));
    //   });
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['gender'] = this.gender;
    data['status'] = this.status;
    // if (this.qualification != null) {
    //   data['qualification'] =
    //       this.qualification!.map((v) => v.toJson()).toList();
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
    return data;
  }
}
