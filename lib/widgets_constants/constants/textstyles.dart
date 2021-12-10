import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class SolhTextStyles {
  //Universal

  static const TextStyle UniversalText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.23, //Figma Line Height 17.25
  );

  static const TextStyle AppBarText = TextStyle(
    fontSize: 24,
    color: SolhColors.grey102,
    fontWeight: FontWeight.w400,
    height: 1.23, //Figma Line Height 29.57
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

  // Journaling

  static const TextStyle JournalingHintText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: SolhColors.grey,
    height: 1.23, //Figma Line Height 17.25
  );

  static const TextStyle JournalingUsernameText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: SolhColors.black34,
    height: 1.23, //Figma Line Height 19.71
  );

  static const TextStyle JournalingTimeStampText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: SolhColors.grey,
    height: 1.23, //Figma Line Height 14.78
  );

  static const TextStyle JournalingBadgeText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: SolhColors.green,
    height: 1.23, //Figma Line Height 14.78
  );

  static const TextStyle JournalingHashtagText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: SolhColors.pink224,
    height: 1.23, //Figma Line Height 17.25
  );

  static const TextStyle JournalingDescriptionText = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: SolhColors.grey102,
      height: 1.25,
      letterSpacing: 0.1 //Figma Line Height 19.71
      );

  static const TextStyle JournalingDescriptionReadMoreText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: SolhColors.green,
    height: 1.23, //Figma Line Height 19.71
  );

  static const TextStyle JournalingPostMenuText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: SolhColors.grey102,
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

  static const TextStyle SOSGreenHeading =
      TextStyle(color: SolhColors.green, fontSize: 20);

  static const TextStyle mostUpvoted = TextStyle(
    fontSize: 15,
    color: SolhColors.green,
    fontWeight: FontWeight.w500,
    height: 1.25, //Figma Line Height 17.25
  );

  static const SOSGreyText =
      TextStyle(fontSize: 16, color: SolhColors.black666);

  static const ProfileMenuGreyText =
      TextStyle(fontSize: 16, color: SolhColors.black666);

  static const ProfileSetupSubHeading =
      TextStyle(color: Color(0xFFA6A6A6), fontSize: 16);
}
