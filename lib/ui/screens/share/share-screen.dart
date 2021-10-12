import 'package:flutter/material.dart';
import 'package:solh/ui/screens/share/journaling.dart';
import 'package:solh/ui/screens/widgets/app-bar.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(),
      body: Journaling(),
      // body: Center(
      //     child: Container(
      //   child: Text("Share Screen of the Application",
      //       textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
      // )),
    );
  }
}
