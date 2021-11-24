import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(
          "Connect",
          style: SolhTextStyles.AppBarText,
        ),
        isLandingScreen: true,
      ),
      body: Center(
          child: Container(
        child: Text("Connect Screen of the Application",
            textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
      )),
    );
  }
}
