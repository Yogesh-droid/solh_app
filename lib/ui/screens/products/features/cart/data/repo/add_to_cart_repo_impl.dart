import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/cart/domain/repo/add_to_cart_repo.dart';

class AddToCartRepoImpl implements AddToCartRepo {
  @override
  Future<ProductDataState<String>> addToCart(RequestParams params) async {
    try {
      final Map<String, dynamic> map = await Network.makePostRequestWithToken(
          url: params.url, body: params.body!, isEncoded: true);
      print("This is response $map");
      if (map['success']) {
        return DataSuccess(data: map['message']);
      } else {
        return DataError(exception: Exception(map['message']));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
