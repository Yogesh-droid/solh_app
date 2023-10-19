import 'dart:isolate';

import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/notification/model/notification_model.dart';
import 'package:solh/ui/screens/notification/services/notification_services.dart';

class NotificationController extends GetxController {
  final notificationServices = NotificationServices();
  var notificationModel = <NotificationList>[].obs;

  var shouldRefresh = false.obs;

  var isNotificationListLoading = false.obs;

  Future<void> getNoificationController(String sId) async {
    if (notificationModel.length == 0) {
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

  Future<void> updateStatus(String id) async {
    Network.makePutRequestWithToken(
        url:
            "${APIConstants.api}/api/custom/update-notification-seen-status/$id",
        body: {"status": "read"});
  }
}

void updateNotifStatus(List args) {
  String id = args[2];
  RxList<NotificationList> modelList = args[1];
  SendPort sendPort = args[0];
  int index = 0;
  for (var element in modelList) {
    if (element.sId == id) {
      index = modelList.indexOf(element);
      break;
    }
  }
  sendPort.send(index);
}
