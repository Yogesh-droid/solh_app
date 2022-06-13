// class JournalsResponseModel {
//   bool? success;
//   int? code;
//   Body? body;

//   JournalsResponseModel({this.success, this.code, this.body});

//   JournalsResponseModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     code = json['code'];
//     body = json['body'] != null ? new Body.fromJson(json['body']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['code'] = this.code;
//     if (this.body != null) {
//       data['body'] = this.body!.toJson();
//     }
//     return data;
//   }
// }

import 'package:solh/model/journals/get_jouranal_comment_model.dart';

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
      this.feelings,
      this.createdAt,
      this.updatedAt,
      this.bestComment,
      this.postedBy,
      this.anonymousJournal,
      this.mediaUrl,
      this.mediaType,
      this.group});

  Journals.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    description = json['description'];
    likes = json['likes'];
    comments = json['comments'];
    isLiked = json['isLiked'];
    likedBy = json['likedBy'] != null ? json['likedBy'].cast<String>() : null;
    // feelings = json['feelings'] != null
    //     ? new Feelings.fromJson(json['feelings'])
    //     : null;
    feelings = json['feelings'] != null
        ? (json['feelings'] as List).map((i) => Feelings.fromJson(i)).toList()
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
}
