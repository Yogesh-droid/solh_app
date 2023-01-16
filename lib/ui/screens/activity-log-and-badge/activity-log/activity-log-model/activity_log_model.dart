class ActivityLogModel {
  bool? success;
  Result? result;

  ActivityLogModel({this.success, this.result});

  ActivityLogModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  Next? next;
  List<ActivityLog>? activityLog;
  int? psychologicalCapital;

  Result({this.next, this.activityLog, this.psychologicalCapital});

  Result.fromJson(Map<String, dynamic> json) {
    next = json['next'] != null ? new Next.fromJson(json['next']) : null;
    psychologicalCapital = json['psychologicalCapital'];

    if (json['activityLog'] != null) {
      activityLog = <ActivityLog>[];
      json['activityLog'].forEach((v) {
        activityLog!.add(new ActivityLog.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.next != null) {
      data['next'] = this.next!.toJson();
    }
    if (this.activityLog != null) {
      data['activityLog'] = this.activityLog!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Next {
  int? pageNumber;
  int? limit;

  Next({this.pageNumber, this.limit});

  Next.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNumber'] = this.pageNumber;
    data['limit'] = this.limit;
    return data;
  }
}

class ActivityLog {
  String? sId;
  String? user;
  String? activityType;
  String? content;
  String? subContent;
  String? contentId;
  bool? anonymously;
  int? createdAt;
  int? activityPoints;

  ActivityLog(
      {this.sId,
      this.user,
      this.activityType,
      this.content,
      this.subContent,
      this.contentId,
      this.anonymously,
      this.activityPoints,
      this.createdAt});

  ActivityLog.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    activityType = json['activityType'];
    activityPoints = json['activityPoints'];
    content = json['content'];
    subContent = json['subContent'];
    contentId = json['contentId'];
    anonymously = json['anonymously'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['activityType'] = this.activityType;
    data['content'] = this.content;
    data['subContent'] = this.subContent;
    data['contentId'] = this.contentId;
    data['anonymously'] = this.anonymously;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
