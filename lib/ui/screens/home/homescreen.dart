import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Solh App"),
      ),
      body: Center(
          child: Container(
        child: Text("Root of the Application", style: TextStyle(fontSize: 24)),
      )),
    );
  }
}
