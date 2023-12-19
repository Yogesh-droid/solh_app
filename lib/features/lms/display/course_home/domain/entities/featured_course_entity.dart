import '../../data/model/featured_course_model.dart';

class FeaturedCourseEntity {
  final bool? success;
  final List<CourseList>? courseList;
  final int? totalCourse;
  final Pagination? pagination;

  FeaturedCourseEntity(
      {this.success, this.courseList, this.totalCourse, this.pagination});
}
