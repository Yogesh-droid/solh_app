import 'package:flutter/material.dart';
import 'package:solh/ui/screens/widgets/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class GetHelpScreen extends StatelessWidget {
  const GetHelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(
          "Martket Place",
          style: SolhTextStyles.AppBarText,
        ),
        isLandingScreen: true,
      ),
      body: Center(
          child: Container(
        child: Text("Get Help",
            textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
      )),
    );
  }
}
