import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/my_course_details/data/models/course_faq_model.dart';
import 'package:solh/features/lms/display/my_course_details/domain/entities/course_faq_entity.dart';
import 'package:solh/features/lms/display/my_course_details/domain/repo/course_faq_repo.dart';
import 'package:solh/services/network/network.dart';

class CourseFaqRepoImpl implements  CourseFaqRepo{
  @override
  Future<DataState<CourseFaqEntity>> getCourseFaq(
      RequestParams params) async {
    try {
      final Map<String, dynamic> res =
          await Network.makeGetRequestWithToken(params.url);
      if (res['success']) {
        final value = CourseFaqModel.fromJson(res);
        return DataSuccess(data: value);
      } else {
        return DataError(exception: Exception(res['message']));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}