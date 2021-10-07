import 'package:flutter/material.dart';
import 'package:solh/ui/screens/widgets/app-bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(),
      body: Center(
          child: Container(
        child: Text("Home Screen of the Application",
            textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
      )),
    );
  }
}
