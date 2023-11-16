import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class AddressTextField extends StatelessWidget {
  const AddressTextField(
      {super.key,
      required this.textEditingController,
      this.focusNode,
      this.onValidate,
      this.onFieldSubmitted,
      this.IsEnabled,
      this.textInputType,
      this.initialValue,
      required this.label});
  final TextEditingController textEditingController;
  final String label;
  final FocusNode? focusNode;
  final String? Function(String? value)? onValidate;
  final Function(String value)? onFieldSubmitted;
  final bool? IsEnabled;
  final TextInputType? textInputType;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        validator: onValidate,
        onFieldSubmitted: onFieldSubmitted,
        enabled: IsEnabled,
        cursorColor: Colors.black,
        keyboardType: textInputType,
        decoration: InputDecoration(
          fillColor: SolhColors.grey_3,
          filled: true,
          labelText: label,
          labelStyle: SolhTextStyles.QS_caption_bold,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
