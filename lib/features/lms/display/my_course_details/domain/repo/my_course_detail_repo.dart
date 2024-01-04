import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/my_course_details/domain/entities/my_course_detail_entity.dart';

abstract class MyCourseDetailRepo {
  Future<DataState<MyCourseDetailEntity>> getMyCourseDetail(
      RequestParams params);
}
