class GroupDetailModel {
  bool? success;
  GroupList? groupList;
  PagesForMember? pagesForMember;
  int? totalGroupMembers;
  bool? isUserPresent;
  GroupDetailModel(
      {this.success,
      this.groupList,
      this.pagesForMember,
      this.totalGroupMembers,
      this.isUserPresent});

  GroupDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    totalGroupMembers = json["totalGroupMembers"];
    isUserPresent = json['isUserPresent'];
    groupList = json['groupList'] != null
        ? new GroupList.fromJson(json['groupList'])
        : null;

    pagesForMember = json['pagesForMember'] != null
        ? new PagesForMember.fromJson(json['pagesForMember'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.groupList != null) {
      data['groupList'] = this.groupList!.toJson();
    }
    return data;
  }
}

class GroupList {
  String? sId;
  List<GroupMembers>? groupMembers;
  String? groupType;
  int? journalCount;
  String? groupName;
  String? groupDescription;
  String? groupMediaUrl;
  String? groupMediaType;
  List<DefaultAdmin>? defaultAdmin;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<String>? groupTags;
  bool? featured;
  String? groupStatus;
  List<AnonymousMembers>? anonymousMembers;
  int? displayOrder;

  GroupList(
      {this.sId,
      this.groupMembers,
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
      this.groupTags,
      this.featured,
      this.groupStatus,
      this.anonymousMembers,
      this.displayOrder});

  GroupList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['groupMembers'] != null) {
      groupMembers = <GroupMembers>[];
      json['groupMembers'].forEach((v) {
        groupMembers!.add(new GroupMembers.fromJson(v));
      });
    }
    groupType = json['groupType'];
    journalCount = json['journalCount'];
    groupName = json['groupName'];
    groupDescription = json['groupDescription'];
    groupMediaUrl = json['groupMediaUrl'];
    groupMediaType = json['groupMediaType'];
    if (json['defaultAdmin'] != null) {
      defaultAdmin = <DefaultAdmin>[];
      json['defaultAdmin'].forEach((v) {
        defaultAdmin!.add(new DefaultAdmin.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    groupTags = json['groupTags'].cast<String>();
    featured = json['featured'];
    groupStatus = json['groupStatus'];
    if (json['anonymousMembers'] != null) {
      anonymousMembers = <AnonymousMembers>[];
      json['anonymousMembers'].forEach((v) {
        anonymousMembers!.add(new AnonymousMembers.fromJson(v));
      });
    }
    displayOrder = json['displayOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.groupMembers != null) {
      data['groupMembers'] = this.groupMembers!.map((v) => v.toJson()).toList();
    }
    data['groupType'] = this.groupType;
    data['journalCount'] = this.journalCount;
    data['groupName'] = this.groupName;
    data['groupDescription'] = this.groupDescription;
    data['groupMediaUrl'] = this.groupMediaUrl;
    data['groupMediaType'] = this.groupMediaType;
    if (this.defaultAdmin != null) {
      data['defaultAdmin'] = this.defaultAdmin!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['groupTags'] = this.groupTags;
    data['featured'] = this.featured;
    data['groupStatus'] = this.groupStatus;
    if (this.anonymousMembers != null) {
      data['anonymousMembers'] =
          this.anonymousMembers!.map((v) => v.toJson()).toList();
    }
    data['displayOrder'] = this.displayOrder;
    return data;
  }
}

class GroupMembers {
  String? sId;
  String? profilePicture;
  String? uid;
  String? name;
  String? bio;

  GroupMembers({this.sId, this.profilePicture, this.uid, this.name, this.bio});

  GroupMembers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePicture = json['profilePicture'];
    uid = json['uid'];
    name = json['name'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profilePicture'] = this.profilePicture;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['bio'] = this.bio;
    return data;
  }
}

class AnonymousMembers {
  String? sId;
  String? userName;
  String? profilePicture;

  AnonymousMembers({this.sId, this.userName, this.profilePicture});

  AnonymousMembers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['profilePicture'] = this.profilePicture;
    return data;
  }
}

class DefaultAdmin {
  String? sId;
  String? profilePicture;
  String? uid;
  String? name;
  String? bio;

  DefaultAdmin({this.sId, this.profilePicture, this.uid, this.name, this.bio});

  DefaultAdmin.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePicture = json['profilePicture'];
    uid = json['uid'];

    name = json['name'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profilePicture'] = this.profilePicture;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['bio'] = this.bio;
    return data;
  }
}

class PagesForMember {
  int? prev;
  int? next;

  PagesForMember({this.prev, this.next});

  PagesForMember.fromJson(Map<String, dynamic> json) {
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}
