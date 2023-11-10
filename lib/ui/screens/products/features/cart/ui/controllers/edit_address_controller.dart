import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/cart/data/models/add_address_req_model.dart';
import 'package:solh/ui/screens/products/features/cart/domain/usecases/edit_address_usecase.dart';

class EditAddressController extends GetxController {
  final EditAddressUsecase editAddressUsecase;
  var editAddressLoading = false.obs;
  var editAddressSuccessMessage = ''.obs;
  var editAddressErr = ''.obs;

  EditAddressController({required this.editAddressUsecase});

  Future<void> editAddress(
      {required AddAddressReqModel addAddressReqModel,
      required String id}) async {
    try {
      editAddressLoading.value = true;
      final ProductDataState<Map<String, dynamic>> dataState =
          await editAddressUsecase.call(RequestParams(
              url: "${APIConstants.api}/api/product/update-address/$id",
              body: addAddressReqModel.toJson()));
      if (dataState.data != null) {
        editAddressLoading.value = false;
        editAddressSuccessMessage.value = dataState.data!['message'];
      } else {
        editAddressErr.value = dataState.exception.toString();
        editAddressLoading.value = false;
      }
    } on Exception catch (e) {
      editAddressErr.value = e.toString();
      editAddressLoading.value = false;
    }
  }
}
