import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/entity/order_detail_entity.dart';

abstract class OrderDetailRepo {
  Future<ProductDataState<OrderDetailEntity>> getOrderDetail(
      RequestParams requestParams);
}
