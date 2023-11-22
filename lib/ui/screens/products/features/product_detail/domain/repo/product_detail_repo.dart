import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/product_detail/data/model/product_details_model.dart';

abstract class ProductDetailRepo {
  Future<ProductDataState<ProductDetailsModel>> getProductDetail(
      RequestParams params);
}
