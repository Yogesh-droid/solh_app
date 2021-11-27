import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart' as sizer;
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/services/shared-prefrences/session-cookie.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

final GlobalKey<NavigatorState> globalNavigatorKey =
    GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SolhApp());
}

class SolhApp extends StatelessWidget {
  final _appRouter = AppRouter(globalNavigatorKey);

  @override
  Widget build(BuildContext context) {
    return sizer.Sizer(builder: (context, orientation, deviceType) {
      // return MaterialApp(
      //   home: CreateProfileScreen(),
      // );
      return MaterialApp.router(
        supportedLocales: [
          Locale("en"),
        ],
        localizationsDelegates: [CountryLocalizations.delegate],
        debugShowCheckedModeBanner: false,
        routerDelegate: _appRouter.delegate(
            initialDeepLink: FirebaseAuth.instance.currentUser == null
                ? "IntroCarouselScreen"
                : "MasterScreen"),
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
          // buttonBarTheme: ButtonBarThemeData(alignment: MainAxisAlignment.center),
          inputDecorationTheme: InputDecorationTheme(),
        ),
      );
    });
  }
}
