import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/features/home/domain/entities/feature_product_entity.dart';
import 'package:solh/ui/screens/products/features/wishlist/domain/entity/product_wishlist_items_entity.dart';
import 'package:solh/ui/screens/products/features/wishlist/domain/repo/get_wishlist_items_repo.dart';

class ProductWishlistUsecase extends Usecase {
  GetWishlistItemsRepo getWishlistItemsRepo;
  ProductWishlistUsecase({required this.getWishlistItemsRepo});
  @override
  Future<ProductDataState<List<ProductWishlistEntity>>> call(params) async {
    return await getWishlistItemsRepo.getWishlistItems(params);
  }
}
