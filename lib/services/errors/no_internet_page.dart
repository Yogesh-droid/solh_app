import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class NoInternetPage extends StatelessWidget {
  NoInternetPage(
      {Key? key, required this.onRetry, this.enableRetryButton = true})
      : super(key: key);
  final VoidCallback onRetry;
  final bool enableRetryButton;
  // ErrorController errorController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/connectionError.png'),
            Text(
              'check your Internet Connection or try again later',
              style: SolhTextStyles.ToggleParaText,
              textAlign: TextAlign.center,
            ),
            Column(
              children: [
                SizedBox(
                  height: 3.h,
                ),
                enableRetryButton
                    ? SolhGreenMiniButton(
                        width: 30.w,
                        child: Text(
                          'TRY AGAIN',
                          style: SolhTextStyles.GreenButtonText,
                        ),
                        onPressed: () {
                          Connectivity()
                              .checkConnectivity()
                              .then((result) async {
                            print(result.toString());
                            if ((result != ConnectivityResult.none)) {
                              Navigator.pop(context);
                              onRetry();
                            }
                          });
                        },
                      )
                    : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// void connectivityCheck(context) {
//   log("connectivity check run");
//   Connectivity()
//       .onConnectivityChanged
//       .listen((ConnectivityResult result) async {
//     log("connectivity check run ${result}");
//     if (result == ConnectivityResult.none) {
//       globalNavigatorKey.currentState!.pushAndRemoveUntil(
//         MaterialPageRoute(
//           builder: (context) => Scaffold(
//             body: NoInternetPage(
//               enableRetryButton: false,
//               onRetry: () {
//                 RestartWidget.restartApp(
//                     globalNavigatorKey.currentState!.context);
//                 // globalNavigatorKey.currentState!.pushNamed(AppRoutes.master);
//               },
//             ),
//           ),
//         ),
//         (route) => true,
//       );
//     } else {
//       print("Got the connection");
//       // Get.find<ErrorController>().isReconnecting(true);
//       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       //   backgroundColor: SolhColors.greenShade1,
//       //   content: Text(
//       //     "Got the connection back",
//       //   ),
//       //   duration: Duration(seconds: 2),
//       // ));
//       // await RestartWidget.restartApp(context);
//       // globalNavigatorKey.currentState!.pushNamedAndRemoveUntil(
//       //   AppRoutes.master,
//       //   (route) => true,
//       // );
//       Get.delete<JournalPageController>();

//       // Get.delete<AlliedController>();
//       Get.delete<GetHelpController>();
//       Get.delete<ErrorController>();
//       Get.delete<ChatListController>();
//       Get.delete<ConnectionController>();

//       RestartWidget.restartApp(globalNavigatorKey.currentState!.context);

//       if (await Prefs.getBool('isProfileCreated') != null) {
//         globalNavigatorKey.currentState!.pushNamedAndRemoveUntil(
//           AppRoutes.master,
//           (route) => true,
//         );
//       } else {
//         globalNavigatorKey.currentState!.pushNamedAndRemoveUntil(
//           AppRoutes.getStarted,
//           (route) => true,
//         );
//       }

//       // Get.find<ErrorController>().isReconnecting(false);
//     }
//   });
// }
