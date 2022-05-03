// class GetJouranalsCommentModel {
//   bool? success;
//   int? code;
//   Body? body;

//   GetJouranalsCommentModel({this.success, this.code, this.body});

//   GetJouranalsCommentModel.fromJson(Map<String, dynamic> json) {
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

class GetJouranalsCommentModel {
  List<Comments>? comments;
  BestComment? bestComment;
  int? totalComments;
  int? totalPages;

  GetJouranalsCommentModel(
      {this.comments, this.bestComment, this.totalComments, this.totalPages});

  GetJouranalsCommentModel.fromJson(Map<String, dynamic> json) {
    bestComment = json['bestComment'] != null
        ? new BestComment.fromJson(json['bestComment'])
        : null;
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    totalComments = json['totalComments'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bestComment != null) {
      data['bestComment'] = this.bestComment!.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    data['totalComments'] = this.totalComments;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class Comments {
  String? sId;
  String? commentBody;
  String? commentOn;
  String? commentUser;
  String? commentBy;
  String? commentDate;
  String? commentTime;
  int? likes;
  List<int>? likedBy;
  int? replyNum;
  String? parentId;
  String? createdAt;
  String? updatedAt;
  ReplyTo? replyTo;
  int? iV;
  List<User>? user;

  Comments(
      {this.sId,
      this.commentBody,
      this.commentOn,
      this.commentUser,
      this.commentBy,
      this.commentDate,
      this.commentTime,
      this.likes,
      this.likedBy,
      this.replyNum,
      this.parentId,
      this.createdAt,
      this.updatedAt,
      this.replyTo,
      this.iV,
      this.user});

  Comments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    commentBody = json['commentBody'];
    commentOn = json['commentOn'];
    commentUser = json['commentUser'];
    commentBy = json['commentBy'];
    commentDate = json['commentDate'];
    commentTime = json['commentTime'];
    likes = json['likes'];
    if (json['likedBy'] != null) {
      likedBy = <int>[];
      json['likedBy'].forEach((v) {
        likedBy!.add(v);
      });
    }
    replyNum = json['replyNum'];
    parentId = json['parentId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    replyTo =
        json['replyTo'] != null ? new ReplyTo.fromJson(json['replyTo']) : null;
    iV = json['__v'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['commentBody'] = this.commentBody;
    data['commentOn'] = this.commentOn;
    data['commentUser'] = this.commentUser;
    data['commentBy'] = this.commentBy;
    data['commentDate'] = this.commentDate;
    data['commentTime'] = this.commentTime;
    data['likes'] = this.likes;
    // if (this.likedBy != null) {
    //   data['likedBy'] = this.likedBy!.map((v) => v.toJson()).toList();
    // }
    data['replyNum'] = this.replyNum;
    data['parentId'] = this.parentId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.replyTo != null) {
      data['replyTo'] = this.replyTo!.toJson();
    }
    data['__v'] = this.iV;
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReplyTo {
  String? sId;
  String? uid;
  String? name;
  String? id;

  ReplyTo({this.sId, this.uid, this.name, this.id});

  ReplyTo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    uid = json['uid'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class BestComment {
  String? sId;
  String? commentBody;
  String? commentOn;
  String? commentUser;
  String? commentBy;
  String? commentDate;
  String? commentTime;
  int? likes;
  List<int>? likedBy;
  String? parentId;
  int? replyNum;
  String? createdAt;
  String? updatedAt;
  List<User>? user;

  BestComment(
      {this.sId,
      this.commentBody,
      this.commentOn,
      this.commentUser,
      this.commentBy,
      this.commentDate,
      this.commentTime,
      this.likes,
      this.likedBy,
      this.parentId,
      this.replyNum,
      this.createdAt,
      this.updatedAt,
      this.user});

  BestComment.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    commentBody = json['commentBody'];
    commentOn = json['commentOn'];
    commentUser = json['commentUser'];
    commentBy = json['commentBy'];
    commentDate = json['commentDate'];
    commentTime = json['commentTime'];
    likes = json['likes'];
    if (json['likedBy'] != null) {
      likedBy = <int>[];
      json['likedBy'].forEach((v) {
        likedBy!.add(v);
      });
    }
    parentId = json['parentId'];
    replyNum = json['replyNum'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['commentBody'] = this.commentBody;
    data['commentOn'] = this.commentOn;
    data['commentUser'] = this.commentUser;
    data['commentBy'] = this.commentBy;
    data['commentDate'] = this.commentDate;
    data['commentTime'] = this.commentTime;
    data['likes'] = this.likes;
    // if (this.likedBy != null) {
    //   data['likedBy'] = this.likedBy!.map((v) => v.toJson()).toList();
    // }
    data['parentId'] = this.parentId;
    data['replyNum'] = this.replyNum;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
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
  String? updatedAt;
  int? iV;
  String? lastName;

  User(
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
      this.updatedAt,
      this.iV,
      this.lastName});

  User.fromJson(Map<String, dynamic> json) {
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
    data['last_name'] = this.lastName;
    return data;
  }
}
