import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/widgets/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';

class AccountPrivacyScreen extends StatelessWidget {
  const AccountPrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(
          "Account Privacy",
          style: TextStyle(color: Colors.black),
        ),
        isLandingScreen: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delete Account",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lacinia a penatibus gravida ut viverra sodales feugiat justo, tempus. Ante semper nisl vitae et faucibus amet ac. At nascetur volutpat quam.",
                    style: TextStyle(color: Color(0xFFA6A6A6), fontSize: 14),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Center(
                    child: SolhGreenButton(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: 6.5.h,
                        child: Text("Delete")),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
