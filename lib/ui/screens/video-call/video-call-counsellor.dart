import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/model/doctor.dart';
import 'package:solh/ui/screens/get-help/view-all/consultants.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoCallCounsellor extends StatefulWidget {
  const VideoCallCounsellor({Key? key}) : super(key: key);

  @override
  _VideoCallCounsellorState createState() => _VideoCallCounsellorState();
}

class _VideoCallCounsellorState extends State<VideoCallCounsellor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(
          "Counsellor Video Assistance",
          style: SolhTextStyles.AppBarText,
        ),
        isLandingScreen: false,
        isVideoCallScreen: true,
      ),
      body: Container(
        child: ListView(
          children: [
            VideoAssistanceConsultantsTile(),
            VideoAssistanceConsultantsTile(),
            VideoAssistanceConsultantsTile()
          ],
        ),
      ),
    );
  }
}

class VideoAssistanceConsultantsTile extends StatelessWidget {
  const VideoAssistanceConsultantsTile({
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
                      "https://e7.pngegg.com/pngimages/1001/748/png-clipart-doctor-raising-right-hand-illustration-physician-hospital-medicine-doctor-s-office-health-doctor-s-child-face.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Container(
                height: 16.h,
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr. Aakriti",
                      style: TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Expanded(
                      child: Container(
                        width: 100.w,
                        child: Text(
                          "available",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF666666),
                              fontWeight: FontWeight.w300),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SolhGreenButton(
                          height: 4.2.h,
                          width: 40.w,
                          child: Text("Book Appointment"),
                          onPressed: () {
                            launch("tel://8447838327");
                          },
                        )
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
