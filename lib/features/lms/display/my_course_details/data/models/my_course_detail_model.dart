import 'package:solh/features/lms/display/course_detail/data/models/course_details_model.dart';
import 'package:solh/features/lms/display/my_course_details/domain/entities/my_course_detail_entity.dart';

class MyCourseDetailModel extends MyCourseDetailEntity {
  MyCourseDetailModel({super.success, super.sectionList});

  factory MyCourseDetailModel.fromJson(Map<String, dynamic> json) {
    return MyCourseDetailModel(
        success: json["success"],
        sectionList: json["sectionList"] == null
            ? null
            : (json["sectionList"] as List)
                .map((e) => SectionList.fromJson(e))
                .toList());
  }
}

class SectionList {
  String? id;
  String? title;
  String? course;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? v;
  TotalDuration? duration;
  bool? freePreview;
  String? content;
  List<Lectures>? lectures;
  int? progressStatus;

  SectionList(
      {this.id,
      this.title,
      this.course,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.duration,
      this.freePreview,
      this.content,
      this.lectures,
      this.progressStatus});

  SectionList.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    title = json["title"];
    course = json["course"];
    status = json["status"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
    duration = json["duration"] == null
        ? null
        : TotalDuration.fromJson(json["duration"]);
    freePreview = json["freePreview"];
    content = json["content"];
    lectures = json["lectures"] == null
        ? null
        : (json["lectures"] as List).map((e) => Lectures.fromJson(e)).toList();
    progressStatus = json["progressStatus"];
  }
}

class Lectures {
  String? id;
  TotalDuration? duration;
  ContentData? contentData;
  String? title;
  String? contentType;
  List<dynamic>? faq;
  List<dynamic>? quiz;
  List<dynamic>? supportMaterial;
  bool? isDone;

  Lectures(
      {this.id,
      this.duration,
      this.contentData,
      this.title,
      this.contentType,
      this.faq,
      this.quiz,
      this.supportMaterial,
      this.isDone});

  Lectures.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    duration = json["duration"] == null
        ? null
        : TotalDuration.fromJson(json["duration"]);
    contentData = json["contentData"] == null
        ? null
        : ContentData.fromJson(json["contentData"]);
    title = json["title"];
    contentType = json["contentType"];
    faq = json["faq"] ?? [];
    quiz = json["quiz"] ?? [];
    supportMaterial = json["supportMaterial"] ?? [];
    isDone = json["isDone"];
  }
}

class ContentData {
  String? data;
  bool? isDownloadable;

  ContentData({this.data, this.isDownloadable});

  ContentData.fromJson(Map<String, dynamic> json) {
    data = json["data"];
    isDownloadable = json["isDownloadable"];
  }
}
