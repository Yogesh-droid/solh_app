import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/repo/cancel_order_repo.dart';

class CancelOrderRepoImpl implements CancelOrderRepo {
  @override
  Future<ProductDataState<String>> cancelOrder(RequestParams params) async {
    try {
      final Map<String, dynamic> map = await Network.makePostRequestWithToken(
          url: params.url, body: params.body!);
      if (map['success']) {
        return DataSuccess(data: map['message']);
      } else {
        return DataError(exception: Exception(map['message']));
      }
    } on Exception catch (e) {
      return DataError(exception: Exception(e.toString()));
    }
  }
}
