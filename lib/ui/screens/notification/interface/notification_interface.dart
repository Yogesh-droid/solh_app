import 'package:solh/ui/screens/notification/model/notification_model.dart';

abstract class Notificationinterface {
  Future<NotificationModel> getNotificationList(String sId);
}
