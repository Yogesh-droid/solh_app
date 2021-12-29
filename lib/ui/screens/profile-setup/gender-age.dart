import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/model/user/provider-user.dart';
import 'package:solh/ui/screens/profile-setup/profile-created.dart';
import 'package:solh/ui/screens/widgets/dropdowns/gender-selection.dart';
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
  String _dropdownValue = "N/A";

  @override
  void initState() {
    super.initState();
    Provider.of<ProviderUser>(context, listen: false).setGender =
        _dropdownValue;
    Provider.of<ProviderUser>(context, listen: false).setDob =
        DateTime.now().subtract(Duration(days: 4749)).toString();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget._onBack();
        return false;
      },
      child: Scaffold(
        appBar: ProfileSetupAppBar(
          title: "Gender & Age",
          onBackButton: widget._onBack,
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
                  GenderSelectionDropdown(
                    dropDownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border: Border.all(
                          color: SolhColors.green,
                        )),
                    dropdownValue: _dropdownValue,
                    newValue: (String? newValue) {
                      print(newValue);
                      Provider.of<ProviderUser>(context, listen: false)
                          .setGender = newValue.toString();
                      setState(() {
                        _dropdownValue = newValue!;
                      });
                    },
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                      height: 6.1.h,
                      width: MediaQuery.of(context).size.width / 1.1,
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          border: Border.all(
                            color: SolhColors.green,
                          )),
                      alignment: Alignment.centerLeft,
                      child: DateTimePicker(
                        initialValue: DateTime.now()
                            .subtract(Duration(days: 4749))
                            .toString(),
                        initialDate:
                            DateTime.now().subtract(Duration(days: 4749)),
                        style: SolhTextStyles.ProfileMenuGreyText,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now().subtract(Duration(days: 4749)),
                        dateLabelText: 'Date',
                        onChanged: (val) =>
                            Provider.of<ProviderUser>(context, listen: false)
                                .setDob = val,
                        decoration: InputDecoration(border: InputBorder.none),
                        validator: (val) {
                          print(val);
                          return null;
                        },
                        onSaved: (val) => print(val),
                      )),
                ]),
              ),
              SolhGreenButton(
                  height: 6.h,
                  child: Text("Next"),
                  onPressed: () async {
                    widget._onNext();
                    await Provider.of<ProviderUser>(context, listen: false)
                        .updateUserDetails();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => ProfileCreated()));
                  }),
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
      ),
    );
  }
}
