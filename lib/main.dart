import 'package:flutter/material.dart';
import 'package:solh/shared_widgets_constants/buttons/default_custom_buttons.dart';
import 'package:solh/shared_widgets_constants/containers/curved_container.dart';
import 'package:solh/shared_widgets_constants/constants/textstyles.dart';

void main() {
  runApp(SolhApp());
}

class SolhApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solh App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Solh Demo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
        child: Text("Root of the Application", style: TextStyle(fontSize: 24)),
      ),
      SolhGreenBorderMiniButton(
        child: Text(
          "Test",
          style: SolhTextStyles.UniversalText,
        ),
        ),
        SolhCurvedContainer(
          child: Text(
            "Test",
            style: SolhTextStyles.UniversalText,
          ),
        ),
            ],
          )),
    );
  }
}
