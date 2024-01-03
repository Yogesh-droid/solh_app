import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/features/lms/display/my_courses/data/model/my_courses_model.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';

abstract class MyCourseRepo {
  Future<DataState<MyCoursesModel>> getMyCourses(
      {required RequestParams requestParams});
}
