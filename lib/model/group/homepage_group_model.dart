class HomepageGroupModel {
  bool? success;
  List<GroupList>? groupList;

  HomepageGroupModel({this.success, this.groupList});

  HomepageGroupModel.fromJson(Map<String, dynamic> json) {
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
}

class GroupList {
  String? sId;
  String? groupName;
  String? groupMediaUrl;
  String? groupDescription;
  int? displayOrder;
  bool? isUserJoined;
  int? groupMembers;
  int? journalCount;

  GroupList(
      {this.sId,
      this.groupName,
      this.groupMediaUrl,
      this.groupDescription,
      this.displayOrder,
      this.isUserJoined,
      this.groupMembers,
      this.journalCount});

  GroupList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    groupName = json['groupName'];
    groupMediaUrl = json['groupMediaUrl'];
    groupDescription = json['groupDescription'];
    displayOrder = json['displayOrder'];
    isUserJoined = json['isUserJoined'];
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
    data['isUserJoined'] = this.isUserJoined;
    data['groupMembers'] = this.groupMembers;
    data['journalCount'] = this.journalCount;
    return data;
  }
}
