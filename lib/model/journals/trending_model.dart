class TrendingModel {
  bool? success;
  List<TrendingData>? trendingData;

  TrendingModel({this.success, this.trendingData});

  TrendingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['trendingData'] != null) {
      trendingData = <TrendingData>[];
      json['trendingData'].forEach((v) {
        trendingData!.add(new TrendingData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.trendingData != null) {
      data['trendingData'] = this.trendingData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TrendingData {
  String? sId;
  String? description;
  String? mediaUrl;
  String? mediaType;
  String? aspectRatio;
  String? mediaHeight;
  String? mediaWidth;
  bool? anonymousJournal;
  String? createdAt;
  int? sortOrder;
  bool? isOfficial;
  PostedBy? postedBy;
  Group? group;

  TrendingData(
      {this.sId,
      this.description,
      this.mediaUrl,
      this.mediaType,
      this.aspectRatio,
      this.mediaHeight,
      this.mediaWidth,
      this.anonymousJournal,
      this.createdAt,
      this.sortOrder,
      this.isOfficial,
      this.postedBy,
      this.group});

  TrendingData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    mediaUrl = json['mediaUrl'];
    mediaType = json['mediaType'];
    aspectRatio = json['aspectRatio'];
    mediaHeight = json['mediaHeight'];
    mediaWidth = json['mediaWidth'];
    anonymousJournal = json['anonymousJournal'];
    createdAt = json['createdAt'];
    sortOrder = json['sort_order'];
    isOfficial = json['isOfficial'];
    postedBy = json['postedBy'] != null
        ? new PostedBy.fromJson(json['postedBy'])
        : null;
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['description'] = this.description;
    data['mediaUrl'] = this.mediaUrl;
    data['mediaType'] = this.mediaType;
    data['aspectRatio'] = this.aspectRatio;
    data['mediaHeight'] = this.mediaHeight;
    data['mediaWidth'] = this.mediaWidth;
    data['anonymousJournal'] = this.anonymousJournal;
    data['createdAt'] = this.createdAt;
    data['sort_order'] = this.sortOrder;
    data['isOfficial'] = this.isOfficial;
    if (this.postedBy != null) {
      data['postedBy'] = this.postedBy!.toJson();
    }
    if (this.group != null) {
      data['group'] = this.group!.toJson();
    }
    return data;
  }
}

class PostedBy {
  String? sId;
  String? profilePicture;
  String? userName;
  String? name;
  Anonymous? anonymous;

  PostedBy(
      {this.sId,
      this.profilePicture,
      this.userName,
      this.name,
      this.anonymous});

  PostedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePicture = json['profilePicture'];
    userName = json['userName'];
    name = json['name'];
    anonymous = json['anonymous'] != null
        ? new Anonymous.fromJson(json['anonymous'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profilePicture'] = this.profilePicture;
    data['userName'] = this.userName;
    data['name'] = this.name;
    if (this.anonymous != null) {
      data['anonymous'] = this.anonymous!.toJson();
    }
    return data;
  }
}

class Anonymous {
  String? sId;
  String? userName;
  String? profilePicture;

  Anonymous({this.sId, this.userName, this.profilePicture});

  Anonymous.fromJson(Map<String, dynamic> json) {
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

class Group {
  String? sId;
  String? groupName;
  String? groupMediaUrl;

  Group({this.sId, this.groupName, this.groupMediaUrl});

  Group.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    groupName = json['groupName'];
    groupMediaUrl = json['groupMediaUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['groupName'] = this.groupName;
    data['groupMediaUrl'] = this.groupMediaUrl;
    return data;
  }
}
