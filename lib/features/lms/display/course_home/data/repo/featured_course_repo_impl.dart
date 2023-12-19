import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_home/data/model/featured_course_model.dart';
import 'package:solh/features/lms/display/course_home/domain/entities/featured_course_entity.dart';
import 'package:solh/features/lms/display/course_home/domain/repo/featured_course_repo.dart';
import 'package:solh/services/network/network.dart';

class FeaturedCourseRepoImpl implements FeaturedCourseRepo {
  @override
  Future<DataState<FeaturedCourseEntity>> getFeaturedCourse(
      RequestParams params) async {
    try {
      final Map<String, dynamic> res =
          await Network.makeGetRequestWithToken(params.url);
      if (res['success']) {
        final value = FeaturedCourseModel.fromJson(res);
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
