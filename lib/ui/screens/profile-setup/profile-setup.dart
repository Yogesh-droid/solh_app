import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/profile-setup/enter-full-name.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class CreateProfileScreen extends StatelessWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 3.h,
          ),
          CircleAvatar(
            radius: 53,
            backgroundColor: SolhColors.primary_green,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              radius: 52,
              child: Icon(
                Icons.person,
                color: SolhColors.primary_green,
                size: 60,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Create Profile",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 0.5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.4.w),
            child: Text(
              "Create your profile to be a part of the Solh community. Please fill genuine details and you can also create an anonymous profile further.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, color: Color.fromRGBO(166, 166, 166, 1)),
            ),
          ),
          Expanded(child: Container()),
          SolhGreenButton(
              width: MediaQuery.of(context).size.width / 1.1,
              height: 6.h,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => EnterFullNameScreen()));
              },
              child: Text("Continue")),
          SizedBox(
            height: 2.5.h,
          ),
          // Text(
          //   "Skip",
          //   style: TextStyle(color: SolhColors.green),
          // ),
          Container(
            height: 10.h,
          )
        ],
      ),
    );
  }
}
