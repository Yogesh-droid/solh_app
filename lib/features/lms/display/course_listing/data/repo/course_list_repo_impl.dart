import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_listing/data/models/course_list_model.dart';
import 'package:solh/features/lms/display/course_listing/domain/entities/course_list_entity.dart';
import 'package:solh/features/lms/display/course_listing/domain/repo/course_list_repo.dart';
import 'package:solh/services/network/network.dart';

class CourseListRepoImpl implements CourseListRepo {
  @override
  Future<DataState<CourseListEntity>> getCourseList(
      RequestParams requestParams) async {
    try {
      final Map<String, dynamic> res =
          await Network.makeGetRequestWithToken(requestParams.url);
      if (res['success']) {
        final value = CourseListModel.fromJson(res);
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
