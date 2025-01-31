import 'dart:convert';

import 'package:feature_discovery/feature_discovery.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
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
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/bottom-navigation/bottom_navigator_controller.dart';
import 'package:solh/controllers/getHelp/allied_controller.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/controllers/getHelp/consultant_controller.dart';
import 'package:solh/controllers/profile/anon_controller.dart';
import 'package:solh/core/di/get_it_imports.dart';
import 'package:solh/features/lms/core/di/course_di_imports.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/firebase/local_notification.dart';
import 'package:solh/ui/screens/home/home_controller.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/default_org.dart';
import 'package:solh/widgets_constants/constants/languages_constant.dart';
import 'package:solh/widgets_constants/constants/locale.dart';
import 'package:solh/widgets_constants/constants/org_only_setting.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

import 'controllers/chat-list/chat_list_controller.dart';
import 'controllers/getHelp/search_market_controller.dart';
import 'controllers/profile/profile_controller.dart';
import 'firebase_options.dart';
import 'services/shared_prefrences/shared_prefrences_singleton.dart';
import 'ui/screens/live_stream/live-stream-controller.dart/live_stream_controller.dart';
import 'ui/screens/products/core/di/produts_di_imports.dart';

GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  Stripe.publishableKey = dotenv.env['STRIPE_PK'] ?? '';
  setup();

  productControllerSetup();
  courseControllerSetup();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  LocalNotification.initOneSignal();

  await Prefs.init();
  // await FirebaseAnalytics.instance.logBeginCheckout();
  var instance = await SharedPreferences.getInstance();
  String? cachedJson = await instance.getString('sessionCookie');

  // bool? newUser = await isNewUser();
  // Map<String, dynamic> initialAppData = await initApp();
  bool isProfileCreated = cachedJson != null ? true : false;

  // await initialAppData["isProfileCreated"] && !newUser;
  if (isProfileCreated) {
    userBlocNetwork.updateSessionCookie =
        jsonDecode(cachedJson)['details']['sessionCookie'];
  }

  await DefaultOrg.getDefaultOrg();
  await OrgOnlySetting.getOrgOnly();

  runApp(SolhApp(isProfileCreated: isProfileCreated));

  FlutterNativeSplash.remove();
}

// ignore: must_be_immutable
class SolhApp extends StatefulWidget {
  SolhApp({super.key, this.isProfileCreated});
  bool? isProfileCreated;

  @override
  State<SolhApp> createState() => _SolhAppState();
}

class _SolhAppState extends State<SolhApp> {
  @override
  void initState() {
    //checkConnectivity();
    Get.put(SearchMarketController());
    Get.put(ProfileController());
    Get.put(AlliedController());
    Get.put(HomeController());
    Get.put(BottomNavigatorController());
    Get.put(LiveStreamController());
    Get.put(ConsultantController());
    Get.put(BookAppointmentController());
    super.initState();
  }

  String? utm_medium;
  String? utm_source;
  String? utm_name;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> init() async {
    await initControllers();
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
    debugPrint("Build Solh");
    return sizer.Sizer(builder: (context, orientation, deviceType) {
      return FeatureDiscovery(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: globalNavigatorKey,
          locale: AppLocale.appLocale,
          translations: Languages(),
          fallbackLocale: const Locale('en', 'US'),
          title: 'Solh Wellness',
          initialRoute: widget.isProfileCreated!
              ? AppRoutes.master
              : AppRoutes.getStarted,
          onGenerateRoute: RouteGenerator.generateRoute,
          navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
          theme: ThemeData(
            useMaterial3: false,
            progressIndicatorTheme: const ProgressIndicatorThemeData(
                color: SolhColors.primary_green),
            textTheme: const TextTheme(
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
              thumbColor:
                  MaterialStateProperty.all<Color>(SolhColors.primary_green),
              trackColor: MaterialStateProperty.all<Color>(SolhColors.grey_3),
            ),
            scaffoldBackgroundColor: Colors.white,
            fontFamily: GoogleFonts.quicksand().fontFamily,
            primaryColor: SolhColors.primary_green,
            buttonTheme: const ButtonThemeData(buttonColor: SolhColors.white),
            iconTheme: const IconThemeData(color: Colors.black),
          ),
        ),
      );
    });
  }

  Future<void> initControllers() async {
    if (widget.isProfileCreated!) {
      Get.put(BottomNavigatorController());

      Get.put(BottomNavigatorController());
      Get.put(ChatListController());

      Get.put(AnonController());
    }
  }

  Future<bool> checkConnectivity() async {
    ProfileController profileController = Get.find();
    if (profileController.myProfileModel.value.body == null) {
      await profileController.getMyProfile();
    }
    init();
    getLoacale();
    LocalNotification().initializeOneSignalHandlers(globalNavigatorKey);
    return widget.isProfileCreated!;
  }
}
