import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/home/domain/entities/product_mainCat_entity.dart';

abstract class ProductMainCatRepo {
  Future<ProductDataState<List<ProductMainCatEntity>>> getProductMainCat(
      RequestParams requestParams);
}
