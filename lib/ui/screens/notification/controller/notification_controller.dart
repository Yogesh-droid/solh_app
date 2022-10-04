import 'package:get/get.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/ui/screens/notification/model/notification_model.dart';
import 'package:solh/ui/screens/notification/services/notification_services.dart';

class NotificationController extends GetxController {
  final notificationServices = NotificationServices();
  var notificationModel = <NotificationList>[].obs;

  var shouldRefresh = false.obs;

  var isNotificationListLoading = false.obs;

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   getNoificationController(userBlocNetwork.id);
  //   super.onInit();
  // }

  Future<void> getNoificationController(String sId) async {
    if (notificationModel.value.length == 0) {
      isNotificationListLoading(true);
    } else {
      shouldRefresh(true);
    }
    NotificationModel response =
        await notificationServices.getNotificationList(sId);
    isNotificationListLoading(false);

    shouldRefresh(false);

    notificationModel.value = response.notificationList!;
  }
}
