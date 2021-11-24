import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/sos/fetching-available.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class EmergencyConsultationConsentDialog extends StatelessWidget {
  const EmergencyConsultationConsentDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.clear,
                      color: Colors.black,
                    ))
              ],
            ),
            Text(
              "Emergency Consultation",
              style: SolhTextStyles.SOSGreenHeading,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.6.h, horizontal: 4.w),
              child: Text(
                "Are you sure you want to get Emergency consultation",
                textAlign: TextAlign.center,
                style: SolhTextStyles.SOSGreyText,
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SolhGreenBorderMiniButton(
                    height: 6.h,
                    width: 40.w,
                    child: Text(
                      "No",
                      style: SolhTextStyles.GreenBorderButtonText,
                    ),
                  ),
                  SolhGreenButton(
                    height: 6.h,
                    width: 40.w,
                    child: Text("Yes"),
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (_) => FetchingAvalableConsultantsDialog());
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
