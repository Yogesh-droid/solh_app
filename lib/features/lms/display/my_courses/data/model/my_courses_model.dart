class MyCoursesModel {
  bool? success;
  List<MyCourseList>? myCourseList;
  Pages? pages;

  MyCoursesModel({this.success, this.myCourseList});

  MyCoursesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['myCourseList'] != null) {
      myCourseList = <MyCourseList>[];
      json['myCourseList'].forEach((v) {
        myCourseList!.add(MyCourseList.fromJson(v));
      });
    }

    pages = json['pages'] != null ? Pages.fromJson(json['pages']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (myCourseList != null) {
      data['myCourseList'] = myCourseList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyCourseList {
  String? sId;
  String? courseId;
  String? courseName;
  String? image;
  TotalDuration? totalDuration;
  int? progressStatus;

  MyCourseList(
      {this.sId,
      this.courseId,
      this.courseName,
      this.image,
      this.totalDuration,
      this.progressStatus});

  MyCourseList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    courseId = json['courseId'];
    courseName = json['courseName'];
    image = json['image'];
    totalDuration = json['totalDuration'] != null
        ? TotalDuration.fromJson(json['totalDuration'])
        : null;
    progressStatus = json['progressStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['courseId'] = courseId;
    data['courseName'] = courseName;
    data['image'] = image;
    data['totalDuration'] = totalDuration;
    data['progressStatus'] = progressStatus;
    return data;
  }
}

class TotalDuration {
  int? hours;
  int? minutes;

  TotalDuration({this.hours, this.minutes});

  TotalDuration.fromJson(Map<String, dynamic> json) {
    hours = json['hours'];
    minutes = json['minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hours'] = this.hours;
    data['minutes'] = this.minutes;
    return data;
  }
}

class Pages {
  int? prev;
  int? next;

  Pages({this.prev, this.next});

  Pages.fromJson(Map<String, dynamic> json) {
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['prev'] = prev;
    data['next'] = next;
    return data;
  }
}
