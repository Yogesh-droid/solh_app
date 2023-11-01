import 'package:solh/ui/screens/products/features/reviews/domain/entities/get_review_entity.dart';

class GetReviewModel extends GetReviewEntity {
  GetReviewModel(
      {bool? success,
      List<Reviews>? reviews,
      int? overAllRating,
      Pages? pages,
      int? totalReview})
      : super(
            overAllRating: overAllRating,
            pages: pages,
            reviews: reviews,
            success: success,
            totalReview: totalReview);

  factory GetReviewModel.fromJson(Map<String, dynamic> json) {
    return GetReviewModel(
      success: json["success"],
      reviews: json["reviews"] == null
          ? null
          : (json["reviews"] as List).map((e) => Reviews.fromJson(e)).toList(),
      overAllRating: json["overAllRating"],
      pages: json["pages"] == null ? null : Pages.fromJson(json["pages"]),
      totalReview: json["totalReview"],
    );
  }
}

class Pages {
  dynamic prev;
  dynamic next;

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
