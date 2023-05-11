import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:solh/controllers/chat-list/chat_list_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/model/journals/journals_response_model.dart';
import 'package:solh/ui/screens/mood-meter/mood_analytic_page.dart';
import 'package:solh/ui/screens/my-profile/connections/connections.dart';
import '../../ui/screens/chat/chat.dart';
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
      print(event.notification.additionalData);
      print(event.notification.rawPayload.toString());

      if (event.notification.additionalData!['route'] == 'call') {
        showVideocallDialog(event.notification, globalNavigatorKey);
      } else {
        OneSignal.shared
            .completeNotification(event.notification.notificationId, true);
      }
    });

    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult result) async {
      print('running open notification handler');
      print(result.notification.rawPayload);
      print(result.notification.additionalData);
      print('route is ${result.notification.additionalData!['route']}');
      switch (result.notification.additionalData!['route']) {
        case 'mood':
          Future.delayed(Duration(seconds: 2), () {
            globalNavigatorKey.currentState!.push(
              MaterialPageRoute(builder: (context) => MoodAnalyticPage()),
            );
          });
          break;

        case 'call':
          if (result.action != null) {
            if (result.action!.actionId == "accept") {
              print(
                  "this is sender ID${result.notification.additionalData!['data']["senderId"]}");
              Future.delayed(Duration(milliseconds: 500), () {
                globalNavigatorKey.currentState!.push(
                  MaterialPageRoute(
                      builder: (context) => VideoCallUser(
                            sId: result.notification.additionalData!['data']
                                        ["senderId"] !=
                                    null
                                ? result.notification.additionalData!['data']
                                    ["senderId"]
                                : null,
                            channel: result.notification.additionalData!['data']
                                ["channelName"],
                            token: result.notification.additionalData!['data']
                                ['rtcToken'],
                            type:
                                result.notification.additionalData!['callType'],
                          )),
                );
              });
            } else if (result.action!.actionId == "reject") {
            } else {
              print(result.notification.additionalData!['route']);

              Future.delayed(Duration(seconds: 1), () {
                print('Opening Dialog ........................');
                showVideocallDialog(result.notification, globalNavigatorKey);
              });
            }
          } else {
            print(result.notification.additionalData!['route']);

            Future.delayed(Duration(seconds: 1), () {
              print('Opening Dialog ........................');
              showVideocallDialog(result.notification, globalNavigatorKey);
            });
          }
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
        case "chat":
          var response = await Get.find<ProfileController>().getMyProfile();
          if (response) {
            Get.find<ChatListController>().sosChatListController(1);
            Get.find<ChatListController>().chatListController();
            globalNavigatorKey.currentState!.push(
              MaterialPageRoute(
                  builder: (context) => ChatScreen(
                        args: {
                          "name": jsonDecode(result
                              .notification.additionalData!['data'])['author'],
                          "imageUrl": jsonDecode(result.notification
                              .additionalData!['data'])['profilePicture'],
                          "sId": jsonDecode(result
                              .notification.additionalData!['data'])['_id'],
                          "isAnonChat": jsonDecode(result.notification
                              .additionalData!['data'])['isAnonChat'],
                        },
                        // name: jsonDecode(result
                        //     .notification.additionalData!['data'])['author'],
                        // imageUrl: jsonDecode(result.notification
                        //     .additionalData!['data'])['profilePicture'],
                        // sId: jsonDecode(
                        //     result.notification.additionalData!['data'])['_id'],
                      )),
            );
          }
          // Future.delayed(Duration(seconds: 2), () {
          //   globalNavigatorKey.currentState!.push(
          //     MaterialPageRoute(
          //         builder: (context) => ChatScreen(
          //               args: {
          //                 "name": jsonDecode(result
          //                     .notification.additionalData!['data'])['author'],
          //                 "imageUrl": jsonDecode(result.notification
          //                     .additionalData!['data'])['profilePicture'],
          //                 "sId": jsonDecode(result
          //                     .notification.additionalData!['data'])['_id'],
          //                 "isAnonChat": jsonDecode(result.notification
          //                     .additionalData!['data'])['isAnonChat'],
          //               },
          //               // name: jsonDecode(result
          //               //     .notification.additionalData!['data'])['author'],
          //               // imageUrl: jsonDecode(result.notification
          //               //     .additionalData!['data'])['profilePicture'],
          //               // sId: jsonDecode(
          //               //     result.notification.additionalData!['data'])['_id'],
          //             )),
          //   );
          // });
          break;

        default:
      }
      // }
    });
    print(OneSignal.shared.getDeviceState());
  }

  showVideocallDialog(
      OSNotification result, GlobalKey<NavigatorState> globalNavigatorKey) {
    debugPrint('result ${result.additionalData}');
    showDialog(
        barrierDismissible: false,
        context: globalNavigatorKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(0),
            actionsPadding: EdgeInsets.all(8.0),
            content: Container(
              height: 180,
              child: Column(
                children: [
                  Text(
                    result.additionalData!['title'] ?? '',
                    style: SolhTextStyles.LandingTitleText,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
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
                        onPressed: () async {
                          Future.delayed(Duration(milliseconds: 500), () {
                            globalNavigatorKey.currentState!.pop();
                            globalNavigatorKey.currentState!.push(
                              MaterialPageRoute(
                                  builder: (context) => VideoCallUser(
                                        sId: result.additionalData!['data']
                                                    ["senderId"] !=
                                                null
                                            ? result.additionalData!['data']
                                                ["senderId"]
                                            : null,
                                        channel: result.additionalData!['data']
                                            ["channelName"],
                                        token: result.additionalData!['data']
                                            ["rtcToken"],
                                        type:
                                            result.additionalData!['callType'],
                                      )),
                            );
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
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