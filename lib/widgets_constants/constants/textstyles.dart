import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class SolhTextStyles{

  //Universal

  static const TextStyle UniversalText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.23, //Figma Line Height 17.25
  );

  //First Time Landing Page

  static const TextStyle LandingTitleText = TextStyle(
    fontSize: 24,
    color: SolhColors.green,
    fontWeight: FontWeight.w400, 
    height: 1.23, //Figma Line Height 29.57
  );

  static const TextStyle LandingParaText = TextStyle(
    fontSize: 16,
    color: SolhColors.grey102,
    fontWeight: FontWeight.w400, 
    height: 1.23, //Figma Line Height 17.25
  );

  static const TextStyle LandingButtonHeaderText = TextStyle(
    fontSize: 14,
    color: SolhColors.grey102,
    fontWeight: FontWeight.w300, 
    height: 1.23, //Figma Line Height 17.25
  );

  static const TextStyle ToggleParaText = TextStyle(
    fontSize: 16,
    color: SolhColors.grey102,
    fontWeight: FontWeight.w400, 
    height: 1.23, //Figma Line Height 19.71
  );

  static const TextStyle ToggleLinkText = TextStyle(
    fontSize: 16,
    color: SolhColors.green,
    fontWeight: FontWeight.w400, 
    height: 1.23, //Figma Line Height 19.71
  );

  // Buttons

  static const TextStyle GreenBorderButtonText = TextStyle(
    fontSize: 14,
    color: SolhColors.green,
    fontWeight: FontWeight.w400,
    height: 1.23, //Figma Line Height 17.25
  );

  static const TextStyle PinkBorderButtonText = TextStyle(
    fontSize: 14,
    color: SolhColors.pink224,
    fontWeight: FontWeight.w400, //Figma Line Height 17.25
    height: 1.23,
  );

  static const TextStyle GreenButtonText = TextStyle(
    fontSize: 14,
    color: SolhColors.white,
    fontWeight: FontWeight.w400,
    height: 1.23, //Figma Line Height 17.25
  );

  static const TextStyle PinkButtonText = TextStyle(
    fontSize: 14,
    color: SolhColors.white,
    fontWeight: FontWeight.w400, 
    height: 1.23, //Figma Line Height 17.25
  );

}