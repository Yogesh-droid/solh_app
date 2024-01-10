import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/my_course_details/domain/repo/add_course_review_repo.dart';
import 'package:solh/services/network/network.dart';

class AddCourseReviewRepoImpl implements AddCourseReviewRepo {
  @override
  Future<DataState<Map<String, dynamic>>> addReview(
      RequestParams params) async {
    try {
      final Map<String, dynamic> res = await Network.makePostRequestWithToken(
          url: params.url, body: params.body!, isEncoded: true);
      if (res['success']) {
        return DataSuccess(data: res);
      } else {
        return DataError(
            exception: Exception(res['message'] ?? "Something went wrong"));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
