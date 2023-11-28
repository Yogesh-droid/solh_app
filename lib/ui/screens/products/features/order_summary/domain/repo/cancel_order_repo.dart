import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';

abstract class CancelOrderRepo {
  Future<ProductDataState<String>> cancelOrder(RequestParams params);
}
