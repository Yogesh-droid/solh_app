import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class AppointmentMenu extends StatelessWidget {
  const AppointmentMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(''),
        isLandingScreen: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(children: [
          SizedBox(
            height: 14,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.appointmentPage, arguments: {});
            },
            child: getMenuOption(
                Icon(
                  CupertinoIcons.calendar,
                  color: SolhColors.primary_green,
                ),
                'My Appointments',
                'with Clinician'),
          ),
          SizedBox(
            height: 14,
          ),
          getMenuOption(
              Icon(
                Icons.self_improvement_outlined,
                color: SolhColors.primary_green,
              ),
              'Allied Packages ',
              'Yoga, dance, etc'),
          SizedBox(
            height: 14,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.profileTransfer);
            },
            child: getMenuOption(
                Icon(
                  CupertinoIcons.person_circle,
                  color: SolhColors.primary_green,
                ),
                'Profile Transfers ',
                'One consultant to other'),
          ),
        ]),
      ),
    );
  }
}

Widget getMenuOption(
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
          Icon(
            Icons.arrow_forward_ios_sharp,
            color: SolhColors.Grey_1,
            size: 15,
          ),
        ],
      ),
    ),
  );
}
