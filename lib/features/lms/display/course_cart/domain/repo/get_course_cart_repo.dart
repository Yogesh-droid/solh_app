import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_cart/domain/entities/get_course_cart_entity.dart';

abstract class GetCourseCartRepo {
  Future<DataState<GetCourseCartEntity>> getCourseCart(
      RequestParams requestParams);
}
