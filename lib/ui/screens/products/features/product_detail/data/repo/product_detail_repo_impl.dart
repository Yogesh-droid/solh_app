import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/product_detail/data/model/product_detail_model.dart';
import 'package:solh/ui/screens/products/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:solh/ui/screens/products/features/product_detail/domain/repo/product_detail_repo.dart';

class ProductDetailRepoImpl implements ProductDetailRepo {
  @override
  Future<ProductDataState<ProductDetailEntity>> getProductDetail(
      RequestParams params) async {
    try {
      final Map<String, dynamic> map =
          await Network.makeGetRequestWithToken(params.url);
      if (map['success']) {
        final value = ProductDetailModel.fromJson(map);
        return DataSuccess(data: value.product);
      } else {
        return DataError(
            exception: Exception(map['messsge'] ?? "Something went wrong"));
      }
    } on Exception catch (e) {
      return DataError(exception: Exception(e.toString()));
    }
  }
}
