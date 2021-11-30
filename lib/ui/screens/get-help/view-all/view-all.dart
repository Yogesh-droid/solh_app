import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class ViewAllScreen extends StatelessWidget {
  const ViewAllScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F8),
      appBar: SolhAppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Consultants",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            Text(
              "27 Consultants",
              style: TextStyle(fontSize: 15, color: Color(0xFFA6A6A6)),
            )
          ],
        ),
        isLandingScreen: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Column(
          children: [ConsultantsTile(), ConsultantsTile(), ConsultantsTile()],
        ),
      ),
    );
  }
}

class ConsultantsTile extends StatelessWidget {
  const ConsultantsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: SolhColors.grey196.withOpacity(0.4))),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  height: 16.h,
                  width: 25.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8)),
                    child: Image.network(
                      "http://www.lacartes.com/images/business/315028/683231/l/927753.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 2.5.h,
                    width: 25.w,
                    color: Colors.white70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFFE1555A),
                          radius: 1.4.w,
                        ),
                        SizedBox(
                          width: 1.5.w,
                        ),
                        Text("Active")
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Container(
                height: 16.h,
                padding: EdgeInsets.symmetric(vertical: 1.h),
                // color: Colors.black12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr. Sakshi Trivedi",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Areas of specialization In layman language...",
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "07 Year of Experience",
                      style: TextStyle(fontSize: 12),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.people,
                                color: SolhColors.green,
                                size: 18,
                              ),
                              Text(
                                "72",
                                style: SolhTextStyles.GreenBorderButtonText,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                  "assets/icons/consultants/ratings.svg"),
                              Text(
                                "4.5",
                                style: TextStyle(color: SolhColors.green),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                                "assets/icons/consultants/review.svg"),
                            Text("07",
                                style: TextStyle(color: SolhColors.green)),
                          ],
                        )
                      ],
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "View Profile",
                          style: TextStyle(color: SolhColors.green),
                        ),
                        SolhGreenButton(
                            height: 4.8.h,
                            width: 40.w,
                            child: Text("Book Appointment"))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
