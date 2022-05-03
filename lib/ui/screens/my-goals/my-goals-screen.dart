import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class MyGoalsScreen extends StatelessWidget {
  const MyGoalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(
          "Goals",
          style: SolhTextStyles.AppBarText,
        ),
        isLandingScreen: true,
      ),
      body: Center(
          child: Container(
        child: Text("My Goals Screen of the Application",
            textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
      )),
    );
  }
}
