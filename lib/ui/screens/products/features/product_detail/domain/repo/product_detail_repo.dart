import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/product_detail/domain/entities/product_detail_entity.dart';

abstract class ProductDetailRepo {
  Future<ProductDataState<ProductDetailEntity>> getProductDetail(
      RequestParams params);
}
