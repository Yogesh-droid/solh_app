import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/intro/intro-crousel.dart';
import 'package:solh/ui/screens/profile-setup/gender-age.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class DescriptionScreen extends StatelessWidget {
  const DescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileSetupAppBar(
        title: "Description",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            Text(
              "Tell others little bit about yourself",
              style: SolhTextStyles.ProfileSetupSubHeading,
            ),
            SizedBox(
              height: 3.5.h,
            ),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                  hintText: "Add Description(Optional)",
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 6.h,
            ),
            SolhGreenButton(
              height: 6.h,
              child: Text("Next"),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => GenderAndAge())),
            ),
            SizedBox(
              height: 6.h,
            ),
            SkipButton(),
          ],
        ),
      ),
    );
  }
}
