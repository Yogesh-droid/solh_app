import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/order_summary/data/model/order_list_model.dart';

import 'package:solh/ui/screens/products/features/order_summary/domain/entity/user_order_list_entity.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/repo/get_order_list_repo.dart';

class GetOrderListRepoImpl extends GetOrderListRepo {
  @override
  Future<ProductDataState<OrderListModel>> getOrderList(
      RequestParams requestParams) async {
    try {
      final Map<String, dynamic> response =
          await Network.makeGetRequestWithToken(requestParams.url);
      if (response['success']) {
        final value = OrderListModel.fromJson(response);
        print(value);
        return DataSuccess(data: value);
      } else {
        return DataError(
            exception:
                Exception(response['message'] ?? "Something went wrong"));
      }
    } on Exception catch (e) {
      return DataError(exception: Exception(e.toString()));
    }
  }
}
