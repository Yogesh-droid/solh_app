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
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/services/firebase/local_notification.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
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

  final AnonController anonController = Get.put(AnonController());
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

  @override
  void initState() {
    // initDynamicLinks();
    initControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return sizer.Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        navigatorKey: globalNavigatorKey,
        title: 'Solh Wellness',
        initialRoute:
            widget._isProfileCreated ? AppRoutes.master : AppRoutes.introScreen,
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: GoogleFonts.signika().fontFamily,
          inputDecorationTheme: InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: SolhColors.green, width: 2))),
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
        ),
      );
    });
  }
}
