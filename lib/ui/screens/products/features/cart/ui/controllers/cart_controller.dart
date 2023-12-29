import 'package:get/get.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/cart/domain/entities/cart_entity.dart';
import '../../../../../../../constants/api.dart';
import '../../domain/usecases/cart_usecase.dart';

class CartController extends GetxController {
  final CartUsecase cartUsecase;
  var isCartLoading = false.obs;
  var error = ''.obs;
  var cartEntity = CartEntity().obs;
  var totalPayblePrice = 0.0.obs;

  CartController({required this.cartUsecase});

  Future<void> getCart() async {
    error.value = '';
    try {
      isCartLoading.value = true;
      final ProductDataState<CartEntity> dataState = await cartUsecase
          .call(RequestParams(url: "${APIConstants.api}/api/product/get-cart"));
      if (dataState.data != null) {
        cartEntity.value = CartEntity();
        cartEntity.value = dataState.data!;
        totalPayblePrice.value = cartEntity.value.totalPrice!.toDouble();

        isCartLoading.value = false;
      } else {
        isCartLoading.value = false;
        error.value = dataState.exception.toString();
      }
    } on Exception catch (e) {
      isCartLoading.value = false;
      error.value = e.toString();
    }
  }
}
