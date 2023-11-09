import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/cart/domain/repo/add_address_repo.dart';

class AddAddressRepoImpl implements AddAddressRepo {
  @override
  Future<ProductDataState<Map<String, dynamic>>> addAddress(
      RequestParams params) async {
    try {
      final Map<String, dynamic> map = await Network.makePostRequestWithToken(
          url: params.url, body: params.body!, isEncoded: true);
      if (map['success']) {
        return DataSuccess(data: map);
      } else {
        return DataError(exception: map['message'] ?? "Something went wrong");
      }
    } on Exception catch (e) {
      return DataError(exception: Exception(e.toString()));
    }
  }
}
