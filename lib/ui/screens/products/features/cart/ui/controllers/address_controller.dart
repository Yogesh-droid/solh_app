import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/cart/domain/entities/address_entity.dart';
import 'package:solh/ui/screens/products/features/cart/domain/usecases/address_usecase.dart';

class AddressController extends GetxController {
  final AddressUsecase addressUsecase;

  var addressEntity = AddressEntity().obs;
  var isAddressLoading = false.obs;
  var addressErr = ''.obs;

  AddressController({required this.addressUsecase});

  Future<void> getAddress() async {
    final ProductDataState<AddressEntity> dataState = await addressUsecase.call(
        RequestParams(url: "${APIConstants.api}/api/product/get-address-list"));
    try {
      if (dataState.data != null) {
        addressEntity.value = dataState.data!;
        isAddressLoading.value = false;
      } else {
        isAddressLoading.value = false;
        addressErr.value = dataState.exception.toString();
      }
    } on Exception catch (e) {
      isAddressLoading.value = false;
      addressErr.value = e.toString();
    }
  }
}
