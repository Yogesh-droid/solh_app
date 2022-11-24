import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class GenderSelectionDropdown extends StatefulWidget {
  GenderSelectionDropdown({
    Key? key,
    BoxDecoration? dropDownDecoration,
    String? initialDropdownValue,
    Function(String?)? newValue,
  })  : _newValue = newValue,
        _dropDownDecoration = dropDownDecoration,
        _initialDropdownValue = initialDropdownValue,
        super(key: key);

  String? _initialDropdownValue;
  Function(String?)? _newValue;
  BoxDecoration? _dropDownDecoration;

  @override
  _GenderSelectionDropdownState createState() =>
      _GenderSelectionDropdownState();
}

class _GenderSelectionDropdownState extends State<GenderSelectionDropdown> {
  String? _dropdownValue;

  @override
  void initState() {
    _dropdownValue = widget._initialDropdownValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.1.h,
      width: MediaQuery.of(context).size.width / 1.1,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: widget._dropDownDecoration,
      child: DropdownButton(
          isExpanded: true,
          icon: Icon(CupertinoIcons.chevron_down),
          iconSize: 18,
          iconEnabledColor: SolhColors.green,
          underline: SizedBox(),
          hint: Text(
            'Select Gender',
            style: SolhTextStyles.ProfileMenuGreyText,
          ),
          value: _dropdownValue ?? null,
          onChanged: (newValue) {
            setState(() {
              _dropdownValue = newValue.toString();
            });
            widget._newValue!.call(newValue.toString());
          },
          style: TextStyle(color: SolhColors.green),
          items: [
            DropdownMenuItem(
              child: Text("Male"),
              value: "Male",
            ),
            DropdownMenuItem(child: Text("Female"), value: "Female"),
            DropdownMenuItem(
              child: Text("Others"),
              value: "Others",
            )
          ]),
    );
  }
}
