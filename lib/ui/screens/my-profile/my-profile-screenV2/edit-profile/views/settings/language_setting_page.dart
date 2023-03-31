import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class LanguageSettingPage extends StatelessWidget {
  const LanguageSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(isLandingScreen: false, title: Text('Language')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: ListView(children: [
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () async {
              Get.updateLocale(const Locale('en', 'us'));
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.setString("locale", jsonEncode({"en": "us"}));
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.master, (route) => true);
            },
            child: getSettingOptions(
                SvgPicture.asset('assets/images/eng_lang.svg'),
                "English",
                null),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () async {
              Get.updateLocale(const Locale('hi', 'IN'));
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.setString("locale", jsonEncode({"hi": "IN"}));
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.master, (route) => true);
            },
            child: getSettingOptions(
                SvgPicture.asset('assets/images/hindi_lang.svg'),
                "हिंदी",
                null),
          ),
        ]),
      ),
    );
  }
}

Widget getSettingOptions(
  Widget icon,
  String option,
  String? subText,
) {
  return InkWell(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
          color: SolhColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: SolhColors.grey_3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              icon,
              SizedBox(
                width: 6,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: subText == null
                        ? const EdgeInsets.all(6.0)
                        : const EdgeInsets.all(0.0),
                    child: Text(
                      option,
                      style: SolhTextStyles.QS_body_2_bold,
                    ),
                  ),
                  subText != null
                      ? Text(
                          subText,
                          style: SolhTextStyles.QS_cap_2,
                        )
                      : const SizedBox()
                ],
              )
            ],
          ),
          // Icon(
          //   Icons.arrow_forward_ios_sharp,
          //   color: SolhColors.Grey_1,
          //   size: 15,
          // ),
        ],
      ),
    ),
  );
}
