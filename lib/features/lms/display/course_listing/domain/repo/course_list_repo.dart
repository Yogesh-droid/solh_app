import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_listing/domain/entities/course_list_entity.dart';

abstract class CourseListRepo {
  Future<DataState<CourseListEntity>> getCourseList(
      RequestParams requestParams);
}
