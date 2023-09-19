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
