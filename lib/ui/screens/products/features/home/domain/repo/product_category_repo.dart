import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/home/domain/entities/product_category_entity.dart';

abstract class ProductCategoryRepo {
  Future<ProductDataState<List<ProductCategoryEntity>>> getProductCategory(
      RequestParams params);
}
