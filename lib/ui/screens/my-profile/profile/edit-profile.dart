import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class EditMyProfileScreen extends StatelessWidget {
  const EditMyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(
          "Edit Profile",
          style: SolhTextStyles.AppBarText,
        ),
        isLandingScreen: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 2.5.h,
            ),
            Container(
              child: CircleAvatar(
                radius: 14.w,
              ),
            ),
            Container(
              child: Text(""),
            ),
            TextFieldB(
              label: "Your First Name",
            ),
            TextFieldB(
              label: "Your Last Name",
            ),
            TextFieldB(
              label: "About/Bio",
              maxLine: 4,
            ),
            TextFieldB(
              label: "Phone",
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.5.h),
              child: SolhGreenButton(
                child: Text(
                  "Change No.",
                ),
                height: 6.5.h,
              ),
            ),
            TextFieldB(
              label: "Email Id",
            ),
            TextFieldB(
              label: "Gender",
            ),
            TextFieldB(
              label: "DOB",
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              child: SolhGreenButton(
                child: Text("Save Changes"),
                height: 6.5.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldB extends StatelessWidget {
  const TextFieldB({
    Key? key,
    required String label,
    String,
    int? maxLine,
  })  : _maxLine = maxLine,
        _label = label,
        super(key: key);

  final String _label;
  final int? _maxLine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _label,
            style: TextStyle(color: Color(0xFFA6A6A6)),
          ),
          Container(
            // height: 6.5.h,
            child: TextField(
              decoration: InputDecoration(border: OutlineInputBorder()),
              maxLines: _maxLine,
              style: TextStyle(),
            ),
          ),
        ],
      ),
    );
  }
}
