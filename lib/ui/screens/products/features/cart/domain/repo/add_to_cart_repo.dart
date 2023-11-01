import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';

import '../../../../core/request_params/request_params.dart';

abstract class AddToCartRepo {
  Future<ProductDataState<String>> addToCart(RequestParams params);
}
