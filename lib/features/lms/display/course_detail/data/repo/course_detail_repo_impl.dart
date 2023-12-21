import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_detail/data/models/course_details_model.dart';
import 'package:solh/features/lms/display/course_detail/domain/entities/course_details_entity.dart';
import 'package:solh/features/lms/display/course_detail/domain/repo/course_detail_repo.dart';
import 'package:solh/services/network/network.dart';

class CourseDetailRepoImpl implements CourseDetailRepo {
  @override
  Future<DataState<CourseDetailsEntity>> getCourseDetails(
      RequestParams params) async {
    try {
      final Map<String, dynamic> res =
          await Network.makeGetRequestWithToken(params.url);
      if (res['success']) {
        final value = CourseDetailsModel.fromJson(res);
        return DataSuccess(data: value);
      } else {
        return DataError(
            exception: Exception(res['message'] ?? "Something went wrong"));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
