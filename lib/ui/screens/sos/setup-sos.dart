import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class SetupSOSScreen extends StatelessWidget {
  const SetupSOSScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Setup SOS"),
          centerTitle: false,
          backgroundColor: ThemeData().scaffoldBackgroundColor,
          foregroundColor: Colors.black,
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(7.w),
                  child: Text(
                    "Details of the persons who will be notified immediately with just one click",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Text(
                  "Person 1",
                  style: TextStyle(color: SolhColors.green),
                ),
                SizedBox(height: 0.5.h),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Name of the person",
                      border: OutlineInputBorder()),
                ),
                SizedBox(height: 2.h),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Phone Number", border: OutlineInputBorder()),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Text(
                          "Add Another + ",
                          style: TextStyle(color: SolhColors.green),
                        ),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  initialValue: "Help me Its an Emergency",
                  maxLines: 4,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(height: 4.h),
                SolhGreenButton(
                  height: 6.h,
                  child: Text("Save Details"),
                ),
              ],
            )));
  }
}
