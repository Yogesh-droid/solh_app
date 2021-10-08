import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:sizer/sizer.dart' as sizer;

void main() {
  runApp(SolhApp());
}

class SolhApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return sizer.Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate:
            _appRouter.delegate(initialDeepLink: "IntroCrouselScreen"),
        routeInformationParser: _appRouter.defaultRouteParser(),
        title: 'Anah Ecommerce',
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
