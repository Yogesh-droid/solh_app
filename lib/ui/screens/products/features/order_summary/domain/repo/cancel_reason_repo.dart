import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/entity/cancel_reason_entity.dart';

abstract class CancelReasonRepo {
  Future<ProductDataState<CancelReasonEntity>> getCancelReasons(
      RequestParams requestParams);
}
