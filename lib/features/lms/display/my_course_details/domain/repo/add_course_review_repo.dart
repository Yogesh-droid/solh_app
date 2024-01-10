import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';

abstract class AddCourseReviewRepo {
  Future<DataState<Map<String, dynamic>>> addReview(RequestParams params);
}
