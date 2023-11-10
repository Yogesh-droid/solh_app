import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/cart/data/models/add_address_req_model.dart';
import 'package:solh/ui/screens/products/features/cart/domain/usecases/add_address_usecase.dart';

class AddAddressController extends GetxController {
  final AddAddressUsecase addAddressUsecase;

  var successMessage = ''.obs;
  var isAddingAddress = false.obs;
  var addAddressErr = ''.obs;

  AddAddressController({required this.addAddressUsecase});

  Future<void> addAddress(AddAddressReqModel addAddressReqModel) async {
    try {
      final ProductDataState<Map<String, dynamic>> dataState =
          await addAddressUsecase.call(RequestParams(
              url: "${APIConstants.api}/api/product/add-new-address",
              body: addAddressReqModel.toJson()));
      if (dataState.data != null) {
        successMessage.value = dataState.data!['message'];
      } else {
        addAddressErr.value = dataState.exception.toString();
        isAddingAddress.value = false;
      }
    } on Exception catch (e) {
      addAddressErr.value = e.toString();
      isAddingAddress.value = false;
    }
  }
}
