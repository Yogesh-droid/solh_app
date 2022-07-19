import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets_constants/appbars/app-bar.dart';
import '../../../widgets_constants/buttons/custom_buttons.dart';
import '../../../widgets_constants/constants/textstyles.dart';

class UserTypeScreen extends StatelessWidget {
  UserTypeScreen({Key? key, required VoidCallback onNext})
      : _onNext = onNext,
        super(key: key);
  final VoidCallback _onNext;
  final TextEditingController _firstnameEditingController =
      TextEditingController();
  final TextEditingController _lastnameEditingController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileSetupAppBar(
        title: "Select the one most related to you",
        onBackButton: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            Text(
              "What do you want people to call you?",
              style: SolhTextStyles.ProfileSetupSubHeading,
            ),
            SizedBox(
              height: 3.5.h,
            ),
            SolhGreenButton(
                height: 6.h,
                child: Text("Next"),
                onPressed: () {
                  _onNext();
                })
          ],
        ),
      ),
    );
  }
}
