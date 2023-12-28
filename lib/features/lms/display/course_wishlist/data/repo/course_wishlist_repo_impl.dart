import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/features/lms/display/course_wishlist/data/models/course_wishlist_model.dart';
import 'package:solh/features/lms/display/course_wishlist/domain/entities/course_wishlist_entity.dart';
import 'package:solh/features/lms/display/course_wishlist/domain/repo/course_wishlist_repo.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';

class CourseWishlistRepoImpl extends CourseWishlistRepo {
  @override
  Future<DataState<CourseWishlistEntity>> getCourseWishList(
      RequestParams params) async {
    try {
      final Map<String, dynamic> res =
          await Network.makeGetRequestWithToken(params.url);
      if (res['success']) {
        final value = CourseWishlistModel.fromJson(res);
        return DataSuccess(data: value.wishlist as CourseWishlistEntity);
      } else {
        return DataError(
            exception: Exception(res['message'] ?? "Something went wrong"));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
