class MyCoursesModel {
  bool? success;
  List<MyCourseList>? myCourseList;

  MyCoursesModel({this.success, this.myCourseList});

  MyCoursesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['myCourseList'] != null) {
      myCourseList = <MyCourseList>[];
      json['myCourseList'].forEach((v) {
        myCourseList!.add(MyCourseList.fromJson(v));
      });
    }
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
  String? totalDuration;
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
    totalDuration = json['totalDuration'];
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
