import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/ui/screens/journaling/side_drawer.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/image_container.dart';

class MyProfileScreenV2 extends StatelessWidget {
  MyProfileScreenV2({Key? key}) : super(key: key);

  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScaffoldWithBackgroundArt(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        ImageWithProgressBarAndBadge(
                            imageRadius: Size(30.w, 30.w),
                            percent: 40,
                            imageUrl: profileController.myProfileModel.value
                                .body!.user!.profilePicture!),
                      ],
                    ),
                  ),
                ],
              ),
              NameUsertypeBio(
                name: 'Name of the Person',
                bio: 'Complete Your Profile',
                userType: 'SolhProvider',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NameUsertypeBio extends StatelessWidget {
  NameUsertypeBio({Key? key, this.name = '', this.userType = '', this.bio = ''})
      : super(key: key);

  final String name;
  final String userType;
  final String bio;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style:
              SolhTextStyles.QS_body_1_med.copyWith(color: SolhColors.black666),
        ),
        GetBadge(userType: userType),
        Text(bio),
      ],
    );
  }
}
