import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/features/lms/display/course_wishlist/domain/repo/add_remove_course_wishlist_item_repo.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';

class AddRemoveCourseWishlistItemRepoImpl
    implements AddRemoveCourseWishlistItemRepo {
  @override
  Future<DataState<Map<String, dynamic>>> addRemoveCourseWishlistItem(
      RequestParams params) async {
    try {
      final Map<String, dynamic> res = await Network.makePostRequestWithToken(
          url: params.url, body: params.body!);

      if (res['success']) {
        return DataSuccess(data: res);
      } else {
        return DataError(
            exception: Exception(res['message'] ?? 'Something went wrong'));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
