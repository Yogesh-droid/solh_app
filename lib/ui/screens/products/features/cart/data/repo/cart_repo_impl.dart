import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/cart/data/models/cart_model.dart';
import 'package:solh/ui/screens/products/features/cart/domain/entities/cart_entity.dart';
import 'package:solh/ui/screens/products/features/cart/domain/repo/cart_repo.dart';

class CartRepoImpl implements CartRepo {
  @override
  Future<ProductDataState<CartEntity>> getCart(RequestParams params) async {
    try {
      final Map<String, dynamic> map =
          await Network.makeGetRequestWithToken(params.url);
      if (map['success']) {
        final value = CartModel.fromJson(map);
        return DataSuccess(data: value);
      } else {
        return DataError(
            exception: Exception(map['message'] ?? "Something went wrong"));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
