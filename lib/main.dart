import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart' as sizer;
import 'package:solh/controllers/profile/age_controller.dart';
import 'package:solh/controllers/profile/anon_controller.dart';
import 'package:solh/init-app.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/firebase/local_notification.dart';
import 'package:solh/ui/screens/profile-setupV2/profile-setup-controller/profile_setup_controller.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'controllers/chat-list/chat_list_controller.dart';
import 'controllers/getHelp/search_market_controller.dart';
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

  await FirebaseAnalytics.instance.logBeginCheckout();
  final SearchMarketController searchMarketController =
      Get.put(SearchMarketController());

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
  String? utm_medium;

  String? utm_source;

  String? utm_name;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  @override
  void initState() {
    initDynamic();
    initControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return sizer.Sizer(builder: (context, orientation, deviceType) {
      print('This is First route ${widget._isProfileCreated}');
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: globalNavigatorKey,
        title: 'Solh Wellness',
        initialRoute:
            widget._isProfileCreated ? AppRoutes.master : AppRoutes.getStarted,
        // initialRoute: AppRoutes.master,
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
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
            headline2: TextStyle(
              color: SolhColors.primary_green,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            bodyText1: TextStyle(
                color: SolhColors.black666,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                decoration: TextDecoration.underline),
          ),
          switchTheme: SwitchThemeData(
            thumbColor:
                MaterialStateProperty.all<Color>(SolhColors.primary_green),
            trackColor: MaterialStateProperty.all<Color>(SolhColors.grey_3),
          ),

          scaffoldBackgroundColor: Colors.white,
          fontFamily: GoogleFonts.quicksand().fontFamily,
          primaryColor: SolhColors.primary_green,

          primarySwatch: Colors.green,
          buttonTheme: ButtonThemeData(buttonColor: SolhColors.white),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      );
    });
  }

  Future<void> initControllers() async {
    if (widget._isProfileCreated) {
      ProfileController profileController = Get.put(ProfileController());
      ProfileSetupController profileSetupController =
          Get.put(ProfileSetupController());

      // await profileController.getMyProfile();
      Get.put(ChatListController());
    }
    Get.put(AnonController());
    Get.put(AgeController());
  }

  Future<void> initDynamic() async {
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
  }
}
