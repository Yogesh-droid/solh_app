import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/entity/cancel_reason_entity.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/usecase/cancel_reason_usecase.dart';

import '../../domain/usecase/cancel_order_usecase.dart';

class CancelReasonController extends GetxController {
  final CancelReasonUsecase cancelReasonUsecase;
  final CancelOrderUsecase cancelOrderUsecase;
  var selectedReason = ''.obs;
  var reasonRadioGroupValue = ''.obs;

  var cancelReasonLoading = false.obs;
  var cancelReasonErr = ''.obs;
  var cancelReasonEntity = CancelReasonEntity().obs;

  var isCancelInProgress = false.obs;
  var cancelSuccessMsg = ''.obs;
  var cancelFailMsg = ''.obs;

  CancelReasonController({
    required this.cancelReasonUsecase,
    required this.cancelOrderUsecase,
  });

  Future<void> getCancelReason() async {
    cancelReasonLoading.value = true;
    try {
      final ProductDataState<CancelReasonEntity> dataState =
          await cancelReasonUsecase.call(RequestParams(
              url:
                  "${APIConstants.api}/api/product/user-cancellation-reasons"));
      selectedReason.value = '';
      if (dataState.data != null) {
        cancelReasonEntity.value = dataState.data!;
        cancelReasonLoading.value = false;
      } else {
        cancelReasonErr.value = dataState.exception.toString();
        cancelReasonLoading.value = false;
      }
    } on Exception catch (e) {
      cancelReasonErr.value = e.toString();
      selectedReason.value = '';
      cancelReasonLoading.value = false;
    }
  }

  Future<void> cancelOrder(
      {required String orderId,
      required String refId,
      required String reason,
      required String comment}) async {
    try {
      isCancelInProgress.value = true;
      final ProductDataState<String> dataState = await cancelOrderUsecase.call(
          RequestParams(
              url: "${APIConstants.api}/api/product/cancel-product-order",
              body: {
            "orderId": orderId,
            "refId": refId,
            "reason": reason,
            "comment": comment
          }));
      if (dataState.data != null) {
        cancelSuccessMsg.value = dataState.data!;
        isCancelInProgress.value = false;
      } else {
        cancelFailMsg.value = dataState.exception.toString();
        isCancelInProgress.value = false;
      }
    } on Exception catch (e) {
      cancelFailMsg.value = e.toString();
      isCancelInProgress.value = false;
    }
  }
}
