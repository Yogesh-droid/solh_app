import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/controllers/profile/anon_controller.dart';
import 'package:solh/controllers/psychology-test/psychology_test_controller.dart';
import 'package:solh/services/firebase/local_notification.dart';
import 'controllers/chat-list/chat_list_controller.dart';
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
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  await FirebaseAnalytics.instance.logBeginCheckout(
      value: 10.0,
      currency: 'USD',
      items: [
        AnalyticsEventItem(itemName: 'abc', itemId: 'xjw73ndnw', price: 10.0),
      ],
      coupon: '10PERCENTOFF');
  await FirebaseAnalytics.instance.logLogin(
      loginMethod: 'Phone', callOptions: AnalyticsCallOptions(global: true));

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
  AppointmentController appointmentController =
      Get.put(AppointmentController());

  final moodMeterController = Get.put(MoodMeterController());
  final AnonController anonController = Get.put(AnonController());
  SearchMarketController searchMarketController =
      Get.put(SearchMarketController());
  BookAppointmentController bookAppointment =
      Get.put(BookAppointmentController());
  PsychologyTestController psychologyTestController =
      Get.put(PsychologyTestController());
  final ChatListController chatListController = Get.put(ChatListController());
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
    initDynamicLinks();
    initControllers();

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

  void initDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    print(data.toString() + '   This is data');
    print(data!.link.data.toString() + '   This is data');
    print(data.link.query.toString() + '   This is data');
    print(data.link.queryParameters.toString() + '   This is data');
    final Uri? deepLink = data.link;

    if (deepLink != null) {
      print(deepLink.path);
      print(deepLink);
      print(deepLink.data);
      // Utility.showToast(data!.link.query);
      // Navigator.pushNamed(context, deepLink.path);
    }

    FirebaseDynamicLinks.instance.onLink.listen((event) {
      // Utility.showToast(data!.link.query);
      print(deepLink.toString() + ' This is link');
      print(deepLink!.path + ' This is link');
      print(deepLink.data.toString() + ' This is link');
      print(event.utmParameters.toString() + ' This is link');

      // Navigator.pushNamed(context, event.link.path);
    }).onError((error) {
      print(error.message);
    });
  }
}
