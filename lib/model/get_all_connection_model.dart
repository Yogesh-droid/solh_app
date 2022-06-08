class GetConnectionResponse {
  bool? success;
  List<Connections>? connections;
  List<Group>? group;

  GetConnectionResponse({this.success, this.connections, this.group});

  GetConnectionResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['connections'] != null) {
      connections = <Connections>[];
      json['connections'].forEach((v) {
        connections!.add(new Connections.fromJson(v));
      });
    }
    if (json['group'] != null) {
      group = <Group>[];
      json['group'].forEach((v) {
        group!.add(new Group.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.connections != null) {
      data['connections'] = this.connections!.map((v) => v.toJson()).toList();
    }
    if (this.group != null) {
      data['group'] = this.group!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Group {
  String? groupName;
  String? groupDescription;
  String? groupId;
  String? inviteId;
  String? flag;
  Null? groupDetails;
  String? groupMediaUrl;

  Group(
      {this.groupName,
      this.groupDescription,
      this.groupId,
      this.inviteId,
      this.flag,
      this.groupDetails,
      this.groupMediaUrl});

  Group.fromJson(Map<String, dynamic> json) {
    groupName = json['groupName'];
    groupDescription = json['groupDescription'];
    groupId = json['group_id'];
    inviteId = json['invite_id'];
    flag = json['flag'];
    groupDetails = json['groupDetails'];
    groupMediaUrl = json['groupMediaUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupName'] = this.groupName;
    data['groupDescription'] = this.groupDescription;
    data['group_id'] = this.groupId;
    data['invite_id'] = this.inviteId;
    data['flag'] = this.flag;
    data['groupDetails'] = this.groupDetails;
    data['groupMediaUrl'] = this.groupMediaUrl;
    return data;
  }
}

class Connections {
  String? name;
  String? profilePicture;
  String? bio;
  String? sId;
  String? uId;
  String? connectionId;
  String? flag;

  Connections(
      {this.name,
      this.profilePicture,
      this.bio,
      this.sId,
      this.flag,
      this.uId,
      this.connectionId});

  Connections.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profilePicture = json['profilePicture'];
    bio = json['bio'];
    sId = json['user_id'];
    connectionId = json['connection_id'];
    flag = json['flag'];
    uId = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profilePicture'] = this.profilePicture;
    data['bio'] = this.bio;
    data['user_id'] = this.sId;
    data['connection_id'] = this.connectionId;
    data['flag'] = this.flag;
    data['uid'] = this.uId;
    return data;
  }
}
