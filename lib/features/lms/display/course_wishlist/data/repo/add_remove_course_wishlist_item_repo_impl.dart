import 'dart:developer';

import 'package:solh/features/lms/display/course_wishlist/domain/repo/add_remove_course_wishlist_item_repo.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';

class AddRemoveCourseWishlistItemRepoImpl
    implements AddRemoveCourseWishlistItemRepo {
  @override
  Future<(bool, String)> addRemoveCourseWishlistItem(
      RequestParams params) async {
    try {
      final Map<String, dynamic> res = await Network.makePostRequestWithToken(
          url: params.url, body: params.body!);

      return (res['success'] as bool, res["message"].toString());
    } catch (e) {
      rethrow;
    }
  }
}
