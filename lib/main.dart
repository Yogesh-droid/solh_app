// import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:convert';
// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/controllers/profile/anon_controller.dart';
import 'package:solh/services/firebase/local_notification.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/my-profile/connections/connections.dart';
import 'package:solh/ui/screens/video-call/video-call-user.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'controllers/getHelp/search_market_controller.dart';
import 'controllers/mood-meter/mood_meter_controller.dart';
import 'controllers/profile/appointment_controller.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart' as sizer;
import 'package:solh/controllers/profile/age_controller.dart';
import 'package:solh/init-app.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/services/user/session-cookie.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

final GlobalKey<NavigatorState> globalNavigatorKey =
    GlobalKey<NavigatorState>();
/* Future<void> backgroundMessageHandler(RemoteMessage remoteMessage,
    [bool? isInApp]) async {
  await Firebase.initializeApp();
  List<NotificationActionButton> list =
      jsonDecode(remoteMessage.data['actionButtons'])
          .map<NotificationActionButton>(
            (actionButton) => NotificationActionButton(
                key: actionButton['key'], label: actionButton['label']),
          )
          .toList();
  LocalNotificationService.createCallNotification(
      jsonDecode(remoteMessage.data['content']), remoteMessage, list, {
    "token": "${remoteMessage.data['rtcToken']}",
    "channelName": "${remoteMessage.data['channelName']}"
  });
} */

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //LocalNotificationService.initialize();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  //FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  OneSignal.shared.setAppId("7669d7ba-67cf-4557-9b80-96b03e02d503");
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });

  //checkVersion();
  final AgeController ageController = Get.put(AgeController());
  AppointmentController appointmentController =
      Get.put(AppointmentController());

  final moodMeterController = Get.put(MoodMeterController());
  final AnonController anonController = Get.put(AnonController());
  SearchMarketController searchMarketController =
      Get.put(SearchMarketController());
  BookAppointmentController bookAppointment =
      Get.put(BookAppointmentController());
  String? fcmToken;

  FirebaseMessaging.instance.getToken().then((token) {
    print("FirebaseMessaging.instance.getToken");
    print('FirebaseMessaging.instance.getToken' + token.toString());
    fcmToken = token;
  });
  if (FirebaseAuth.instance.currentUser != null) {
    String idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    String oneSignalId = '';
    await OneSignal.shared.getDeviceState().then((value) {
      print(value!.userId);
      oneSignalId = value.userId ?? '';
    });
    print("*" * 30 + "\n" + "Id Token: $idToken");
    bool isNewUser =
        await SessionCookie.createSessionCookie(idToken, fcmToken, oneSignalId);
    Map<String, dynamic> _initialAppData = await initApp();
    runApp(SolhApp(
      isProfileCreated: _initialAppData["isProfileCreated"] && !isNewUser,
    ));

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      event.complete(event.notification);
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      /*  showDialog(
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
                ),
                SolhGreenMiniButton(
                  child: Text(
                    'Accept',
                    style: SolhTextStyles.GreenButtonText,
                  ),
                )
              ],
            );
          }); */
      print('running open notification handler');
      print(result.notification.additionalData.toString());
      print(result.notification.body);
      print(result.notification.rawPayload);
      if (result.action != null) {
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
          showVideocallDialog(result);
        }
      } else {
        showVideocallDialog(result);
      }
    });
    print(OneSignal.shared.getDeviceState());
  } else
    runApp(SolhApp(
      isProfileCreated: false,
    ));

  FlutterNativeSplash.remove();

  /*  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Solh',
    home: Scaffold(
        appBar: AppBar(title: Text('Solh')),
        body: Container(
            child: Center(
          child: MaterialButton(
            color: Colors.blue,
            focusColor: Colors.blue,
            onPressed: () {
              final ioc = new HttpClient();
              ioc.badCertificateCallback =
                  (X509Certificate cert, String host, int port) => true;
              final http = new IOClient(ioc);
              http
                  .get(Uri.parse(
                      'https://api.solhapp.com/api/get-parent?journal=625f8aab1acb0f23151313b9&page=1'
                      //'https://jsonplaceholder.typicode.com/todos/1'
                      //'https://api.anah.ae/api/category/getcategory'
                      ))
                  .then((response) {
                print(response.body + '\n' + response.statusCode.toString());
              }).catchError((error) {
                print(error);
              });
              // print('gyfuyujnjjbbhjubj');
              // Dio()
              //     .get(
              //         'https://api.solhapp.com/api/get-parent?journal=625f8aab1acb0f23151313b9&page=1',
              //         options: Options(headers: <String, String>{
              //           'Accept': 'application/json',
              //           'Content-Type': 'application/json; charset=UTF-8',
              //         }))
              //     .then((value) {
              //   print(value.data);
              // }).catchError((error) {
              //   print(error);
              // });
            },
            child: Text('Test'),
          ),
        ))),
  )); */
}

void showVideocallDialog(OSNotificationOpenedResult result) {
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
                              channel: result
                                  .notification.additionalData!["channelName"],
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

class SolhApp extends StatefulWidget {
  SolhApp({Key? key, required bool isProfileCreated})
      : _isProfileCreated = isProfileCreated,
        super(key: key);

  final bool _isProfileCreated;

  @override
  State<SolhApp> createState() => _SolhAppState();
}

class _SolhAppState extends State<SolhApp> {
  final _appRouter = AppRouter(globalNavigatorKey);
  String channelName = '';
  String channelToken = '';

  @override
  void initState() {
    //LocalNotificationService.initialize(context);
    /*  FirebaseMessaging.instance.getInitialMessage().then(
      (message) async {
        if (message != null) {
          if (message.data['action'] != null) {
            Utility.showToast(message.data['action']);
            Future.delayed(Duration(seconds: 2), () {
              globalNavigatorKey.currentState!.push(
                MaterialPageRoute(
                  builder: (context) => VideoCallUser(
                    channel: message.data['channelName'],
                    token: message.data['rtcToken'],
                  ),
                ),
              );
            });
          } else {
            Utility.showToast('action is null');
          }
        } else {
          //Utility.showToast("Message is null");
        }

        /*   if (message != null) {
          print("New Notification");

          List<NotificationActionButton> list =
              jsonDecode(message.data['actionButtons'])
                  .map<NotificationActionButton>(
                    (actionButton) => NotificationActionButton(
                        key: actionButton['key'], label: actionButton['label']),
                  )
                  .toList();

          //if (jsonDecode(message.data['content'])['id'] == 0) {
          Future.delayed(Duration(seconds: 2), () {
            globalNavigatorKey.currentState!.push(
              MaterialPageRoute(
                builder: (context) => Connections(),
              ),
            );
          });
          // }
        } */
      },
    ); */
    setupInteractedMessage();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data['actionButtons']}');
      print('Message data: ${message.data['content']}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
      // Utility.showToast(message.data['action']);
      //LocalNotificationService.createCallNotification(message);
      List<NotificationActionButton> list =
          jsonDecode(message.data['actionButtons'])
              .map<NotificationActionButton>(
                (actionButton) => NotificationActionButton(
                    key: actionButton['key'], label: actionButton['label']),
              )
              .toList();
      LocalNotificationService.createCallNotification(
          jsonDecode(message.data['content']), message, list, {
        "token": "${message.data['rtcToken']}",
        "channelName": "${message.data['channelName']}"
      });
      channelName = message.data['channelName'];
      channelToken = message.data['rtcToken'];
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          if (message.notification!.android!.channelId ==
              'basic_channel_call') {
            print('Calling ');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VideoCallUser(
                        token: message.data['rtcToken'],
                        channel: message.data['channelName'])));
          }
        }
      },
    );
    FirebaseMessaging.instance.onTokenRefresh.listen(
      (token) {
        print("FirebaseMessaging.instance.onTokenRefresh");
        print('FirebaseMessaging.instance.onTokenRefresh' + token.toString());
      },
    );

    /*   AwesomeNotifications().actionStream.listen(
      (ReceivedAction receivedAction) {
        Utility.showToast(receivedAction.buttonKeyPressed);
        if (receivedAction.buttonKeyPressed == 'accept') {
          print('Accepted');
          globalNavigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (context) =>
                  VideoCallUser(channel: channelName, token: channelToken),
            ),
          );
        } else if (receivedAction.buttonKeyPressed == 'reject') {
          print('Rejected');
        }

        //Here if the user clicks on the notification itself
        //without any button
      },
    ); */

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return sizer.Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp.router(
        supportedLocales: [
          Locale("en"),
        ],
        localizationsDelegates: [CountryLocalizations.delegate],
        routerDelegate: _appRouter.delegate(
            initialDeepLink: widget._isProfileCreated
                ? "MasterScreen"
                : "IntroCarouselScreen"),
        routeInformationParser: _appRouter.defaultRouteParser(),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: GoogleFonts.signika().fontFamily,
          primaryColor: Color.fromRGBO(95, 155, 140, 1),
          primarySwatch: Colors.green,
          buttonTheme: ButtonThemeData(buttonColor: SolhColors.white),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  splashFactory: InkRipple.splashFactory,
                  overlayColor:
                      MaterialStateProperty.all<Color>(SolhColors.grey),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(SolhColors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  )),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(SolhColors.green))),
          inputDecorationTheme: InputDecorationTheme(),
        ),
      );
    });
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {}
}
