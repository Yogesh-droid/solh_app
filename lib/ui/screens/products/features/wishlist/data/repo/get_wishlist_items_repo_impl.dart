import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/wishlist/data/model/product_wishlist_model.dart';
import 'package:solh/ui/screens/products/features/wishlist/domain/entity/product_wishlist_items_entity.dart';
import 'package:solh/ui/screens/products/features/wishlist/domain/repo/get_wishlist_items_repo.dart';

class GetWishlistItemsRepoImpl implements GetWishlistItemsRepo {
  @override
  Future<ProductDataState<List<ProductWishlistEntity>>> getWishlistItems(
      RequestParams requestParams) async {
    try {
      final Map<String, dynamic> response =
          await Network.makeGetRequestWithToken(requestParams.url);
      if (response['success']) {
        final value = ProductWishlistModel.fromJson(response);
        print(value);
        return DataSuccess(data: value.wishlist);
      } else {
        return DataError(
            exception:
                Exception(response['message'] ?? "Something went wrong"));
      }
    } on Exception catch (e) {
      return DataError(exception: Exception(e.toString()));
    }
  }
}
