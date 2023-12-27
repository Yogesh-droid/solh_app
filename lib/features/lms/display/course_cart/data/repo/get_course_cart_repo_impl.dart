import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_cart/data/models/get_course_cart_model.dart';
import 'package:solh/features/lms/display/course_cart/domain/entities/get_course_cart_entity.dart';
import 'package:solh/services/network/network.dart';
import '../../domain/repo/get_course_cart_repo.dart';

class GetCourseCartRepoImpl implements GetCourseCartRepo {
  @override
  Future<DataState<GetCourseCartEntity>> getCourseCart(
      RequestParams requestParams) async {
    try {
      final Map<String, dynamic> res =
          await Network.makeGetRequestWithToken(requestParams.url);
      if (res['success']) {
        final value = GetCourseCartModel.fromJson(res);
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
