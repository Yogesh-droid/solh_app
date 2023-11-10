import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/wishlist/domain/entity/product_wishlist_items_entity.dart';

abstract class GetWishlistItemsRepo {
  Future<ProductDataState<List<ProductWishlistEntity>>> getWishlistItems(
      RequestParams requestParams);
}
