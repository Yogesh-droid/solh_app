class LiveStreamForUserModel {
  bool? success;
  Webinar? webinar;

  LiveStreamForUserModel({this.success, this.webinar});

  LiveStreamForUserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    webinar =
        json['webinar'] != null ? new Webinar.fromJson(json['webinar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.webinar != null) {
      data['webinar'] = this.webinar!.toJson();
    }
    return data;
  }
}

class Webinar {
  String? sId;
  String? title;
  String? description;
  Host? host;
  List<OtherHost>? otherHost;
  String? channelName;
  String? token;
  String? provider;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? appId;

  Webinar(
      {this.sId,
      this.title,
      this.description,
      this.host,
      this.otherHost,
      this.channelName,
      this.token,
      this.provider,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.appId,
      this.iV});

  Webinar.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    host = json['host'] != null ? new Host.fromJson(json['host']) : null;
    if (json['otherHost'] != null) {
      otherHost = <OtherHost>[];
      json['otherHost'].forEach((v) {
        otherHost!.add(new OtherHost.fromJson(v));
      });
    }
    channelName = json['channelName'];
    appId = json['appId'];
    token = json['token'];
    provider = json['provider'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.host != null) {
      data['host'] = this.host!.toJson();
    }
    if (this.otherHost != null) {
      data['otherHost'] = this.otherHost!.map((v) => v.toJson()).toList();
    }
    data['channelName'] = this.channelName;
    data['token'] = this.token;
    data['provider'] = this.provider;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Host {
  String? sId;
  String? name;
  String? id;
  String? profilePicture;

  Host({this.sId, this.name, this.id, this.profilePicture});

  Host.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    id = json['id'];
    profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class OtherHost {
  String? sId;
  String? name;
  String? id;
  String? profilePicture;

  OtherHost({this.sId, this.name, this.id, this.profilePicture});

  OtherHost.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    id = json['id'];
    profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
