import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/cart/data/models/address_model.dart';
import 'package:solh/ui/screens/products/features/cart/domain/entities/address_entity.dart';
import 'package:solh/ui/screens/products/features/cart/domain/repo/address_repo.dart';

class AddressRepoImpl implements AddressRepo {
  @override
  Future<ProductDataState<AddressEntity>> getAddressList(
      RequestParams params) async {
    try {
      final Map<String, dynamic> map =
          await Network.makeGetRequestWithToken(params.url);
      if (map['success']) {
        return DataSuccess(data: AddressModel.fromJson(map));
      } else {
        return DataError(exception: Exception(map['message']));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
