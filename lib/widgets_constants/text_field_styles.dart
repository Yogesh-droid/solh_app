import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

/*
  F= Focus color
  UF= unfocus color
  R = border radius 
*/
class TextFieldStyles {
  static InputDecoration greenF_greyUF_4R({String? hintText}) {
    return InputDecoration(
        fillColor: SolhColors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: SolhColors.green),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: SolhColors.grey102),
        ),
        hintText: hintText,
        hintStyle: SolhTextStyles.NormalTextBlackS14W5);
  }

  static InputDecoration greenF_greenBroadUF_4R({String? hintText}) {
    return InputDecoration(
        fillColor: SolhColors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: SolhColors.green, width: 3),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: SolhColors.green),
        ),
        hintText: hintText,
        hintStyle: SolhTextStyles.NormalTextBlackS14W5);
  }
}
