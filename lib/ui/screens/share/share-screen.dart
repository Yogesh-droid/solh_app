import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solh/ui/screens/share/journaling.dart';
import 'package:solh/ui/screens/widgets/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        Row(
          children: [
            SvgPicture.asset(
              "assets/icons/app-bar/app-bar-menu.svg",
              width: 26,
              height: 24,
              color: SolhColors.green,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width/20,
              ),
              child: Text(
                "Journaling",
                style: SolhTextStyles.AppBarText,
                ),
            ),
          ],
        ),
        true,
      ),
      body: Journaling(),
      // body: Center(
      //     child: Container(
      //   child: Text("Share Screen of the Application",
      //       textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
      // )),
    );
  }
}
