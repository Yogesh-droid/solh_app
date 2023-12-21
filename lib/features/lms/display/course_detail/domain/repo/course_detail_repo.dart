import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_detail/domain/entities/course_details_entity.dart';

abstract class CourseDetailRepo {
  Future<DataState<CourseDetailsEntity>> getCourseDetails(RequestParams params);
}
