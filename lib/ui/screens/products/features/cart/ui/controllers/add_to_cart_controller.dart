import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/cart/domain/usecases/add_to_cart_usecase.dart';

class AddToCartController extends GetxController {
  final AddToCartUsecase addToCartUsecase;
  var addingToCart = false.obs;
  var error = ''.obs;
  var msg = ''.obs;

  AddToCartController({required this.addToCartUsecase});

  Future<void> addToCart(
      {required String productId, required int quantity}) async {
    try {
      final ProductDataState<String> dataState = await addToCartUsecase.call(
          RequestParams(
              url: "${APIConstants.api}/api/product/add-to-cart",
              apiMethods: ApiMethods.post,
              body: {"productId": productId, "quantity": quantity}));

      if (dataState.data != null) {
        msg.value = dataState.data!;
        addingToCart.value = false;
      } else {
        addingToCart.value = false;
        msg.value = dataState.exception.toString();
      }
    } on Exception catch (e) {
      addingToCart.value = false;
      error.value = e.toString();
    }
  }
}
