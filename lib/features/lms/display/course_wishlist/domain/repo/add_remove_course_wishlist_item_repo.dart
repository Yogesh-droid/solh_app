import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';

abstract class AddRemoveCourseWishlistItemRepo {
  Future<DataState<Map<String, dynamic>>> addRemoveCourseWishlistItem(
      RequestParams params);
}
