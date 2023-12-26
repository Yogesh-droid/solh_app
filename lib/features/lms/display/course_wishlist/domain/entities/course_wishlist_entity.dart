import 'package:solh/features/lms/display/course_wishlist/data/models/course_wishlist_model.dart';

class CourseWishlistEntity {
  String? sId;
  String? userId;
  List<Courses>? courses;
  String? type;

  CourseWishlistEntity({this.courses, this.sId, this.type, this.userId});
}
