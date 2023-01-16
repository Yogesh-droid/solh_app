class LikedUsersListModel {
  bool? success;
  Result? result;

  LikedUsersListModel({this.success, this.result});

  LikedUsersListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  List<Data>? data;

  Result({this.data});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  User? user;
  Reaction? reaction;

  Data({this.user, this.reaction});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    reaction = json['reaction'] != null
        ? new Reaction.fromJson(json['reaction'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.reaction != null) {
      data['reaction'] = this.reaction!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? status;
  String? name;
  String? profilePicture;
  String? uid;
  String? userName;
  String? id;

  User(
      {this.sId,
      this.status,
      this.name,
      this.profilePicture,
      this.uid,
      this.userName,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    name = json['name'];
    profilePicture = json['profilePicture'];
    uid = json['uid'];
    userName = json['userName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['status'] = this.status;
    data['name'] = this.name;
    data['profilePicture'] = this.profilePicture;
    data['uid'] = this.uid;
    data['userName'] = this.userName;
    data['id'] = this.id;
    return data;
  }
}

class Reaction {
  String? sId;
  String? status;
  String? reactionName;
  String? reactionImage;

  Reaction({this.sId, this.status, this.reactionName, this.reactionImage});

  Reaction.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    reactionName = json['reactionName'];
    reactionImage = json['reactionImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['status'] = this.status;
    data['reactionName'] = this.reactionName;
    data['reactionImage'] = this.reactionImage;
    return data;
  }
}
