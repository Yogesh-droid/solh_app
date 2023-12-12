import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

// ignore: must_be_immutable
class GenderSelectionDropdown extends StatefulWidget {
  const GenderSelectionDropdown({
    super.key,
    BoxDecoration? dropDownDecoration,
    String? initialDropdownValue,
    Function(String?)? newValue,
  })  : _newValue = newValue,
        _dropDownDecoration = dropDownDecoration,
        _initialDropdownValue = initialDropdownValue;

  final String? _initialDropdownValue;
  final Function(String?)? _newValue;
  final BoxDecoration? _dropDownDecoration;

  @override
  // ignore: library_private_types_in_public_api
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
          icon: const Icon(CupertinoIcons.chevron_down),
          iconSize: 18,
          iconEnabledColor: SolhColors.primary_green,
          underline: const SizedBox(),
          hint: const Text(
            'Select Gender',
            style: SolhTextStyles.ProfileMenuGreyText,
          ),
          value: _dropdownValue,
          onChanged: (newValue) {
            setState(() {
              _dropdownValue = newValue.toString();
            });
            widget._newValue!.call(newValue.toString());
          },
          style: const TextStyle(color: SolhColors.primary_green),
          items: const [
            DropdownMenuItem(
              value: "Male",
              child: Text("Male"),
            ),
            DropdownMenuItem(value: "Female", child: Text("Female")),
            DropdownMenuItem(
              value: "Others",
              child: Text("Others"),
            ),
            DropdownMenuItem(
              value: "N/A",
              child: Text("Select Gender"),
            )
          ]),
    );
  }
}
