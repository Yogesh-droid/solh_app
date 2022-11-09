import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class ConnectScreen2 extends StatelessWidget {
  const ConnectScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: SolhAppBar(
        isLandingScreen: false,
        title: Text(
          'Connect',
          style: SolhTextStyles.AppBarText,
        ),
      ),
    ));
  }
}
