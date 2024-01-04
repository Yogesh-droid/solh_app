import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/my_course_details/data/models/my_course_detail_model.dart';
import 'package:solh/features/lms/display/my_course_details/domain/entities/my_course_detail_entity.dart';
import 'package:solh/features/lms/display/my_course_details/domain/repo/my_course_detail_repo.dart';
import 'package:solh/services/network/network.dart';

class MyCourseDetailRepoImpl implements MyCourseDetailRepo {
  @override
  Future<DataState<MyCourseDetailEntity>> getMyCourseDetail(
      RequestParams params) async {
    try {
      final Map<String, dynamic> res =
          await Network.makeGetRequestWithToken(params.url);
      if (res['success']) {
        final value = MyCourseDetailModel.fromJson(res);
        return DataSuccess(data: value);
      } else {
        return DataError(exception: Exception(res['message']));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
