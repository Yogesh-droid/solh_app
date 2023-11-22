import 'dart:developer';

import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/order_summary/data/model/order_list_model.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/usecase/order_list_usecase.dart';

class OrderListController extends GetxController {
  final OrderListUsecase orderListUsecase;

  OrderListController({required this.orderListUsecase});
  var orderFilterStatus = ''.obs;
  var isLoading = false.obs;
  var error = ''.obs;

  var orderListModel = OrderListModel().obs;
  Future<void> getOrderList({String status = ''}) async {
    try {
      isLoading.value = true;
      final ProductDataState<OrderListModel> orderData =
          await orderListUsecase.call(RequestParams(
              url:
                  "${APIConstants.api}/api/product/order-list?status=$status"));

      if (orderData.data != null) {
        isLoading.value = false;
        orderListModel.value = orderData.data!;
      } else {
        isLoading.value = false;
        error.value = orderData.exception.toString();
      }
    } on Exception catch (e) {
      log(e.toString());
      isLoading.value = false;
      error.value = e.toString();
    }
  }
}
