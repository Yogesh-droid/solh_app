import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class PsychologicalCapital extends StatelessWidget {
  const PsychologicalCapital({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        isLandingScreen: false,
        title: Text('Psychological Capital'),
      ),
      body: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 3.h,
            ),
            Container(
              child: Image.asset('assets/images/capital_backgound.png'),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 7.h,
            ),
            getPointContainer()
          ],
        )
      ]),
    );
  }
}

getPointContainer() {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: SolhColors.light_Bg_2,
        ),
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Image.asset('assets/images/money2.png'),
            Text(
              '727',
              style: SolhTextStyles.QS_head_4,
            ),
            Text(
              'Your Capital',
              style: SolhTextStyles.QS_cap_semi,
            )
          ]),
        ),
      ),
      SizedBox(
        height: 1.h,
      ),
      Container(
        height: 20,
        width: 80,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              blurStyle: BlurStyle.outer,
              color: Color(0x08222222),
            ),
          ],
          color: Color(0x08222222),
          borderRadius: BorderRadius.all(Radius.elliptical(80, 20)),
        ),
      ),
      Text(
        'Your Psychological Capital',
        style: SolhTextStyles.QS_big_body,
      ),
      SizedBox(
        height: 60.w,
        child: Text(
            'This is the grand total of psychological Capital based on your Engagement on the app',
            style: SolhTextStyles.QS_caption),
      )
    ],
  );
}
