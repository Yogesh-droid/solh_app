import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/ui/screens/my-goals/my-goals-screen.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';

class SelectGoal extends StatelessWidget {
  const SelectGoal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(
          'Select Category',
          style: GoogleFonts.signika(color: Colors.black),
        ),
        isLandingScreen: false,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: IWantToWorkOn(),
      )),
    );
  }
}
