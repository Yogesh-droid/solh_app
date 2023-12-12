import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

import '../ui/screens/my-profile/my-profile-screenV2/my_profile_screenV2.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find();
    return Container(
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MyProfileScreenV2()));
          },
          child: Obx(() {
            return profileController.isProfileLoading.value
                ? Center(
                    child: SizedBox(
                        height: 15, width: 15, child: MyLoader(strokeWidth: 2)),
                  )
                : profileController.myProfileModel.value.body == null
                    ? InkWell(
                        onTap: () {
                          profileController.getMyProfile();
                        },
                        splashColor: Colors.transparent,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: SolhColors.primary_green),
                          child: const Icon(
                            Icons.refresh_rounded,
                            color: SolhColors.white,
                            size: 20,
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 4.w,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 3.8.w,
                          backgroundImage: CachedNetworkImageProvider(
                            profileController.myProfileModel.value.body!.user!
                                    .profilePicture ??
                                "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y",
                          ),
                        ),
                      );
          }),

          // bottomNavigatorController.isDrawerOpen.value
          //     ? bottomNavigatorController.isDrawerOpen.value = false
          //     : bottomNavigatorController.isDrawerOpen.value = true;
          // bottomNavigatorController.isDrawerOpen.value
          //     ? animationController.forward()
          //     : animationController.reverse();

          // ------------------------- Above comment for opening side drawer  -------------------------//

          // child: Container(
          //     decoration: BoxDecoration(shape: BoxShape.circle),
          //     height: 40,
          //     width: 40,
          //     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          //     child: Icon(
          //       Icons.account_circle_outlined,
          //       color: SolhColors.primary_green,
          //     )),
        ));
  }
}
