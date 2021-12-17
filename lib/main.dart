import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart' as sizer;
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/services/shared-prefrences/session-cookie.dart';
import 'package:solh/services/user/session-cookie.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

final GlobalKey<NavigatorState> globalNavigatorKey =
    GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (FirebaseAuth.instance.currentUser != null) {
    // print("user detected");
    String idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    print("*" * 30 + "\n" + "Id Token: $idToken");
    await SessionCookie.createSessionCookie(idToken);
    runApp(SplashScreen());
  } else {
    runApp(SolhApp(
      isProfileCreated: false,
    ));
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<Map<String, dynamic>> _initialAppData;

  Future<Map<String, dynamic>> _initApp() async {
    Map<String, dynamic> initialAppData = {};
    print("cejckndad a");
    initialAppData["isProfileCreated"] =
        await userBlocNetwork.isProfileCreated();
    print("completed");

    return initialAppData;
  }

  @override
  void initState() {
    super.initState();
    _initialAppData = _initApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _initialAppData,
      builder: (_, asyncSnapshot) => asyncSnapshot.hasData
          ? SolhApp(
              isProfileCreated: asyncSnapshot.requireData["isProfileCreated"],
            )
          : MaterialApp(
              home: Scaffold(
                body: Container(
                  padding: EdgeInsets.all(24.0),
                  child: Center(
                      child: Image.asset("assets/images/logo/solh-logo.png")),
                ),
              ),
            ),
    );
  }
}

class SolhApp extends StatelessWidget {
  SolhApp({Key? key, required bool isProfileCreated})
      : _isProfileCreated = isProfileCreated,
        super(key: key);

  final bool _isProfileCreated;
  final _appRouter = AppRouter(globalNavigatorKey);

  @override
  Widget build(BuildContext context) {
    return sizer.Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp.router(
        supportedLocales: [
          Locale("en"),
        ],
        localizationsDelegates: [CountryLocalizations.delegate],
        debugShowCheckedModeBanner: false,
        routerDelegate: _appRouter.delegate(
            initialDeepLink:
                _isProfileCreated ? "MasterScreen" : "IntroCarouselScreen"),
        routeInformationParser: _appRouter.defaultRouteParser(),
        title: 'Solh App',
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
