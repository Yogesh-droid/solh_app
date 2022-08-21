// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../widgets_constants/constants/colors.dart';
// import 'package:solh/widgets_constants/constants/colors.dart';

/* class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static void initialize(BuildContext context) {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("ic_launcher_round"),
      iOS: IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
      ),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? id) async {
        print("onSelectNotification");
        if (id!.isNotEmpty) {
          print("Router Value1234 $id");

          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => DemoScreen(
          //       id: id,
          //     ),
          //   ),
          // );

        }
      },
    );
  }

  static void createanddisplaynotification(RemoteMessage message) async {
    print("createanddisplaynotification");
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "high_importance_channel",
          "High Importance Notifications",
          importance: Importance.max,
          priority: Priority.high,
          icon: "ic_launcher_round",
          // channelShowBadge: true,
          // category: "	CATEGORY_CALL",
          // fullScreenIntent: true,
          // timeoutAfter: 20,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['_id'],
      );
    } on Exception catch (e) {
      print(e);
    }
  }
} */

class LocalNotificationService {
  static void initialize() {
    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        'resource://drawable/ic_launcher_round',
        [
          NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: SolhColors.green,
            ledColor: Colors.white,
            importance: NotificationImportance.Default,
            channelShowBadge: true,
            enableLights: true,
            playSound: true,
            enableVibration: true,
          ),
          NotificationChannel(
            channelKey: 'basic_channel_call',
            channelName: 'Basic notifications call',
            channelDescription: 'Notification channel for basic call',
            defaultColor: SolhColors.green,
            ledColor: Colors.white,
            importance: NotificationImportance.Max,
            channelShowBadge: true,
            enableLights: true,
            playSound: true,
            enableVibration: true,
            locked: true,
          )
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupkey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: true);
  }

  static void createCallNotification(Map<String, dynamic> content,
      RemoteMessage message, List<NotificationActionButton>? actionButton) {
    print("call");
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: content['id'],
        channelKey: content['channelKey'],
        autoDismissible: content['autoDismissible'],
        body: '${message.notification!.body}',
        wakeUpScreen: true,
        icon: 'resource://drawable/ic_launcher_round',
        displayOnForeground: true,
        locked: true,
        category: NotificationCategory.Call,
        fullScreenIntent: true,
        // showWhen: true,
      ),
      actionButtons: actionButton,
    );
    Future.delayed(Duration(seconds: 20), () {
      AwesomeNotifications()
          .dismissNotificationsByChannelKey('basic_channel_call');
    });
  }

  static void createanddisplaynotification(
      Map<String, dynamic> content,
      RemoteMessage message,
      List<NotificationActionButton>? actionButton) async {
    // print("createanddisplaynotification");
    // print(message.data);
    // switch (message.data['action']) {
    //   case 'call':
    //     print("call");
    //     AwesomeNotifications().createNotification(
    //       content: NotificationContent(
    //         id: 0,
    //         channelKey: 'basic_channel_call',
    //         title: '${message.notification!.title}',
    //         body: '${message.notification!.body}',
    //         wakeUpScreen: true,
    //         icon: 'resource://drawable/ic_launcher_round',
    //         displayOnForeground: true,
    //         locked: true,
    //         autoDismissible: false,
    //         category: NotificationCategory.Call,

    //         fullScreenIntent: true,
    //         // showWhen: true,
    //       ),
    //       actionButtons: <NotificationActionButton>[
    //         NotificationActionButton(key: 'accept', label: 'Accept'),
    //         NotificationActionButton(key: 'reject', label: 'Reject'),
    //       ],
    //     );
    //     Future.delayed(Duration(seconds: 20), () {
    //       AwesomeNotifications()
    //           .dismissNotificationsByChannelKey('basic_channel_call');
    //     });
    //     break;
    //   default:
    print("default");
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: content['id'],
            channelKey: content['channelKey'],
            autoDismissible: content['autoDismissible'],
            title: '${message.notification!.title}',
            body: '${message.notification!.body}'),
        actionButtons: actionButton);
    // }
  }
}
