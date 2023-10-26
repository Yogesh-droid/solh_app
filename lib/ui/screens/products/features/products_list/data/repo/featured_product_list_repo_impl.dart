import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/products_list/data/models/featured_product_list_model.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/entities/featuredProduct_list_entity.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/repo/feaured_product_list_repo.dart';

class FeaturedProductListRepoImpl implements FeaturedProductListRepo {
  @override
  Future<ProductDataState<FeaturedProductListEntity>> getFeaturedProducts(
      RequestParams requestParams) async {
    try {
      final Map<String, dynamic> map =
          await Network.makeGetRequestWithToken(requestParams.url);
      if (map['success']) {
        final value = FeaturedProductListModel.fromJson(map);
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
