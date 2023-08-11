import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class BrokenLinKErrorPage extends StatelessWidget {
  const BrokenLinKErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 3 / 2,
              child: Image.asset('assets/images/broken_link2.png'),
            ),
            Text(
              "Opps, page not found",
              style: SolhTextStyles.QS_body_1_bold,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
              child: Text(
                'The link you followed probably broken or the page has been removed.',
                style: SolhTextStyles.QS_caption,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            SolhGreenMiniButton(
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed(AppRoutes.master),
              child: Text(
                "Home",
                style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
