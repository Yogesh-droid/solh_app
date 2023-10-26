import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/features/home/data/models/product_main_cat_model.dart';
import 'package:solh/ui/screens/products/features/home/domain/entities/product_mainCat_entity.dart';
import 'package:solh/ui/screens/products/features/home/domain/repo/product_mainCat_repo.dart';

class ProductMainCatRepoImpl implements ProductMainCatRepo {
  @override
  Future<ProductDataState<List<ProductMainCatEntity>>> getProductMainCat(
      RequestParams requestParams) async {
    try {
      final Map<String, dynamic> map =
          await Network.makeGetRequestWithToken(requestParams.url);
      if (map['success']) {
        final value = ProductMainCatModel.fromJson(map);
        return DataSuccess(data: value.mainCategory);
      } else {
        return DataError(
            exception: Exception(map['message'] ?? "Something went wrong"));
      }
    } on Exception catch (e) {
      return DataError(exception: Exception(e.toString()));
    }
  }
}
