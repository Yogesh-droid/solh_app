import 'package:flutter/material.dart';
import 'package:solh/ui/screens/widgets/app-bar.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(),
      body: Center(
          child: Container(
        child: Text("My Profile of the Application",
            textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
      )),
    );
  }
}
