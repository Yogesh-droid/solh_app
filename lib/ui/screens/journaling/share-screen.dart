import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/journaling/journaling.dart';
import 'package:solh/ui/screens/widgets/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/app-bar/app-bar-menu.svg",
              width: 26,
              height: 24,
              color: SolhColors.green,
            ),
            SizedBox(
              width: 2.h,
            ),
            Text(
              "Journaling",
              style: SolhTextStyles.AppBarText,
            ),
          ],
        ),
        isLandingScreen: true,
      ),
      body: Journaling(),
    );
  }
}
