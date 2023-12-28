import 'package:solh/ui/screens/products/core/request_params/request_params.dart';

abstract class AddRemoveCourseWishlistItemRepo {
  Future<(bool, String)> addRemoveCourseWishlistItem(RequestParams params);
}
