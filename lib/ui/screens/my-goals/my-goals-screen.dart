import 'package:flutter/material.dart';
import 'package:solh/ui/screens/widgets/app-bar.dart';

class MyGoalsScreen extends StatelessWidget {
  const MyGoalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(),
      body: Center(
          child: Container(
        child: Text("My Goals Screen of the Application",
            textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
      )),
    );
  }
}
