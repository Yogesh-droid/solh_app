import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/profile-setup/profile-created.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/buttons/skip-button.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileSetupAppBar(
        title: "Email id",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            Text(
              "Explaining in two lines why we need their Email id",
              style: SolhTextStyles.ProfileSetupSubHeading,
            ),
            SizedBox(
              height: 3.5.h,
            ),
            Expanded(
                child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      hintText: "johnconor@email.com",
                      border: OutlineInputBorder()),
                ),
              ],
            )),
            SolhGreenButton(
              height: 6.h,
              child: Text("Next"),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ProfileCreated())),
            ),
            SizedBox(
              height: 3.h,
            ),
            SkipButton(),
            SizedBox(
              height: 6.h,
            ),
          ],
        ),
      ),
    );
  }
}
