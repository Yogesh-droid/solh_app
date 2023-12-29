import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/features/lms/display/my_courses/data/model/my_courses_model.dart';
import 'package:solh/features/lms/display/my_courses/domain/repo/my_courses_repo.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';

class MyCourseRepoImpl implements MyCourseRepo {
  @override
  Future<DataState<MyCoursesModel>> getMyCourses(
      {required RequestParams requestParams}) async {
    try {
      Map<String, dynamic> response =
          await Network.makeGetRequestWithToken(requestParams.url);

      if (response["success"]) {
        final value = MyCoursesModel.fromJson(response);

        return DataSuccess(data: value);
      } else {
        return DataError(
            exception:
                Exception(response['message'] ?? "Something went wrong"));
      }
    } on Exception catch (e) {
      return DataError(exception: Exception(e));
    }
  }
}
