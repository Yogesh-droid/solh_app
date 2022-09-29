import 'package:solh/ui/screens/notification/model/notification_model.dart';
import 'package:solh/ui/screens/notification/services/notification_services.dart';

abstract class Notificationinterface {
  Future<NotificationModel> getNotificationList(String sId);
}
