import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/notification/interface/notification_interface.dart';
import 'package:solh/ui/screens/notification/model/notification_model.dart';

class NotificationServices implements Notificationinterface {
  Future<NotificationModel> getNotificationList(String sId) async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
            APIConstants.api + '/api/custom/notification-list?userid=$sId')
        .onError((error, stackTrace) {
      print(error);
      return {};
    });

    if (map.isNotEmpty) {
      return NotificationModel.fromJson(map);
    } else {
      throw map;
    }
  }
}
