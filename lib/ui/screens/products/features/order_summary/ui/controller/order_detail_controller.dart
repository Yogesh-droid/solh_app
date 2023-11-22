import 'package:get/get.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/entity/order_detail_entity.dart';

class OrderDetailController extends GetxController {
  var isDetailLoading = false.obs;
  var orderDetailEntity = OrderDetailEntity().obs;
  var orderDetailErr = ''.obs;

  Future<void> getOrderDetails(String id) async {
    try {
      isDetailLoading.value = true;
    } on Exception catch (e) {
      isDetailLoading.value = false;
      orderDetailErr.value = e.toString();
    }
  }
}
