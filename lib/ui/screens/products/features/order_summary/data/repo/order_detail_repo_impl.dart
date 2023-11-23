import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/order_summary/data/model/order_detail_model.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/entity/order_detail_entity.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/repo/order_detail_repo.dart';

class OrderDetailRepoImpl implements OrderDetailRepo {
  @override
  Future<ProductDataState<OrderDetailEntity>> getOrderDetail(
      RequestParams requestParams) async {
    try {
      final Map<String, dynamic> data =
          await Network.makeGetRequestWithToken(requestParams.url);
      if (data['success']) {
        final value = OrderDetailModel.fromJson(data);
        return DataSuccess(data: value);
      } else {
        return DataError(
            exception: Exception(data['message'] ?? "Something went wrong"));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
