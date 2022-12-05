import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/sos/sos-sent.dart';
import 'package:solh/ui/screens/sos/sos.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class SOSTriggerDialog extends StatelessWidget {
  const SOSTriggerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        height: MediaQuery.of(context).size.height / 4,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
              "Trigger SOS",
              style: SolhTextStyles.SOSGreenHeading,
            ),
            SizedBox(height: 0.8.h),
            Text(
              "Are you sure you want to trigger SOS?",
              style: SolhTextStyles.SOSGreyText,
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SolhGreenBorderButton(
                    width: 40.w,
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog(context: context, builder: (_) => SOSDialog());
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: SolhColors.primary_green),
                    )),
                SolhGreenButton(
                    width: 40.w,
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog(
                          context: context, builder: (_) => SOSSentDialog());
                    },
                    child: Text("Confirm"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
