import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/cart/data/models/address_model.dart';
import 'package:solh/ui/screens/products/features/cart/domain/entities/address_entity.dart';
import 'package:solh/ui/screens/products/features/cart/domain/usecases/address_usecase.dart';

class AddressController extends GetxController {
  final AddressUsecase addressUsecase;

  var addressEntity = AddressEntity().obs;
  var isAddressLoading = false.obs;
  var addressErr = ''.obs;
  var selectedAddress = AddressList().obs;
  var selectedBillingAddress = AddressList().obs;

  AddressController({required this.addressUsecase});

  Future<void> getAddress() async {
    isAddressLoading.value = true;

    final ProductDataState<AddressEntity> dataState = await addressUsecase.call(
        RequestParams(url: "${APIConstants.api}/api/product/get-address-list"));
    try {
      if (dataState.data != null) {
        addressEntity.value = dataState.data!;

        if (dataState.data!.addressList!.isNotEmpty)
          selectedAddress.value = dataState.data!.addressList![0];
        selectedBillingAddress.value = dataState.data!.addressList![0];

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
