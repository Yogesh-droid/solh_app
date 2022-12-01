import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart' as sizer;
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/controllers/profile/age_controller.dart';
import 'package:solh/controllers/profile/anon_controller.dart';
import 'package:solh/init-app.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/firebase/local_notification.dart';
import 'package:solh/ui/screens/phone-authV2/phone-auth-controller/phone_auth_controller.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'controllers/chat-list/chat_list_controller.dart';
import 'controllers/profile/profile_controller.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> globalNavigatorKey =
    GlobalKey<NavigatorState>();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  LocalNotification.initOneSignal();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  await FirebaseAnalytics.instance.logBeginCheckout();
  if (FirebaseAuth.instance.currentUser != null) {
    bool? newUser = await isNewUser();

    Map<String, dynamic> _initialAppData = await initApp();
    runApp(RestartWidget(
        child: SolhApp(
      isProfileCreated: _initialAppData["isProfileCreated"] && !newUser,
    )));
    LocalNotification().initializeOneSignalHandlers(globalNavigatorKey);
  } else
    runApp(RestartWidget(
        child: SolhApp(
      isProfileCreated: false,
    )));

  FlutterNativeSplash.remove();
}

////////   required controllers are initialized here ///////////
Future<void> initControllers() async {
  ProfileController profileController = Get.put(ProfileController());
  await profileController.getMyProfile();
  final AgeController ageController = Get.put(AgeController());

  var _chatListController = Get.put(ChatListController());
  print('init Controllers');
  PhoneAuthController phoneAuthController = Get.put(PhoneAuthController());
  print('phoneAuthController');
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
  @override
  void initState() {
    // initDynamicLinks();
    initControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return sizer.Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        navigatorKey: globalNavigatorKey,
        title: 'Solh Wellness',
        initialRoute:
            widget._isProfileCreated ? AppRoutes.master : AppRoutes.getStarted,
        //initialRoute: AppRoutes.introScreen,
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: ThemeData(
          //using textTheme only for rich text ,else use constant text Styles
          textTheme: TextTheme(
            bodyText2: TextStyle(
              color: SolhColors.black666,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            headline1: TextStyle(
              color: SolhColors.black53,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            bodyText1: TextStyle(
                color: SolhColors.black666,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                decoration: TextDecoration.underline),
          ),

          scaffoldBackgroundColor: Colors.white,
          fontFamily: GoogleFonts.quicksand().fontFamily,
          primaryColor: SolhColors.green,

          primarySwatch: Colors.green,
          buttonTheme: ButtonThemeData(buttonColor: SolhColors.white),
          iconTheme: IconThemeData(color: Colors.black),
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
        ),
      );
    });
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
