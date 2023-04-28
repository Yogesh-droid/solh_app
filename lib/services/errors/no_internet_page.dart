import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/main.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/errors/controllers/error_controller.dart';
import 'package:solh/services/restart_widget.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';

class NoInternetPage extends StatelessWidget {
  NoInternetPage(
      {Key? key, required this.onRetry, this.enableRetryButton = true})
      : super(key: key);
  final VoidCallback onRetry;
  final bool enableRetryButton;
  ErrorController errorController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Center(
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
                      onPressed: onRetry,
                    )
                  : Container(),
              Obx(() {
                return errorController.isReconnecting.value
                    ? ButtonLoadingAnimation(
                        ballSizeLowerBound: 3,
                        ballSizeUpperBound: 8,
                      )
                    : Container();
              })
            ],
          ),
        ],
      ),
    );
  }
}

void connectivityCheck(context) {
  Connectivity()
      .onConnectivityChanged
      .listen((ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      globalNavigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Scaffold(
            body: NoInternetPage(
              enableRetryButton: false,
              onRetry: () {
                RestartWidget.restartApp(context);
                globalNavigatorKey.currentState!.pushNamed(AppRoutes.master);
              },
            ),
          ),
        ),
        (route) => true,
      );
    } else {
      print("Got the connection");
      Get.find<ErrorController>().isReconnecting(true);
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   backgroundColor: SolhColors.greenShade1,
      //   content: Text(
      //     "Got the connection back",
      //   ),
      //   duration: Duration(seconds: 2),
      // ));
      await RestartWidget.restartApp(context);
      globalNavigatorKey.currentState!.pushNamedAndRemoveUntil(
        AppRoutes.master,
        (route) => true,
      );
      Get.find<ErrorController>().isReconnecting(true);
    }
  });
}
