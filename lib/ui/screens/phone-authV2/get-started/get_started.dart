import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key, Map<dynamic, dynamic>? args})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScaffoldWithBackgroundArt(),
    );
  }
}
