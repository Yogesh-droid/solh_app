import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class TestQuestionsPage extends StatefulWidget {
  TestQuestionsPage({Key? key, this.id, this.testTitle}) : super(key: key);
  String? id;
  String? testTitle;

  @override
  State<TestQuestionsPage> createState() => _TestQuestionsPageState();
}

class _TestQuestionsPageState extends State<TestQuestionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
    );
  }

  SolhAppBar getAppbar() {
    return SolhAppBar(
      isLandingScreen: false,
      title: Text(
        widget.testTitle ?? '',
        style: SolhTextStyles.AppBarText,
      ),
    );
  }
}
