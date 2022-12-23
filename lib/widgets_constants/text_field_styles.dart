import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

/*
  F= Focus color
  UF= unfocus color
  R = border radius 
*/
class TextFieldStyles {
  // static InputDecoration greenF_greyUF_4R({String? hintText}) {
  //   return InputDecoration(
  //       fillColor: SolhColors.white,
  //       filled: true,
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(4),
  //         borderSide: BorderSide(color: SolhColors.primary_green),
  //       ),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(4),
  //         borderSide: BorderSide(color: SolhColors.grey_3),
  //       ),
  //       hintText: hintText,
  //       hintStyle: SolhTextStyles.NormalTextBlackS14W5);

  static InputDecoration greenF_greenBroadUF_4R({String? hintText}) {
    return InputDecoration(
        fillColor: SolhColors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: SolhColors.primary_green, width: 3),
        ),
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(4),
        //   borderSide: BorderSide(color: SolhColors.primary_green),
        // ),
        hintText: hintText,
        hintStyle: SolhTextStyles.NormalTextBlackS14W5);
  }

  static InputDecoration greenF_noBorderUF_4R({String? hintText}) {
    return InputDecoration(
        fillColor: SolhColors.light_Bg,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: SolhColors.primary_green, width: 1.5),
        ),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: SolhTextStyles.NormalTextBlackS14W5);
  }

  static InputDecoration greenF_greyUF_4R = InputDecoration(
      fillColor: SolhColors.white,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: SolhColors.primary_green),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: SolhColors.grey_3),
      ),
      hintText: '',
      hintStyle: SolhTextStyles.NormalTextBlackS14W5);
}


/* import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

/*
  F= Focus color
  UF= unfocus color
  R = border radius 
*/
class TextFieldStyles {
  // static InputDecoration greenF_greyUF_4R({String? hintText}) {
  //   return InputDecoration(
  //       fillColor: SolhColors.white,
  //       filled: true,
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(4),
  //         borderSide: BorderSide(color: SolhColors.primary_green),
  //       ),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(4),
  //         borderSide: BorderSide(color: SolhColors.grey_3),
  //       ),
  //       hintText: hintText,
  //       hintStyle: SolhTextStyles.NormalTextBlackS14W5);

  static InputDecoration greenF_greenBroadUF_4R({String? hintText}) {
    return InputDecoration(
        fillColor: SolhColors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: SolhColors.primary_green, width: 3),
        ),
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(4),
        //   borderSide: BorderSide(color: SolhColors.primary_green),
        // ),
        hintText: hintText,
        hintStyle: SolhTextStyles.NormalTextBlackS14W5);
  }

  static InputDecoration greenF_noBorderUF_4R({String? hintText}) {
    return InputDecoration(
        fillColor: SolhColors.light_Bg,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: SolhColors.primary_green, width: 1.5),
        ),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: SolhTextStyles.NormalTextBlackS14W5);
  }

  static InputDecoration greenF_greyUF_4R = InputDecoration(
      fillColor: SolhColors.white,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: SolhColors.primary_green),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: SolhColors.grey_3),
      ),
      hintText: '',
      hintStyle: SolhTextStyles.NormalTextBlackS14W5);
}
 */