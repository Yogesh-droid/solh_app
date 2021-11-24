import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/profile-setup/add-profile-photo.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class EnterUsernameScreen extends StatelessWidget {
  const EnterUsernameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileSetupAppBar(
        title: "Your Username",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            Text(
              "Please enter your username",
              style: SolhTextStyles.ProfileSetupSubHeading,
            ),
            SizedBox(
              height: 3.5.h,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "John Conor", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 6.h,
            ),
            SolhGreenButton(
              height: 6.h,
              child: Text("Next"),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => AddProfilePhoto())),
            )
          ],
        ),
      ),
    );
  }
}
