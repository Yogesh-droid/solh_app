import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/order_summary/data/model/order_list_model.dart';

abstract class GetOrderListRepo {
  Future<ProductDataState<OrderListModel>> getOrderList(
      RequestParams requestParams);
}
