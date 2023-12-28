import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_cart/domain/usecases/add_course_to_cart_usecase.dart';
import 'package:solh/services/utility.dart';

class AddCourseToCartController extends GetxController {
  final AddCourseToCartUsecase addCourseToCartUsecase;
  var isAddingToCart = false.obs;
  var err = ''.obs;
  var message = ''.obs;
  var isAddedToCart = false.obs;
  var currentUpdatingCourse = '';

  AddCourseToCartController({required this.addCourseToCartUsecase});

  Future<void> addToCart(String id) async {
    isAddingToCart.value = true;
    isAddedToCart.value = false;
    try {
      final DataState<Map<String, dynamic>> res =
          await addCourseToCartUsecase.call(RequestParams(
              url: "${APIConstants.api}/api/lms/user/add-to-cart",
              body: {"courseId": id}));
      if (res.data != null) {
        if (res.data!['code'] == 201) {
          isAddedToCart.value = true;
        } else {
          isAddedToCart.value = false;
        }
        message.value = res.data!['message'];
        Utility.showToast(res.data!['message']);
        isAddingToCart.value = false;
      } else {
        err.value = res.exception.toString();
        Utility.showToast(res.exception.toString());
        isAddingToCart.value = false;
      }
    } on Exception catch (e) {
      err.value = e.toString();
      Utility.showToast(e.toString());
      isAddingToCart.value = false;
    }
  }
}
