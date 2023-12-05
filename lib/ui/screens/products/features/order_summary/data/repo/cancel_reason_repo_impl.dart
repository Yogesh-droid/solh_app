import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/order_summary/data/model/cancel_reason_model.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/entity/cancel_reason_entity.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/repo/cancel_reason_repo.dart';

class CancelReasonRepoImpl implements CancelReasonRepo {
  @override
  Future<ProductDataState<CancelReasonEntity>> getCancelReasons(
      RequestParams requestParams) async {
    try {
      final Map<String, dynamic> map =
          await Network.makeGetRequestWithToken(requestParams.url);
      if (map['success']) {
        final value = CancelReasonModel.fromJson(map);
        return DataSuccess(data: value);
      } else {
        return DataError(exception: Exception(map['message']));
      }
    } on Exception catch (e) {
      return DataError(exception: Exception(e.toString()));
    }
  }
}
