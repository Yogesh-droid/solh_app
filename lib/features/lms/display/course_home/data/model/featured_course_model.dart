import 'package:solh/features/lms/display/course_home/domain/entities/featured_course_entity.dart';

class FeaturedCourseModel extends FeaturedCourseEntity {
  FeaturedCourseModel(
      {super.success, super.courseList, super.totalCourse, super.pagination});

  factory FeaturedCourseModel.fromJson(Map<String, dynamic> json) {
    return FeaturedCourseModel(
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
  TotalDuration? totalDuration;
  String? title;
  Instructor? instructor;
  String? thumbnail;
  int? price;
  String? currency;
  String? language;
  bool? isWishlisted;
  bool? inCart;
  int? afterDiscountPrice;
  double? rating;

  CourseList(
      {this.id,
      this.totalDuration,
      this.title,
      this.instructor,
      this.thumbnail,
      this.price,
      this.currency,
      this.language,
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
    instructor = json["instructor"] == null
        ? null
        : Instructor.fromJson(json["instructor"]);
    thumbnail = json["thumbnail"];
    price = json["price"];
    currency = json["currency"];
    language = json["language"];
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

class TotalDuration {
  int? hours;
  int? minutes;

  TotalDuration({this.hours, this.minutes});

  TotalDuration.fromJson(Map<String, dynamic> json) {
    hours = json["hours"];
    minutes = json["minutes"];
  }
}
