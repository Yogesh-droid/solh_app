import 'package:solh/features/lms/display/my_course_details/data/models/my_course_detail_model.dart';

class MyCourseDetailEntity {
  final bool? success;
  final List<SectionList>? sectionList;
  final String? userCertificate;

  MyCourseDetailEntity({this.success, this.sectionList, this.userCertificate});
}
