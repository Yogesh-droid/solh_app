import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/home/data/models/feature_product_model.dart';
import 'package:solh/ui/screens/products/features/home/domain/entities/feature_product_entity.dart';
import 'package:solh/ui/screens/products/features/home/domain/repo/feature_products_repo.dart';

class FeatureProductsRepoImpl extends FeatureProductsRepo {
  @override
  Future<ProductDataState<List<FeatureProductsEntity>>> getFeatureProducts(
      RequestParams requestParams) async {
    try {
      final Map<String, dynamic> response =
          await Network.makeGetRequestWithToken(requestParams.url);
      if (response['success']) {
        final value = FeatureProductsModel.fromJson(response);
        print(value);
        return DataSuccess(data: value.products);
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
