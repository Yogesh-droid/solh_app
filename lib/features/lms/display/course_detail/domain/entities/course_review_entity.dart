import '../../data/models/course_review_model.dart';

class CourseReviewEntity {
  final bool? success;
  final List<Reviews>? reviews;
  final Pages? pages;
  final int? totalReview;

  CourseReviewEntity(
      {this.success, this.reviews, this.pages, this.totalReview});
}
