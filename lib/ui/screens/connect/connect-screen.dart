import 'package:flutter/material.dart';
import 'package:solh/ui/screens/widgets/app-bar.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(),
      body: Center(
          child: Container(
        child: Text("Connect Screen of the Application",
            textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
      )),
    );
  }
}
