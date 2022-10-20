class VideoTutorialModel {
  bool? success;
  List<TutorialList>? tutorialList;

  VideoTutorialModel({this.success, this.tutorialList});

  VideoTutorialModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['tutorialList'] != null) {
      tutorialList = <TutorialList>[];
      json['tutorialList'].forEach((v) {
        tutorialList!.add(new TutorialList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.tutorialList != null) {
      data['tutorialList'] = this.tutorialList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TutorialList {
  String? sId;
  String? videoType;
  String? status;
  String? title;
  String? description;
  String? videoThumbnail;
  String? videoUrl;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  int? iV;

  TutorialList(
      {this.sId,
      this.videoType,
      this.status,
      this.title,
      this.description,
      this.videoThumbnail,
      this.videoUrl,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.iV});

  TutorialList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    videoType = json['videoType'];
    status = json['status'];
    title = json['title'];
    description = json['description'];
    videoThumbnail = json['videoThumbnail'];
    videoUrl = json['videoUrl'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['videoType'] = this.videoType;
    data['status'] = this.status;
    data['title'] = this.title;
    data['description'] = this.description;
    data['videoThumbnail'] = this.videoThumbnail;
    data['videoUrl'] = this.videoUrl;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
