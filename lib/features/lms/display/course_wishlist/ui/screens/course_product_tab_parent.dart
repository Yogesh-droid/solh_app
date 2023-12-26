import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';

class CourseProductTabParent extends StatelessWidget {
  const CourseProductTabParent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: const Text('Youur wishlist'),
        isLandingScreen: false,
      ),
      body: const Column(
        children: [
          TabBar(tabs: [
            Tab(
              child: Text('Courses'),
            ),
            Tab(
              child: Text('Products'),
            )
          ]),
        ],
      ),
    );
  }
}
