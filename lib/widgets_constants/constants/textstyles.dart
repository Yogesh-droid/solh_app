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
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w400,
    height: 1.23, //Figma Line Height 29.57
  );

  //First Time Landing Page

  static TextStyle LandingTitleText = TextStyle(
    fontSize: 24,
    color: SolhColors.primary_green,
    fontWeight: FontWeight.w400,
    height: 1.23, //Figma Line Height 29.57
  );

  static const TextStyle LandingParaText = TextStyle(
    fontSize: 16,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w400,
    height: 1.23, //Figma Line Height 17.25
  );

  static const TextStyle LargeNameText = TextStyle(
    fontSize: 20,
    color: SolhColors.black34,
    fontWeight: FontWeight.w400,
    height: 1.23, //Figma Line Height 17.25
  );

  static const TextStyle LandingButtonHeaderText = TextStyle(
    fontSize: 14,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w300,
    height: 1.23, //Figma Line Height 17.25
  );

  static const TextStyle ToggleParaText = TextStyle(
    fontSize: 16,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w400,
    height: 1.23, //Figma Line Height 19.71
  );

  static TextStyle ToggleLinkText = TextStyle(
    fontSize: 16,
    color: SolhColors.primary_green,
    fontWeight: FontWeight.w400,
    height: 1.23, //Figma Line Height 19.71
  );

  // Journaling
  static const TextStyle JournalingHintText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFFA6A6A6),
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

  static TextStyle JournalingBadgeText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: SolhColors.primary_green,
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
      color: SolhColors.dark_grey,
      height: 1.25,
      letterSpacing: 0.1 //Figma Line Height 19.71
      );

  static TextStyle JournalingDescriptionReadMoreText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: SolhColors.primary_green,
    height: 1.23, //Figma Line Height 19.71
  );

  static const TextStyle JournalingPostMenuText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: SolhColors.dark_grey,
    height: 1.23, //Figma Line Height 19.71
  );

  // Buttons

  static TextStyle GreenBorderButtonText = TextStyle(
    fontSize: 14,
    color: SolhColors.primary_green,
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

  static TextStyle SOSGreenHeading =
      TextStyle(color: SolhColors.primary_green, fontSize: 20);

  static TextStyle mostUpvoted = TextStyle(
    fontSize: 15,
    color: SolhColors.primary_green,
    fontWeight: FontWeight.w500,
    height: 1.25, //Figma Line Height 17.25
  );

  static const SOSGreyText =
      TextStyle(fontSize: 16, color: SolhColors.black666);

  static const ProfileMenuGreyText =
      TextStyle(fontSize: 16, color: SolhColors.black666);

  static const ProfileSetupSubHeading =
      TextStyle(color: Color(0xFFA6A6A6), fontSize: 16);

  ///second version of text styles starts from here
  static TextStyle LargeGreenTextS32W7 = TextStyle(
    fontSize: 32,
    color: SolhColors.primary_green,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle Large2BlackTextS24W7 = TextStyle(
    fontSize: 24,
    color: SolhColors.black666,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle Large2TextWhiteS24W7 = TextStyle(
    fontSize: 24,
    color: SolhColors.white,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle NormalTextBlackS14W5 = TextStyle(
    fontSize: 14,
    color: SolhColors.black166,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle NormalTextBlack2S14W6 = TextStyle(
    fontSize: 14,
    color: SolhColors.black53,
    fontWeight: FontWeight.w600,
  );

  static TextStyle NormalTextGreenS14W5 = TextStyle(
    fontSize: 14,
    color: SolhColors.primary_green,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle NormalTextWhiteS14W5 = TextStyle(
    fontSize: 14,
    color: SolhColors.white,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle NormalTextWhiteS14W6 = TextStyle(
    fontSize: 14,
    color: SolhColors.white,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle NormalTextGreyS14W5 = TextStyle(
    fontSize: 14,
    color: SolhColors.grey,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle SmallTextGrey1S12W5 = TextStyle(
    fontSize: 12,
    color: SolhColors.grey7E,
    fontWeight: FontWeight.w500,
  );
  static TextStyle SmallTextGreen1S12W5 = TextStyle(
    fontSize: 12,
    color: SolhColors.primary_green,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle SmallTextWhiteS12W7 = TextStyle(
    fontSize: 12,
    color: SolhColors.white,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle appTextWhiteS12W7 = TextStyle(
    fontSize: 16,
    color: SolhColors.white,
    fontWeight: FontWeight.w700,
  );

  //////// .   new styles //////////
  ///
  static const TextStyle QS_head_1 = TextStyle(
    fontSize: 96,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle QS_head_2 = TextStyle(
    fontSize: 60,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle QS_head_3 = TextStyle(
    fontSize: 48,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle QS_head_4 = TextStyle(
    fontSize: 32,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle QS_head_4_1 = TextStyle(
    fontSize: 32,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w800,
  );
  static const TextStyle QS_head_5 = TextStyle(
    fontSize: 24,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle QS_big_body = TextStyle(
    fontSize: 20,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle QS_body_1_bold = TextStyle(
    fontSize: 16,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle QS_body_semi_1 = TextStyle(
    fontSize: 16,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle QS_body_1_med = TextStyle(
    fontSize: 16,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle CTA = TextStyle(
    fontSize: 14,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle QS_body_2 = TextStyle(
    fontSize: 14,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle QS_body_2_bold = TextStyle(
    fontSize: 14,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle QS_body_2_semi = TextStyle(
    fontSize: 14,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle QS_caption = TextStyle(
    fontSize: 12,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle QS_cap_semi = TextStyle(
    fontSize: 12,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle QS_caption_bold = TextStyle(
    fontSize: 12,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle QS_cap_2 = TextStyle(
    fontSize: 10,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle Caption_2_semi = TextStyle(
    fontSize: 10,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle QS_cap_2_semi = TextStyle(
    fontSize: 10,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle QS_caption_2_bold = TextStyle(
    fontSize: 10,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle QS_big_body_med_20 = TextStyle(
    fontSize: 20,
    color: SolhColors.dark_grey,
    fontWeight: FontWeight.w500,
  );
}
