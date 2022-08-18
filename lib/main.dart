import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/controllers/profile/anon_controller.dart';
import 'package:solh/services/firebase/local_notification.dart';
import 'controllers/getHelp/search_market_controller.dart';
import 'controllers/mood-meter/mood_meter_controller.dart';
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
Future<void> backgroundMessageHandler(RemoteMessage remoteMessage) async {
  print("backgroundMessageHandler");
  print(remoteMessage.data);
  print(remoteMessage.notification!.title);
  LocalNotificationService.createanddisplaynotification(remoteMessage);
  // AwesomeNotifications().createNotification(
  //   content: NotificationContent(
  //     id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
  //     channelKey: 'basic_channel',
  //     title: '${remoteMessage.notification!.title}',
  //     body: '${remoteMessage.notification!.body}',
  //     wakeUpScreen: true,
  //     icon: 'resource://drawable/ic_launcher_round',
  //   ),
  //   actionButtons: <NotificationActionButton>[
  //     NotificationActionButton(key: 'yes', label: 'Yes'),
  //     NotificationActionButton(key: 'no', label: 'No'),
  //   ],
  // );
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  LocalNotificationService.initialize();
  //checkVersion();
  final AgeController ageController = Get.put(AgeController());

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
    print("*" * 30 + "\n" + "Id Token: $idToken");
    bool isNewUser = await SessionCookie.createSessionCookie(idToken, fcmToken);
    Map<String, dynamic> _initialAppData = await initApp();
    runApp(SolhApp(
      isProfileCreated: _initialAppData["isProfileCreated"] && !isNewUser,
    ));
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

  @override
  void initState() {
    //LocalNotificationService.initialize(context);
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");

          /// we can handle routing here
        }
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
      LocalNotificationService.createanddisplaynotification(message);
      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
    FirebaseMessaging.instance.onTokenRefresh.listen(
      (token) {
        print("FirebaseMessaging.instance.onTokenRefresh");
        print('FirebaseMessaging.instance.onTokenRefresh' + token.toString());
      },
    );

    AwesomeNotifications().actionStream.listen(
      (ReceivedAction receivedAction) {
        if (receivedAction.buttonKeyPressed == 'accept') {
          print('Accepted');
        } else if (receivedAction.buttonKeyPressed == 'reject') {
          print('Rejected');
        }

        //Here if the user clicks on the notification itself
        //without any button
      },
    );

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
}
