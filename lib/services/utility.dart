import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

import '../widgets_constants/constants/colors.dart';

class Utility {
  static String getCurrentTime() {
    DateTime now = new DateTime.now();
    return now.toString();
  }

  static void showSnackBar(
      GlobalKey<ScaffoldState> scaffoldKey, String message) {
    ScaffoldMessenger.of(scaffoldKey.currentState!.context)
        .showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showLoader(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: MyLoader(),
          );
        });
  }

  static void hideLoader(BuildContext context) {
    Navigator.pop(context);
  }

  static void createOverlay(BuildContext context) {
    Overlay.of(context)!.insert(OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      print(size.width);
      return Positioned(
        width: 56,
        height: 56,
        top: size.height - 72,
        left: size.width - 72,
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () => print('ON TAP OVERLAY!'),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SolhColors.green,
              ),
              child: Icon(Icons.video_camera_front_rounded),
            ),
          ),
        ),
      );
    }));
  }
}
