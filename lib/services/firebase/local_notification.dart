import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:solh/model/journals/journals_response_model.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/mood-meter/mood_analytic_page.dart';
import 'package:solh/ui/screens/my-profile/connections/connections.dart';
import '../../ui/screens/comment/comment-screen.dart';
import '../../ui/screens/video-call/video-call-user.dart';
import '../../widgets_constants/buttons/custom_buttons.dart';
import '../../widgets_constants/constants/textstyles.dart';

class LocalNotification {
  static Future<void> initOneSignal() async {
    await OneSignal.shared.setAppId("7669d7ba-67cf-4557-9b80-96b03e02d503");
    await OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {
      print("Accepted permission: $accepted");
    });
  }

  void initializeOneSignalHandlers(
      GlobalKey<NavigatorState> globalNavigatorKey) {
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      event.complete(event.notification);
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print('running open notification handler');
      print(result.notification.additionalData.toString());
      print(result.notification.body);
      print(result.notification.rawPayload);
      print(result.action!.actionId);
      if (result.action!.actionId == "accept") {
        Future.delayed(Duration(milliseconds: 500), () {
          globalNavigatorKey.currentState!.push(
            MaterialPageRoute(
                builder: (context) => VideoCallUser(
                      channel:
                          result.notification.additionalData!["channelName"],
                      token: result.notification.additionalData!["rtcToken"],
                    )),
          );
        });
      } else {
        switch (result.notification.additionalData!['route']) {
          case 'mood':
            Future.delayed(Duration(seconds: 2), () {
              globalNavigatorKey.currentState!.push(
                MaterialPageRoute(builder: (context) => MoodAnalyticPage()),
              );
            });
            break;

          case 'call':
            Future.delayed(Duration(seconds: 1), () {
              showVideocallDialog(result, globalNavigatorKey);
            });
            break;

          case 'connection':
            Future.delayed(Duration(seconds: 2), () {
              globalNavigatorKey.currentState!.push(
                MaterialPageRoute(builder: (context) => Connections()),
              );
            });
            break;

          case "journal":
            Future.delayed(Duration(seconds: 2), () {
              print(jsonEncode(result.notification.additionalData!['journal'])
                      .toString() +
                  "  *" * 30);
              globalNavigatorKey.currentState!.push(
                MaterialPageRoute(
                    builder: (context) => CommentScreen(
                        journalModel: Journals.fromJson(jsonDecode(jsonEncode(
                            result.notification.additionalData!['journal']))),
                        index: 0)),
              );
            });
            break;

          default:
        }
      }
    });
    print(OneSignal.shared.getDeviceState());
  }

  showVideocallDialog(OSNotificationOpenedResult result,
      GlobalKey<NavigatorState> globalNavigatorKey) {
    showDialog(
        context: globalNavigatorKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            actionsPadding: EdgeInsets.all(8.0),
            content: Text(
              'Incoming video call',
              style: SolhTextStyles.LandingTitleText,
            ),
            actions: [
              SolhPinkBorderMiniButton(
                child: Text(
                  'Reject',
                  style: SolhTextStyles.PinkBorderButtonText,
                ),
                onPressed: () {
                  globalNavigatorKey.currentState!.pop();
                },
              ),
              SolhGreenMiniButton(
                child: Text(
                  'Accept',
                  style: SolhTextStyles.GreenButtonText,
                ),
                onPressed: () {
                  //Navigator.of(globalNavigatorKey.currentState, rootNavigator: true).pop();

                  Future.delayed(Duration(milliseconds: 500), () {
                    globalNavigatorKey.currentState!.pop();
                    globalNavigatorKey.currentState!.push(
                      MaterialPageRoute(
                          builder: (context) => VideoCallUser(
                                channel: result.notification
                                    .additionalData!["channelName"],
                                token: result
                                    .notification.additionalData!["rtcToken"],
                              )),
                    );
                  });
                },
              )
            ],
          );
        });
  }
}

/* // import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../widgets_constants/constants/colors.dart';

class LocalNotificationService {
  static void initialize() {
    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        'resource://drawable/ic_launcher_round',
        [
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
              groupKey: 'basic_channel_group'),
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupkey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ]);
  }

  static void createCallNotification(
      Map<String, dynamic> content,
      RemoteMessage message,
      List<NotificationActionButton>? actionButton,
      Map<String, String>? payload) {
    print("call");
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0,
        channelKey: content['channelKey'],
        autoDismissible: content['autoDismissible'],
        body: content['body'],
        wakeUpScreen: true,
        icon: 'resource://drawable/ic_launcher_round',
        displayOnForeground: true,
        locked: true,
        category: NotificationCategory.Call,
        fullScreenIntent: true,
        payload: payload,
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
    /*  print("createanddisplaynotification");
    print(message.data);
    switch (message.data['action']) {
      case 'call':
        print("call");
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 0,
            channelKey: 'basic_channel_call',
            title: '${message.notification!.title}',
            body: '${message.notification!.body}',
            wakeUpScreen: true,
            icon: 'resource://drawable/ic_launcher_round',
            displayOnForeground: true,
            locked: true,
            autoDismissible: false,
            category: NotificationCategory.Call,

            fullScreenIntent: true,
            // showWhen: true,
          ),
          actionButtons: <NotificationActionButton>[
            NotificationActionButton(key: 'accept', label: 'Accept'),
            NotificationActionButton(key: 'reject', label: 'Reject'),
          ],
        );
        Future.delayed(Duration(seconds: 20), () {
          AwesomeNotifications()
              .dismissNotificationsByChannelKey('basic_channel_call');
        });
        break;
      default: */
    print("default");
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: content['id'],
            channelKey: content['channelKey'],
            autoDismissible: content['autoDismissible'],
            title: '${message.notification!.title}',
            body: '${message.notification!.body}'),
        actionButtons: actionButton);

    Future.delayed(Duration(seconds: 20), () {
      AwesomeNotifications()
          .dismissNotificationsByChannelKey('basic_channel_call');
    });
    // }
  }
}
 */