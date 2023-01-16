class GetGroupResponseModel {
  bool? success;
  List<GroupList>? groupList;

  GetGroupResponseModel({this.success, this.groupList});

  GetGroupResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['groupList'] != null) {
      groupList = <GroupList>[];
      json['groupList'].forEach((v) {
        groupList!.add(new GroupList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.groupList != null) {
      data['groupList'] = this.groupList!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  void forEach(Null Function(dynamic element) param0) {}
}

class GroupList {
  String? sId;
  List<GroupMembers>? groupMembers;
  String? groupType;
  String? groupName;
  String? groupDescription;
  List<GroupMembers>? defaultAdmin;
  List<AnonymousMembers>? anonymousMembers;
  int? journalCount;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? id;
  String? groupMediaUrl;
  String? groupMediaType;
  List<String>? groupTags;

  GroupList(
      {this.sId,
      this.groupMembers,
      this.groupType,
      this.groupName,
      this.groupDescription,
      this.journalCount,
      this.defaultAdmin,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.id,
      this.groupMediaUrl,
      this.groupMediaType,
      this.anonymousMembers,
      this.groupTags});

  GroupList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['groupMembers'] != null) {
      groupMembers = <GroupMembers>[];
      json['groupMembers'].forEach((v) {
        groupMembers!.add(new GroupMembers.fromJson(v));
      });
    }

    if (json['anonymousMembers'] != null) {
      anonymousMembers = <AnonymousMembers>[];
      json['anonymousMembers'].forEach((v) {
        anonymousMembers!.add(new AnonymousMembers.fromJson((v)));
      });
    }
    groupType = json['groupType'];
    groupName = json['groupName'];
    groupDescription = json['groupDescription'];
    // defaultAdmin = json['defaultAdmin'] != null
    //     ? new GroupMembers.fromJson(json['defaultAdmin'])
    //     : null;
    if (json['defaultAdmin'] != null) {
      defaultAdmin = <GroupMembers>[];
      json['defaultAdmin'].forEach((v) {
        defaultAdmin!.add(new GroupMembers.fromJson(v));
      });
    }
    journalCount = json['journalCount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    id = json['id'];
    groupMediaUrl = json['groupMediaUrl'];
    groupMediaType = json['groupMediaType'];
    if (json['groupTags'] != null) {
      groupTags = <String>[];
      json['groupTags'].forEach((v) {
        groupTags!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.groupMembers != null) {
      data['groupMembers'] = this.groupMembers!.map((v) => v.toJson()).toList();
    }
    data['groupType'] = this.groupType;
    data['groupName'] = this.groupName;
    data['groupDescription'] = this.groupDescription;
    if (this.defaultAdmin != null) {
      data['defaultAdmin'] = this.defaultAdmin!.map((v) => v.toJson()).toList();
    }
    data['journalCount'] = this.journalCount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['id'] = this.id;
    data['groupMediaUrl'] = this.groupMediaUrl;
    data['groupMediaType'] = this.groupMediaType;
    if (this.groupTags != null) {
      data['groupTags'] = this.groupTags;
    }
    return data;
  }
}

class GroupMembers {
  String? sId;
  String? profilePicture;
  String? uid;
  String? name;
  String? bio;
  String? id;

  GroupMembers(
      {this.sId, this.profilePicture, this.uid, this.name, this.bio, this.id});

  GroupMembers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePicture = json['profilePicture'];
    uid = json['uid'];
    name = json['name'];
    bio = json['bio'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profilePicture'] = this.profilePicture;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['bio'] = this.bio;
    data['id'] = this.id;
    return data;
  }
}

class AnonymousMembers {
  String? userName;
  String? sId;
  String? profilePicture;

  AnonymousMembers(this.sId, this.profilePicture, this.userName);

  AnonymousMembers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePicture = json['profilePicture'];
    userName = json['userName'];
  }
}
