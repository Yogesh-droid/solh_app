class VideoPlaylistModel {
  bool? success;
  List<TutorialCategoryList>? tutorialCategoryList;

  VideoPlaylistModel({this.success, this.tutorialCategoryList});

  VideoPlaylistModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['tutorialCategoryList'] != null) {
      tutorialCategoryList = <TutorialCategoryList>[];
      json['tutorialCategoryList'].forEach((v) {
        tutorialCategoryList!.add(new TutorialCategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.tutorialCategoryList != null) {
      data['tutorialCategoryList'] =
          this.tutorialCategoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TutorialCategoryList {
  String? sId;
  String? status;
  String? title;
  String? description;
  String? videoThumbnail;
  String? createdAt;
  String? updatedAt;
  int? iV;

  TutorialCategoryList(
      {this.sId,
      this.status,
      this.title,
      this.description,
      this.videoThumbnail,
      this.createdAt,
      this.updatedAt,
      this.iV});

  TutorialCategoryList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    title = json['title'];
    description = json['description'];
    videoThumbnail = json['videoThumbnail'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['status'] = this.status;
    data['title'] = this.title;
    data['description'] = this.description;
    data['videoThumbnail'] = this.videoThumbnail;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
