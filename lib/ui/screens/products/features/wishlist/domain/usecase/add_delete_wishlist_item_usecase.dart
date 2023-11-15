import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/features/wishlist/domain/repo/add_delete_wishlist_item_repo.dart';

class AddDeleteWishlistItemUsecase extends Usecase {
  final AddDeleteWishlistItemRepo addDeleteWishlistItemRepo;
  AddDeleteWishlistItemUsecase({required this.addDeleteWishlistItemRepo});
  @override
  Future<ProductDataState> call(params) async {
    return await addDeleteWishlistItemRepo.addDeleteWishlistItem(params);
  }
}
