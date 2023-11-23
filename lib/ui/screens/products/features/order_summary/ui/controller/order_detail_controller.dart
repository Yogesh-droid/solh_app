import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/entity/order_detail_entity.dart';

import '../../../../core/request_params/request_params.dart';
import '../../domain/usecase/order_detail_usecase.dart';

class OrderDetailController extends GetxController {
  final OrderDetailUsecase orderDetailUsecase;
  var isDetailLoading = false.obs;
  var orderDetailEntity = OrderDetailEntity().obs;
  var orderDetailErr = ''.obs;

  OrderDetailController({required this.orderDetailUsecase});

  Future<void> getOrderDetails(
      {required String id, required String refId}) async {
    try {
      isDetailLoading.value = true;
      final ProductDataState<OrderDetailEntity> dataState =
          await orderDetailUsecase.call(RequestParams(
              url:
                  '${APIConstants.api}/api/product/order-details/$id?refId=$refId'));
      if (dataState.data != null) {
        orderDetailEntity.value = dataState.data!;
      } else {
        orderDetailErr.value = dataState.exception.toString();
      }
      isDetailLoading.value = false;
    } on Exception catch (e) {
      isDetailLoading.value = false;
      orderDetailErr.value = e.toString();
    }
  }
}
