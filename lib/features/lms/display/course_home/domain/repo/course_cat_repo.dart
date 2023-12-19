import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_home/domain/entities/course_cat_entity.dart';

abstract class CourseCatRepo {
  Future<DataState<CourseCatEntity>> getCourseCat(RequestParams params);
}
