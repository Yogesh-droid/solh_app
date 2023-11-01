import '../../data/models/get_review_model.dart';

class GetReviewEntity {
  final bool? success;
  final List<Reviews>? reviews;
  final int? overAllRating;
  final Pages? pages;
  final int? totalReview;

  GetReviewEntity(
      {this.success,
      this.reviews,
      this.overAllRating,
      this.pages,
      this.totalReview});
}
