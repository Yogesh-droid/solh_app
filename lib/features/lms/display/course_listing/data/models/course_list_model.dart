import 'package:solh/features/lms/display/course_listing/domain/entities/course_list_entity.dart';

import '../../../course_home/data/model/featured_course_model.dart';

class CourseListModel extends CourseListEntity {
  CourseListModel(
      {super.success, super.courseList, super.totalCourse, super.pagination});

  factory CourseListModel.fromJson(Map<String, dynamic> json) {
    return CourseListModel(
        success: json["success"],
        courseList: json["courseList"] == null
            ? null
            : (json["courseList"] as List)
                .map((e) => CourseList.fromJson(e))
                .toList(),
        totalCourse: json["totalCourse"],
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]));
  }
}

class Pagination {
  dynamic prev;
  dynamic next;

  Pagination({this.prev, this.next});

  Pagination.fromJson(Map<String, dynamic> json) {
    prev = json["prev"];
    next = json["next"];
  }
}

class CourseList {
  String? id;
  String? title;
  TotalDuration? totalDuration;
  String? subTitle;
  Instructor? instructor;
  String? thumbnail;
  int? price;
  String? currency;
  bool? isWishlisted;
  bool? inCart;
  int? afterDiscountPrice;
  double? rating;

  CourseList(
      {this.id,
      this.totalDuration,
      this.title,
      this.subTitle,
      this.instructor,
      this.thumbnail,
      this.price,
      this.currency,
      this.isWishlisted,
      this.afterDiscountPrice,
      this.rating,
      this.inCart});

  CourseList.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    totalDuration = json["totalDuration"] == null
        ? null
        : TotalDuration.fromJson(json["totalDuration"]);
    title = json["title"];
    subTitle = json["subTitle"];
    instructor = json["instructor"] == null
        ? null
        : Instructor.fromJson(json["instructor"]);
    thumbnail = json["thumbnail"];
    price = json["price"];
    currency = json["currency"];
    isWishlisted = json["isWishlisted"];
    inCart = json["inCart"];
    afterDiscountPrice = json['salePrice'];
    rating = json['rating'];
  }
}

class Instructor {
  String? id;
  String? name;

  Instructor({this.id, this.name});

  Instructor.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
  }
}
