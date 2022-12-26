import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/bottom-navigation/bottom_navigator_controller.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/chat-list/chat_list_controller.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/controllers/goal-setting/goal_setting_controller.dart';
import 'package:solh/controllers/group/create_group_controller.dart';
import 'package:solh/controllers/group/discover_group_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/notification/controller/notification_controller.dart';
import 'package:solh/ui/screens/phone-authV2/phone-auth-controller/phone_auth_controller.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

import '../../../../connections/blocked_users.dart';

class Setting extends StatelessWidget {
  Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundArt(
      appBar: SolhAppBar(
        title: Text(
          'Settings',
          style: SolhTextStyles.QS_body_1_bold,
        ),
        isLandingScreen: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(children: [
          SizedBox(
            height: 2.h,
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, AppRoutes.accountPrivacy,
                arguments: {}),
            child: getSettingOptions(
              SvgPicture.asset('assets/icons/profile/privacy.svg'),
              'Account & Privacy',
              'Delete account',
            ),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.userType,
            ),
            child: getSettingOptions(
              Icon(
                Icons.group_outlined,
                color: SolhColors.primary_green,
              ),
              'User Type',
              'Seeker, Volunteer, Provider',
            ),
          ),
          SizedBox(
            height: 15,
          ),
          // InkWell(
          //   onTap: () =>
          //       Navigator.pushNamed(context, AppRoutes.editNeedSupportOn),
          //   child: getSettingOptions(
          //     SvgPicture.asset('assets/images/other_detail.svg'),
          //     'Other detail,',
          //     'Issues, Organisation',
          //   ),
          // ),
          // SizedBox(
          //   height: 15,
          // ),
          InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => BlockedUsers())),
            child: getSettingOptions(
                SvgPicture.asset('assets/images/blocked.svg'),
                'Blocked Users',
                null),
          ),
          Expanded(child: SizedBox()),
          GetLogoutButton(),
          SizedBox(
            height: 40,
          ),
        ]),
      ),
    );
  }
}

Widget getSettingOptions(
  Widget icon,
  String option,
  String? subText,
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
                width: 6,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: subText == null
                        ? const EdgeInsets.all(6.0)
                        : const EdgeInsets.all(0.0),
                    child: Text(
                      option,
                      style: SolhTextStyles.QS_body_2_bold,
                    ),
                  ),
                  subText != null
                      ? Text(
                          subText,
                          style: SolhTextStyles.QS_cap_2,
                        )
                      : const SizedBox()
                ],
              )
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_sharp,
            color: SolhColors.Grey_1,
            size: 15,
          ),
        ],
      ),
    ),
  );
}

class GetLogoutButton extends StatelessWidget {
  const GetLogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SolhGreenBorderButton(
      backgroundColor: SolhColors.greenShade3,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          Icons.logout,
          color: SolhColors.primary_green,
          size: 20,
        ),
        SizedBox(
          width: 6,
        ),
        Text('Logout',
            style: SolhTextStyles.QS_body_2_bold.copyWith(
              color: SolhColors.Grey_1,
            )),
      ]),
      onPressed: () {
        FirebaseAuth.instance.signOut().then((value) {
          clearOneSignalID();
          Get.find<BottomNavigatorController>().activeIndex.value = 0;
          userBlocNetwork.updateSessionCookie = "";
          Get.delete<NotificationController>();
          Get.delete<ChatListController>();
          Get.delete<GoalSettingController>();
          Get.delete<PhoneAuthController>();
          Get.delete<ConnectionController>();
          Get.delete<DiscoverGroupController>();
          Get.delete<CreateGroupController>();
          Get.delete<BottomNavigatorController>();
          Get.delete<ProfileController>();

          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.getStarted, (route) => false);
        });
      },
    );
  }
}

void clearOneSignalID() {
  Network.makePutRequestWithToken(
      url: "${APIConstants.api}/api/edit-onesignal-id",
      body: {
        'onesignal_device_id': '',
      });
}
