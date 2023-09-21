import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/settings/setting.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class EditProfileOptions extends StatelessWidget {
  EditProfileOptions({Key? key}) : super(key: key);
  final ProfileController _profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundArt(
      appBar: SolhAppBar(
        title: Text(
          'Edit Profile'.tr,
          style: SolhTextStyles.QS_body_1_bold,
        ),
        isLandingScreen: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () =>
                Navigator.pushNamed(context, AppRoutes.editProfilePage),
            child: getOptions(
              Icon(
                Icons.person,
                color: SolhColors.primary_green,
              ),
              'Personal Details'.tr,
              'Name, age, gender'.tr,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          _profileController.myProfileModel.value.body!.user!.anonymous != null
              ? InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, AppRoutes.editAnonymousProfile),
                  child: getOptions(
                    SvgPicture.asset('assets/images/anon_glasses.svg'),
                    'Anonymous profile'.tr,
                    'Name, Avatar'.tr,
                  ),
                )
              : Container(),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () =>
                Navigator.pushNamed(context, AppRoutes.editNeedSupportOn),
            child: getSettingOptions(
              SvgPicture.asset('assets/images/other_detail.svg'),
              'Other Detail'.tr,
              'Issues, Organization'.tr,
            ),
          ),
        ]),
      ),
    );
  }
}

Widget getOptions(
  Widget icon,
  String option,
  String subText,
) {
  return InkWell(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
          color: SolhColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: SolhColors.grey_3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              SizedBox(
                width: 4,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option,
                    style: SolhTextStyles.QS_body_2_bold,
                  ),
                  Text(
                    subText,
                    style: SolhTextStyles.QS_cap_2,
                  )
                ],
              )
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_sharp,
            color: SolhColors.Grey_1,
            size: 15,
          )
        ],
      ),
    ),
  );
}
