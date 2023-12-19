import '../../data/models/course_list_model.dart';

class CourseListEntity {
  final bool? success;
  final List<CourseList>? courseList;
  final int? totalCourse;
  final Pagination? pagination;

  CourseListEntity(
      {this.success, this.courseList, this.totalCourse, this.pagination});
}
