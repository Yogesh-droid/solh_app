import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({Key? key, required this.onRetry}) : super(key: key);
  final Function() onRetry;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView(
      children: [
        Image.asset('assets/images/connectionError.png'),
        Text(
          'check your Internet Connection or try again later',
          style: SolhTextStyles.ToggleParaText,
          textAlign: TextAlign.center,
        ),
        Column(
          children: [
            SizedBox(
              height: 3.h,
            ),
            SolhGreenMiniButton(
              width: 30.w,
              child: Text(
                'TRY AGAIN',
                style: SolhTextStyles.GreenButtonText,
              ),
              onPressed: onRetry,
            ),
          ],
        )
      ],
    ));
  }
}
