import 'package:solh/features/lms/display/course_detail/domain/entities/course_review_entity.dart';

class CourseReviewModel extends CourseReviewEntity {
  CourseReviewModel(
      {super.success, super.reviews, super.pages, super.totalReview});

  factory CourseReviewModel.fromJson(Map<String, dynamic> json) {
    return CourseReviewModel(
        success: json["success"],
        reviews: json["reviews"] == null
            ? null
            : (json["reviews"] as List)
                .map((e) => Reviews.fromJson(e))
                .toList(),
        pages: json["pages"] == null ? null : Pages.fromJson(json["pages"]),
        totalReview: json["totalReview"]);
  }
}

class Pages {
  int? prev;
  int? next;

  Pages({this.prev, this.next});

  Pages.fromJson(Map<String, dynamic> json) {
    prev = json["prev"];
    next = json["next"];
  }
}

class Reviews {
  String? id;
  String? review;
  int? rating;
  UserId? userId;

  Reviews({this.id, this.review, this.rating, this.userId});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    review = json["review"];
    rating = json["rating"];
    userId = json["userId"] == null ? null : UserId.fromJson(json["userId"]);
  }
}

class UserId {
  String? id;
  String? name;
  String? profilePicture;

  UserId({this.id, this.name, this.profilePicture});

  UserId.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    profilePicture = json["profilePicture"];
  }
}
