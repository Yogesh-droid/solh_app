import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/home/data/models/product_category_model.dart';
import 'package:solh/ui/screens/products/features/home/domain/entities/product_category_entity.dart';
import 'package:solh/ui/screens/products/features/home/domain/repo/product_category_repo.dart';

class ProductCategoryRepoImpl implements ProductCategoryRepo {
  @override
  Future<ProductDataState<List<ProductCategoryEntity>>> getProductCategory(
      RequestParams params) async {
    try {
      final Map<String, dynamic> response =
          await Network.makeGetRequestWithToken(params.url);
      if (response['success']) {
        final value = ProductCategoryModel.fromJson(response);
        print(value);
        return DataSuccess(data: value.subCategory);
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
