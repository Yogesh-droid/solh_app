import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_home/domain/entities/course_banner_entity.dart';

abstract class CourseBannerRepo {
  Future<DataState<CourseBannerEntity>> getCourseHomeBanner(
      RequestParams params);
}
