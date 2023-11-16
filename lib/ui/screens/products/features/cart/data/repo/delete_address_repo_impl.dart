import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/cart/domain/repo/delete_address_repo.dart';

class DeleteAddressRepoImpl implements DeleteAddressRepo {
  @override
  Future<ProductDataState<Map<String, dynamic>>> deleteAddress(
      RequestParams params) async {
    try {
      final Map<String, dynamic> map =
          await Network.makeDeleteRequestWithToken(url: params.url);

      if (map['success']) {
        return DataSuccess(data: map);
      } else {
        return DataError(
            exception: Exception(map['success'] ?? "Something went wrong"));
      }
    } on Exception catch (e) {
      return DataError(exception: Exception(e.toString()));
    }
  }
}
