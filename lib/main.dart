import 'dart:convert';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart' as sizer;
import 'package:solh/bottom-navigation/bottom_navigator_controller.dart';
import 'package:solh/controllers/getHelp/allied_controller.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/controllers/getHelp/consultant_controller.dart';
import 'package:solh/controllers/profile/age_controller.dart';
import 'package:solh/controllers/profile/anon_controller.dart';
import 'package:solh/init-app.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/dynamic_link_sevice/dynamic_link_provider.dart';
import 'package:solh/services/errors/controllers/error_controller.dart';
import 'package:solh/services/firebase/local_notification.dart';
import 'package:solh/services/restart_widget.dart';
import 'package:solh/ui/screens/home/home_controller.dart';
import 'package:solh/ui/screens/profile-setupV2/profile-setup-controller/profile_setup_controller.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/default_org.dart';
import 'package:solh/widgets_constants/constants/languages_constant.dart';
import 'package:solh/widgets_constants/constants/locale.dart';
import 'package:solh/widgets_constants/constants/org_only_setting.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import 'controllers/chat-list/chat_list_controller.dart';
import 'controllers/getHelp/search_market_controller.dart';
import 'controllers/profile/profile_controller.dart';
import 'firebase_options.dart';
import 'services/shared_prefrences/shared_prefrences_singleton.dart';
import 'ui/screens/live_stream/live-stream-controller.dart/live_stream_controller.dart';
import 'widgets_constants/constants/textstyles.dart';
import 'package:feature_discovery/feature_discovery.dart';

GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: '.env');
  Stripe.publishableKey = dotenv.env['STRIPE_PK'] ?? '';

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  LocalNotification.initOneSignal();

  Prefs.init();
  await FirebaseAnalytics.instance.logBeginCheckout();
  Get.put(SearchMarketController());
  Get.put(ProfileController());
  Get.put(AlliedController());
  Get.put(HomeController());
  Get.put(BottomNavigatorController());
  Get.put(LiveStreamController());
  Get.put(ConsultantController());
  Get.put(BookAppointmentController());

  runApp(RestartWidget(child: SolhApp()));

  FlutterNativeSplash.remove();
}

class SolhApp extends StatefulWidget {
  SolhApp({Key? key}) : super(key: key);

  @override
  State<SolhApp> createState() => _SolhAppState();
}

class _SolhAppState extends State<SolhApp> {
  String? utm_medium;
  String? utm_source;
  String? utm_name;
  bool? isProfileCreated;

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  @override
  void initState() {
    super.initState();
  }

  Future<void> init() async {
    await initControllers();

    await DefaultOrg.getDefaultOrg();
    await OrgOnlySetting.getOrgOnly();
  }

  Future<void> getLoacale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await prefs.getString('locale');
    if (res != null) {
      Map map = jsonDecode(res);
      AppLocale.appLocale = Locale(map.keys.first, map.values.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    return sizer.Sizer(builder: (context, orientation, deviceType) {
      return FeatureDiscovery(
        child: FutureBuilder<bool>(
          future: checkConnectivity(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MaterialApp(
                home: Scaffold(
                    body: Center(
                  child: SolhGradientLoader(),
                )),
              );
            } else if (snapshot.hasData) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: globalNavigatorKey,
                locale: AppLocale.appLocale,
                translations: Languages(),
                fallbackLocale: const Locale('en', 'US'),
                title: 'Solh Wellness',
                initialRoute:
                    snapshot.data! ? AppRoutes.master : AppRoutes.getStarted,
                onGenerateRoute: RouteGenerator.generateRoute,
                navigatorObservers: [
                  FirebaseAnalyticsObserver(analytics: analytics)
                ],
                theme: ThemeData(
                  progressIndicatorTheme: ProgressIndicatorThemeData(
                      color: SolhColors.primary_green),
                  textTheme: TextTheme(
                      bodyMedium: TextStyle(
                        color: SolhColors.black666,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      displayLarge: TextStyle(
                        color: SolhColors.black53,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      displayMedium: TextStyle(
                        color: SolhColors.primary_green,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      bodyLarge: TextStyle(
                        color: SolhColors.black666,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                      displaySmall: SolhTextStyles.QS_body_1_bold),
                  switchTheme: SwitchThemeData(
                    thumbColor: MaterialStateProperty.all<Color>(
                        SolhColors.primary_green),
                    trackColor:
                        MaterialStateProperty.all<Color>(SolhColors.grey_3),
                  ),
                  scaffoldBackgroundColor: Colors.white,
                  fontFamily: GoogleFonts.quicksand().fontFamily,
                  primaryColor: SolhColors.primary_green,
                  buttonTheme: ButtonThemeData(buttonColor: SolhColors.white),
                  iconTheme: IconThemeData(color: Colors.black),
                ),
              );
            } else {
              return MaterialApp(
                home: Scaffold(
                    body: Center(
                  child: Text("Error Page"),
                )),
              );
            }
          },
        ),
      );
    });
  }

  Future<void> initControllers() async {
    Get.put(ErrorController());
    if (isProfileCreated!) {
      Get.put(BottomNavigatorController());
      Get.put(ProfileController());
      Get.put(ProfileSetupController());
      Get.put(BottomNavigatorController());
      // await profileController.getMyProfile();
      Get.put(ChatListController());
      Get.put(ProfileSetupController());
    }
    Get.put(AnonController());
    Get.put(AgeController());
  }

  Future<bool> checkConnectivity() async {
    if (FirebaseAuth.instance.currentUser != null) {
      print("Login");
      bool? newUser = await isNewUser();
      Map<String, dynamic> _initialAppData = await initApp();
      DynamicLinkProvider.instance.initDynamicLink();
      isProfileCreated = await _initialAppData["isProfileCreated"] && !newUser;
      init();
      getLoacale();
      LocalNotification().initializeOneSignalHandlers(globalNavigatorKey);
      return isProfileCreated!;
    } else {
      print("not Login");
      return false;
    }
  }

/*   Future<void> initDynamic() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (data != null) {
      print(data.toString() + '   This is data');
      print(data.link.data.toString() + '   This is data');
      print(data.link.query.toString() + '   This is data');
      print(data.link.queryParameters.toString() + '   This is data');
      print(data.utmParameters.toString() + '   This is data');
      print('${data.utmParameters}' + '   This is UTM');
      utm_name = data.utmParameters['utm_campaign'];
      utm_source = data.utmParameters['utm_source'];
      utm_medium = data.utmParameters['utm_medium'];

      final Uri? deepLink = data.link;

      if (deepLink != null) {
        print(deepLink.path);
        print(deepLink.query);
        print(deepLink.queryParameters);
        print(deepLink);
        print(deepLink.data);
        // Utility.showToast(data!.link.query);
        // Navigator.pushNamed(context, deepLink.path);
      }

      FirebaseDynamicLinks.instance.onLink.listen((event) {
        // Utility.showToast(data!.link.query);
        if (deepLink != null) {
          print(deepLink.toString() + ' This is link');
          print(deepLink.path + ' This is link');
          print(deepLink.data.toString() + ' This is link');
          print(event.utmParameters.toString() + ' This is link');
        }

        // Navigator.pushNamed(context, event.link.path);
      }).onError((error) {
        print(error.message);
      });
    }
  } */
}
