import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/controllers/profile/anon_controller.dart';
import 'package:solh/services/firebase/local_notification.dart';
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
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

final GlobalKey<NavigatorState> globalNavigatorKey =
    GlobalKey<NavigatorState>();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  LocalNotification.initOneSignal();
  initControllers();
  //String? fcmToken;

  // FirebaseMessaging.instance.getToken().then((token) {
  //   print("FirebaseMessaging.instance.getToken");
  //   print('FirebaseMessaging.instance.getToken' + token.toString());
  //   fcmToken = token;
  // });
  if (FirebaseAuth.instance.currentUser != null) {
    //   String idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    //   String oneSignalId = '';
    //   await OneSignal.shared.getDeviceState().then((value) {
    //     print(value!.userId);
    //     oneSignalId = value.userId ?? '';
    //   });
    //   print("*" * 30 + "\n" + "Id Token: $idToken");
    //   print("*" * 30 + "\n" + "One Token: $oneSignalId");
    //   bool isNewUser =
    //       await SessionCookie.createSessionCookie(idToken, fcmToken, oneSignalId);

    bool? newUser = await isNewUser();

    Map<String, dynamic> _initialAppData = await initApp();
    runApp(SolhApp(
      isProfileCreated: _initialAppData["isProfileCreated"] && !newUser,
    ));
    LocalNotification().initializeOneSignalHandlers(globalNavigatorKey);
  } else
    runApp(SolhApp(
      isProfileCreated: false,
    ));

  FlutterNativeSplash.remove();
}

////////   required controllers are initialized here ///////////
void initControllers() {
  final AgeController ageController = Get.put(AgeController());
  AppointmentController appointmentController =
      Get.put(AppointmentController());

  final moodMeterController = Get.put(MoodMeterController());
  final AnonController anonController = Get.put(AnonController());
  SearchMarketController searchMarketController =
      Get.put(SearchMarketController());
  BookAppointmentController bookAppointment =
      Get.put(BookAppointmentController());
}

/// app ////
///
///

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
    // setupInteractedMessage();

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Got a message whilst in the foreground!');
    //   print('Message data: ${message.data['actionButtons']}');
    //   print('Message data: ${message.data['content']}');

    //   if (message.notification != null) {
    //     print('Message also contained a notification: ${message.notification}');
    //   }
    //   // Utility.showToast(message.data['action']);
    //   //LocalNotificationService.createCallNotification(message);
    //   List<NotificationActionButton> list =
    //       jsonDecode(message.data['actionButtons'])
    //           .map<NotificationActionButton>(
    //             (actionButton) => NotificationActionButton(
    //                 key: actionButton['key'], label: actionButton['label']),
    //           )
    //           .toList();
    //   // LocalNotificationService.createCallNotification(
    //   //     jsonDecode(message.data['content']), message, list, {
    //   //   "token": "${message.data['rtcToken']}",
    //   //   "channelName": "${message.data['channelName']}"
    //   // });
    //   channelName = message.data['channelName'];
    //   channelToken = message.data['rtcToken'];
    // });

    // FirebaseMessaging.onMessageOpenedApp.listen(
    //   (message) {
    //     print("FirebaseMessaging.onMessageOpenedApp.listen");
    //     if (message.notification != null) {
    //       if (message.notification!.android!.channelId ==
    //           'basic_channel_call') {
    //         print('Calling ');
    //         Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //                 builder: (context) => VideoCallUser(
    //                     token: message.data['rtcToken'],
    //                     channel: message.data['channelName'])));
    //       }
    //     }
    //   },
    // );
    // FirebaseMessaging.instance.onTokenRefresh.listen(
    //   (token) {
    //     print("FirebaseMessaging.instance.onTokenRefresh");
    //     print('FirebaseMessaging.instance.onTokenRefresh' + token.toString());
    //   },
    // );

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

/*   Future<void> setupInteractedMessage() async {
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

  void _handleMessage(RemoteMessage message) {} */
}
