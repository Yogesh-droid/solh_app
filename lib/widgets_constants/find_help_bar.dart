import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class FindHelpBar extends StatelessWidget {
  const FindHelpBar(
      {super.key,
      required this.onTapped,
      required this.onConnectionTapped,
      required this.onMoodMeterTapped});
  final Function() onTapped;
  final Function() onConnectionTapped;
  final Function() onMoodMeterTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => onMoodMeterTapped(),
            child: SvgPicture.asset(
              'assets/icons/app-bar/mood-meter.svg',
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          Expanded(child: getFindHelpBar()),
          SizedBox(
            width: 3.w,
          ),
          Obx(() {
            return Get.find<ProfileController>().isProfileLoading.value
                ? MyLoader(
                    radius: 10,
                    strokeWidth: 2,
                  )
                : InkWell(
                    onTap: () => onConnectionTapped(),
                    child: SvgPicture.asset(
                      "assets/images/connections.svg",
                      height: 30,
                    ),
                  );
          }),
        ],
      ),
    );
  }

  Widget getFindHelpBar() {
    return InkWell(
      onTap: () => onTapped(),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: SolhColors.primary_green),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Text(
                'Find help'.tr,
                style: SolhTextStyles.QS_caption_bold,
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: SolhColors.primary_green),
              child: Center(
                child: Icon(
                  CupertinoIcons.arrow_right,
                  color: SolhColors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
