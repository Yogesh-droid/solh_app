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
  String? image;
  String? description;
  List<Hosts>? hosts;
  String? channelName;
  String? token;
  String? provider;
  String? sechudleAt;
  int? duration;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? appId;

  Webinar(
      {this.sId,
      this.title,
      this.image,
      this.description,
      this.hosts,
      this.channelName,
      this.token,
      this.provider,
      this.sechudleAt,
      this.duration,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.appId});

  Webinar.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    if (json['hosts'] != null) {
      hosts = <Hosts>[];
      json['hosts'].forEach((v) {
        hosts!.add(new Hosts.fromJson(v));
      });
    }
    channelName = json['channelName'];
    token = json['token'];
    provider = json['provider'];
    sechudleAt = json['sechudleAt'];
    duration = json['duration'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    appId = json['appId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['image'] = this.image;
    data['description'] = this.description;
    if (this.hosts != null) {
      data['hosts'] = this.hosts!.map((v) => v.toJson()).toList();
    }
    data['channelName'] = this.channelName;
    data['token'] = this.token;
    data['provider'] = this.provider;
    data['sechudleAt'] = this.sechudleAt;
    data['duration'] = this.duration;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['appId'] = this.appId;
    return data;
  }
}

class Hosts {
  String? sId;
  String? profilePicture;
  String? mobile;
  String? name;

  Hosts({this.sId, this.profilePicture, this.mobile, this.name});

  Hosts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePicture = json['profilePicture'];
    mobile = json['mobile'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profilePicture'] = this.profilePicture;
    data['mobile'] = this.mobile;
    data['name'] = this.name;
    return data;
  }
}
