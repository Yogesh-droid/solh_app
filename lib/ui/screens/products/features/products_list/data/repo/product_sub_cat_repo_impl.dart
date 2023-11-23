import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/products_list/data/models/product_sub_cat_model.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/entities/product_sub_cat_entity.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/repo/product_sub_cat_repo.dart';

class ProductSubCatRepoImpl implements ProductSubCatRepo {
  @override
  Future<ProductDataState<ProductSubCatEntity>> getProductSubCat(
      RequestParams params) async {
    try {
      final Map<String, dynamic> res =
          await Network.makeGetRequestWithToken(params.url);
      if (res['success']) {
        final value = ProductSubCatModel.fromJson(res);
        return DataSuccess(data: value);
      } else {
        return DataError(exception: Exception(res['message']));
      }
    } on Exception catch (e) {
      return DataError(exception: Exception(e.toString()));
    }
  }
}
