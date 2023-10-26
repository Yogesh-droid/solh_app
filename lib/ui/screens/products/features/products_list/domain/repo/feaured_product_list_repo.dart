import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/entities/featuredProduct_list_entity.dart';

abstract class FeaturedProductListRepo {
  Future<ProductDataState<FeaturedProductListEntity>> getFeaturedProducts(
      RequestParams requestParams);
}
