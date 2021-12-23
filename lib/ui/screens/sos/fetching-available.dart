import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class FetchingAvalableConsultantsDialog extends StatelessWidget {
  const FetchingAvalableConsultantsDialog({Key? key}) : super(key: key);

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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.clear, color: Colors.black))
              ],
            ),
            Text(
              "Fetching Available Consultants",
              style:
                  SolhTextStyles.SOSGreenHeading.copyWith(color: Colors.black),
            ),
            SizedBox(height: 4.h),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 26,
              child: MyLoader(
                strokeWidth: 2.5,
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
