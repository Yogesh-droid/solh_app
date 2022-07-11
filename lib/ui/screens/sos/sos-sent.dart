import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class SOSSentDialog extends StatelessWidget {
  const SOSSentDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
            Column(
              children: [
                Text(
                  "Message Sent",
                  style: SolhTextStyles.SOSGreenHeading.copyWith(
                      color: Colors.black),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 10.w,
                //     vertical: 0.7.h,
                //   ),
                //   child: Text(
                //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Venenatis bibendum dui ipsum tellus. Porttitor id ut a in ut sed accumsan eu.",
                //     style: SolhTextStyles.SOSGreyText,
                //   ),
                // )
              ],
            ),
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
              child: SolhGreenButton(
                height: 6.h,
                child: Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
