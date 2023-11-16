import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/cart/domain/usecases/delete_address_usecase.dart';

import '../../../../../../../constants/api.dart';
import '../../../../core/data_state/product_data_state.dart';

class DeleteAddressController extends GetxController {
  final DeleteAddressUsecase deleteAddressUsecase;
  var isDeletingAddress = false.obs;
  var deleteAddErr = ''.obs;
  var deleteAddSuccessMessage = ''.obs;

  DeleteAddressController({required this.deleteAddressUsecase});

  Future<void> deleteAddress({required String id}) async {
    try {
      isDeletingAddress.value = true;
      final ProductDataState<Map<String, dynamic>> dataState =
          await deleteAddressUsecase.call(RequestParams(
              url: "${APIConstants.api}/api/product/delete-address/$id"));
      if (dataState.data != null) {
        isDeletingAddress.value = false;
        deleteAddSuccessMessage.value = dataState.data!['message'];
      } else {
        deleteAddErr.value = dataState.exception.toString();
        isDeletingAddress.value = false;
      }
    } on Exception catch (e) {
      deleteAddErr.value = e.toString();
      isDeletingAddress.value = false;
    }
  }
}
