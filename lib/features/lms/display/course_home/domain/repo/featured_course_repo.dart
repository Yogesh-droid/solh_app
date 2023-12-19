import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_home/domain/entities/featured_course_entity.dart';

abstract class FeaturedCourseRepo {
  Future<DataState<FeaturedCourseEntity>> getFeaturedCourse(
      RequestParams params);
}
