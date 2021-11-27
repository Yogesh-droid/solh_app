import 'package:flutter/material.dart';
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
      height: 20.h,
      margin: EdgeInsets.symmetric(vertical: 0.5.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: SolhColors.grey196.withOpacity(0.4))),
      child: Container(
        height: 18.h,
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
                  height: 15.h,
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
            SizedBox(width: 2.w),
            Container(
                width: 60.w,
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
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
                          Row(
                            children: [
                              Text(
                                "4.5",
                                style: TextStyle(color: SolhColors.green),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("07",
                                  style: TextStyle(color: SolhColors.green)),
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("View Profile"),
                        SolhGreenButton(
                            height: 4.h,
                            width: 40.w,
                            child: Text("Virtual Appointment"))
                      ],
                    )
                  ],
                )),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: Text(
                "Free",
                style: TextStyle(color: SolhColors.green),
              ),
            )
          ],
        ),
      ),
    );
  }
}
