import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_cart/domain/entities/get_course_cart_entity.dart';
import 'package:solh/features/lms/display/course_cart/domain/usecases/get_course_cart_usecase.dart';

import '../../data/models/get_course_cart_model.dart';

class GetCourseCartController extends GetxController {
  final GetCourseCartUsecase getCourseCartUsecase;
  var isLoading = false.obs;
  var totalSavings = 0.obs;
  var totalPrice = 0.obs;
  var grandTotal = 0.obs;
  var cartList = <CartList>[].obs;
  var err = ''.obs;

  GetCourseCartController({required this.getCourseCartUsecase});

  Future<void> getCourseCart() async {
    try {
      isLoading.value = true;
      final DataState<GetCourseCartEntity> dataState =
          await getCourseCartUsecase.call(
              RequestParams(url: "${APIConstants.api}/api/lms/user/get-cart"));
      if (dataState.data != null) {
        cartList.value = dataState.data!.cartList ?? [];
        isLoading.value = false;
      } else {
        err.value = dataState.exception.toString();
        isLoading.value = false;
      }
    } on Exception catch (e) {
      err.value = e.toString();
      isLoading.value = false;
    }
  }
}
