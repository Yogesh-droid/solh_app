class GetGroupResponseModel {
  bool? success;
  List<GroupList>? groupList;
  Pages? pages;

  GetGroupResponseModel({this.success, this.groupList, this.pages});

  GetGroupResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    pages = Pages.fromJson(json['pages']);
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
}

class GroupList {
  String? sId;
  String? groupName;
  String? groupMediaUrl;
  String? groupDescription;
  int? displayOrder;
  int? groupMembers;
  int? journalCount;

  GroupList(
      {this.sId,
      this.groupName,
      this.groupMediaUrl,
      this.groupDescription,
      this.displayOrder,
      this.groupMembers,
      this.journalCount});

  GroupList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    groupName = json['groupName'];
    groupMediaUrl = json['groupMediaUrl'];
    groupDescription = json['groupDescription'];
    displayOrder = json['displayOrder'];
    groupMembers = json['groupMembers'];
    journalCount = json['journalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['groupName'] = this.groupName;
    data['groupMediaUrl'] = this.groupMediaUrl;
    data['groupDescription'] = this.groupDescription;
    data['displayOrder'] = this.displayOrder;
    data['groupMembers'] = this.groupMembers;
    data['journalCount'] = this.journalCount;
    return data;
  }
}

class Pages {
  int? prev;
  int? next;
  Pages({this.next, this.prev});

  Pages.fromJson(Map<String, dynamic> json) {
    prev = json['prev'];
    next = json['next'];
  }
}
