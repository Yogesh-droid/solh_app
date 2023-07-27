class NotificationModel {
  bool? success;
  List<NotificationList>? notificationList;

  NotificationModel({this.success, this.notificationList});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['notificationList'] != null) {
      notificationList = <NotificationList>[];
      json['notificationList'].forEach((v) {
        notificationList!.add(new NotificationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.notificationList != null) {
      data['notificationList'] =
          this.notificationList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationList {
  String? sId;
  // List<String>? userIds;
  String? routeContent;
  SenderId? senderId;
  String? status;
  String? content;
  String? routeData;
  String? createdAt;
  String? updatedAt;
  int? iV;

  NotificationList(
      {this.sId,
      // this.userIds,
      this.routeContent,
      this.senderId,
      this.status,
      this.content,
      this.routeData,
      this.createdAt,
      this.updatedAt,
      this.iV});

  NotificationList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    // userIds = json['user_ids'].cast<String>();
    routeContent = json['routeContent'];
    senderId = json['senderId'] != null
        ? new SenderId.fromJson(json['senderId'])
        : null;
    status = json['status'];
    content = json['content'];
    routeData = json['routeData'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    // data['user_ids'] = this.userIds;
    data['routeContent'] = this.routeContent;
    if (this.senderId != null) {
      data['senderId'] = this.senderId!.toJson();
    }
    data['status'] = this.status;
    data['content'] = this.content;
    data['routeData'] = this.routeData;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class SenderId {
  String? sId;
  String? profilePicture;
  String? userName;
  String? name;
  String? id;

  SenderId({this.sId, this.profilePicture, this.userName, this.name, this.id});

  SenderId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePicture = json['profilePicture'];
    userName = json['userName'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profilePicture'] = this.profilePicture;
    data['userName'] = this.userName;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
