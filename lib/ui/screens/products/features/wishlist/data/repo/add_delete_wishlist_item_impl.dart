import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/wishlist/domain/repo/add_delete_wishlist_item_repo.dart';

class AddDeleteWishlistItemRepoImpl implements AddDeleteWishlistItemRepo {
  @override
  Future<ProductDataState> addDeleteWishlistItem(
      RequestParams requestParams) async {
    try {
      print('repo ran');
      final Map<String, dynamic> response =
          await Network.makePostRequestWithToken(
              url: requestParams.url, body: requestParams.body ?? {});
      if (response['success']) {
        return DataSuccess(data: true);
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
