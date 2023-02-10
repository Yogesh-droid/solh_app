import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class FindHelpBar extends StatelessWidget {
  const FindHelpBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            'assets/icons/app-bar/mood-meter.svg',
          ),
          SizedBox(
            width: 3.w,
          ),
          Expanded(child: getFindHelpBar()),
          SizedBox(
            width: 3.w,
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, AppRoutes.connections),
            child: SvgPicture.asset(
              "assets/images/connections.svg",
              height: 30,
            ),
          ),
        ],
      ),
    );
  }
}

Widget getFindHelpBar() {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: SolhColors.primary_green),
      borderRadius: BorderRadius.circular(25),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: Text(
            'Find help',
            style: SolhTextStyles.QS_caption_bold,
          ),
        ),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: SolhColors.primary_green),
          child: Center(
            child: Icon(
              CupertinoIcons.arrow_right,
              color: SolhColors.white,
            ),
          ),
        )
      ],
    ),
  );
}
