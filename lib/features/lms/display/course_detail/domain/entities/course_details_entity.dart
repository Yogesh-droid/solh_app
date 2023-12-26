import '../../data/models/course_details_model.dart';

class CourseDetailsEntity {
  final bool? success;
  final CourseDetail? courseDetail;
  final List<Sections>? sections;
  final int? totalSections;
  final List<Reviews>? reviews;
  final int? totalReviews;

  CourseDetailsEntity(
      {this.success,
      this.courseDetail,
      this.sections,
      this.totalSections,
      this.totalReviews,
      this.reviews});
}
