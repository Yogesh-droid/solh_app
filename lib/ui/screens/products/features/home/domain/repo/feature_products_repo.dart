import 'package:get/get_connect/http/src/request/request.dart';

import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/home/domain/entities/feature_product_entity.dart';

abstract class FeatureProductsRepo {
  Future<ProductDataState<List<FeatureProductsEntity>>> getFeatureProducts(
      RequestParams requestParams);
}
