import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/products_list/data/models/product_list_model.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/entities/product_list_entity.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/repo/product_list_repo.dart';

class ProductListRepoImpl implements ProductListRepo {
  @override
  Future<ProductDataState<ProductListEntity>> getProductList(
      RequestParams params) async {
    try {
      final Map<String, dynamic> map =
          await Network.makeGetRequestWithToken(params.url);
      print("This is map $map");
      if (map['success']) {
        final value = ProductListModel.fromJson(map);
        return DataSuccess(data: value);
      } else {
        return DataError(
            exception: Exception(map['message'] ?? "Something went wrong"));
      }
    } on Exception catch (e) {
      return DataError(exception: Exception(e.toString()));
    }
  }
}
