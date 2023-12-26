import 'package:solh/features/lms/display/course_wishlist/domain/entities/course_wishlist_entity.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';

import '../../../../../../core/data_state/data_state.dart';

abstract class CourseWishlistRepo {
  Future<DataState<CourseWishlistEntity>> getCourseWishList(
      RequestParams params);
}
