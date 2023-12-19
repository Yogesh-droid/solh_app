import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_home/data/model/course_cat_model.dart';
import 'package:solh/features/lms/display/course_home/domain/entities/course_cat_entity.dart';
import 'package:solh/features/lms/display/course_home/domain/repo/course_cat_repo.dart';
import 'package:solh/services/network/network.dart';

class CourseCatRepoImpl implements CourseCatRepo {
  @override
  Future<DataState<CourseCatEntity>> getCourseCat(RequestParams params) async {
    try {
      final Map<String, dynamic> respose =
          await Network.makeGetRequestWithToken(params.url);
      if (respose['success']) {
        final value = CourseCatModel.fromJson(respose);
        return DataSuccess(data: value);
      } else {
        return DataError(
            exception: Exception(respose['message'] ?? "Something went wrong"));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
