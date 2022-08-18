import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/age_controller.dart';
import 'package:solh/model/user/provider-user.dart';
import 'package:solh/ui/screens/profile-setup/profile-created.dart';
import 'package:solh/ui/screens/widgets/dropdowns/gender-selection.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

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
  final AgeController _ageController = Get.find();

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
                    initialDropdownValue: null,
                    dropDownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border: Border.all(
                          color: SolhColors.green,
                        )),
                    // dropdownValue: _dropdownValue,
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
                  DOBPicker(
                      initialDateOfBirth:
                          DateTime.now().subtract(Duration(days: 4749)),
                      boxDecoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          border: Border.all(
                            color: SolhColors.green,
                          )),
                      onChanged: (val) =>
                          Provider.of<ProviderUser>(context, listen: false)
                              .setDob = val,
                      onDateChanged: (val) {
                        Provider.of<ProviderUser>(context, listen: false)
                            .setDob = DateFormat('dd MMMM yyyy').format(val);
                        _ageController
                            .onChanged(DateFormat('dd MMMM yyyy').format(val));
                      }),
                ]),
              ),
              SolhGreenButton(
                  height: 6.h,
                  child: Text("Next"),
                  onPressed: () async {
                    widget._onNext();
                    try {
                      Provider.of<ProviderUser>(context, listen: false)
                          .updateUserDetails();
                    } catch (e) {
                      print(e);
                    } finally {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileCreated()));
                    }
                  }),
              SizedBox(
                height: 3.h,
              ),
              // SkipButton(),
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

class DOBPicker extends StatelessWidget {
  DOBPicker({
    Key? key,
    Function(String)? onChanged,
    required DateTime initialDateOfBirth,
    required BoxDecoration boxDecoration,
    required this.onDateChanged,
  })  : _onChanged = onChanged,
        _boxDecoration = boxDecoration,
        _initialDateOfBirth = initialDateOfBirth,
        super(key: key);

  final Function(String)? _onChanged;
  final Function(DateTime) onDateChanged;
  final DateTime _initialDateOfBirth;
  final AgeController ageController = Get.find();
  BoxDecoration _boxDecoration = BoxDecoration();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showCupertinoModalPopup(
            context: context,
            builder: (BuildContext builder) {
              return Container(
                height: MediaQuery.of(context).copyWith().size.height * 0.25,
                color: Colors.white,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: onDateChanged,
                  initialDateTime: DateTime.now(),
                  minimumYear: 1960,
                  maximumYear: 2030,
                ),
              );
            });
      },
      child: Container(
        height: 6.1.h,
        width: MediaQuery.of(context).size.width / 1.1,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: _boxDecoration,
        alignment: Alignment.centerLeft,
        child: Obx(() => Text(
              ageController.selectedAge.value,
              style: TextStyle(
                fontSize: 2.5.h,
                fontWeight: FontWeight.w500,
              ),
            )),
        // child: DateTimePicker(
        //   initialValue: _initialDateOfBirth.toString(),
        //   initialDate: DateTime.now().subtract(Duration(days: 4749)),
        //   style: SolhTextStyles.ProfileMenuGreyText,
        //   firstDate: DateTime(1900),
        //   lastDate: DateTime.now().subtract(Duration(days: 4749)),
        //   dateLabelText: 'Date',
        //   onChanged: _onChanged,
        //   decoration: InputDecoration(border: InputBorder.none),
        //   validator: (val) {
        //     print(val);
        //     return null;
        //   },
        //   onSaved: (val) => print(val),
        // )
      ),
    );
  }
}
