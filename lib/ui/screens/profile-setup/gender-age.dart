import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/profile-setup/email.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/buttons/skip-button.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:date_time_picker/date_time_picker.dart';

class GenderAndAgePage extends StatefulWidget {
  const GenderAndAgePage(
      {Key? key, required VoidCallback onNext, required VoidCallback onBack})
      : _onNext = onNext,
        _onBack = onBack,
        super(key: key);

  final VoidCallback _onNext;
  final VoidCallback _onBack;

  @override
  State<GenderAndAgePage> createState() => _GenderAndAgePageState();
}

class _GenderAndAgePageState extends State<GenderAndAgePage> {
  String _dropdownValue = "M";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileSetupAppBar(
        title: "Gender & Age",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            Text(
              "Please select your gender & age group",
              style: SolhTextStyles.ProfileSetupSubHeading,
            ),
            SizedBox(
              height: 3.5.h,
            ),
            Expanded(
              child: Column(children: [
                Container(
                  height: 6.1.h,
                  width: MediaQuery.of(context).size.width / 1.1,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      border: Border.all(
                        color: SolhColors.green,
                      )),
                  child: DropdownButton(
                      isExpanded: true,
                      icon: Icon(CupertinoIcons.chevron_down),
                      iconSize: 18,
                      iconEnabledColor: SolhColors.green,
                      underline: SizedBox(),
                      value: _dropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          _dropdownValue = newValue!;
                        });
                      },
                      style: TextStyle(color: SolhColors.green),
                      items: [
                        DropdownMenuItem(
                          child: Text("Male"),
                          value: "M",
                        ),
                        DropdownMenuItem(child: Text("Female"), value: "F"),
                        DropdownMenuItem(
                          child: Text("N/A"),
                          value: "N",
                        )
                      ]),
                ),
                SizedBox(
                  height: 2.h,
                ),
                GestureDetector(
                  onTap: () {
                    DateTimePicker(
                      initialValue: '',
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      dateLabelText: 'Date',
                      onChanged: (val) => print(val),
                      validator: (val) {
                        print(val);
                        return null;
                      },
                      onSaved: (val) => print(val),
                    );
                  },
                  child: Container(
                      height: 6.1.h,
                      width: MediaQuery.of(context).size.width / 1.1,
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          border: Border.all(
                            color: SolhColors.green,
                          )),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Select DOB",
                        style: SolhTextStyles.ProfileMenuGreyText,
                      )),
                )
              ]),
            ),
            SolhGreenButton(
              height: 6.h,
              child: Text("Next"),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => EmailScreen())),
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
