import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/features/lms/display/course_wishlist/domain/repo/add_remove_course_wishlist_item_repo.dart';
import 'package:solh/ui/screens/products/core/usecase/usecase.dart';

class AddRemoveCourseWishlistItemUsecase extends Usecase {
  AddRemoveCourseWishlistItemRepo addRemoveCourseWishlistItemRepo;

  AddRemoveCourseWishlistItemUsecase(
      {required this.addRemoveCourseWishlistItemRepo});
  @override
  Future<DataState<Map<String, dynamic>>> call(params) async {
    return await addRemoveCourseWishlistItemRepo
        .addRemoveCourseWishlistItem(params);
  }
}
