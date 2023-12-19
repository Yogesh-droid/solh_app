import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_home/data/model/course_home_banner_model.dart';
import 'package:solh/features/lms/display/course_home/domain/entities/course_banner_entity.dart';
import 'package:solh/features/lms/display/course_home/domain/repo/course_banner_repo.dart';
import 'package:solh/services/network/network.dart';

class CourseBannerRepoImpl implements CourseBannerRepo {
  @override
  Future<DataState<CourseBannerEntity>> getCourseHomeBanner(
      RequestParams params) async {
    try {
      final Map<String, dynamic> map =
          await Network.makeGetRequestWithToken(params.url);
      if (map['success']) {
        final value = CourseHomeBannerModel.fromJson(map);
        return DataSuccess(data: value);
      } else {
        return DataError(
            exception: Exception(map['message'] ?? "Something went wrong"));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
