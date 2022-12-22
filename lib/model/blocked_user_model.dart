class BlockedUserModel {
  bool? success;
  List<BlockedUsers>? blockedUsers;

  BlockedUserModel({this.success, this.blockedUsers});

  BlockedUserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['blockedUsers'] != null) {
      blockedUsers = <BlockedUsers>[];
      json['blockedUsers'].forEach((v) {
        blockedUsers!.add(new BlockedUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.blockedUsers != null) {
      data['blockedUsers'] = this.blockedUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BlockedUsers {
  String? sId;
  BlockedUser? blockedUser;

  BlockedUsers({this.sId, this.blockedUser});

  BlockedUsers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    blockedUser = json['blockedUser'] != null
        ? new BlockedUser.fromJson(json['blockedUser'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.blockedUser != null) {
      data['blockedUser'] = this.blockedUser!.toJson();
    }
    return data;
  }
}

class BlockedUser {
  String? sId;
  String? profilePicture;
  String? uid;
  String? name;
  String? id;

  BlockedUser({this.sId, this.profilePicture, this.uid, this.name, this.id});

  BlockedUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePicture = json['profilePicture'];
    uid = json['uid'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profilePicture'] = this.profilePicture;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
