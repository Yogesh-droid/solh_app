import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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

final GlobalKey<NavigatorState> globalNavigatorKey =
    GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final AgeController ageController = Get.put(AgeController());

  if (FirebaseAuth.instance.currentUser != null) {
    String idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    print("*" * 30 + "\n" + "Id Token: $idToken");
    await SessionCookie.createSessionCookie(idToken);
    Map<String, dynamic> _initialAppData = await initApp();
    runApp(SolhApp(
      isProfileCreated: _initialAppData["isProfileCreated"],
    ));
  } else
    runApp(SolhApp(
      isProfileCreated: false,
    ));

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

class SolhApp extends StatelessWidget {
  SolhApp({Key? key, required bool isProfileCreated})
      : _isProfileCreated = isProfileCreated,
        super(key: key);

  final bool _isProfileCreated;
  final _appRouter = AppRouter(globalNavigatorKey);

  @override
  Widget build(BuildContext context) {
    return sizer.Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp.router(
        supportedLocales: [
          Locale("en"),
        ],
        localizationsDelegates: [CountryLocalizations.delegate],
        routerDelegate: _appRouter.delegate(
            initialDeepLink:
                _isProfileCreated ? "MasterScreen" : "IntroCarouselScreen"),
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
