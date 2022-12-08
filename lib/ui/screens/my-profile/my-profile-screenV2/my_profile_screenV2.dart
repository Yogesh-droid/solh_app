import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/journaling/side_drawer.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/edit_profile_option.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/setting.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              SizedBox(
                height: 5.h,
              ),
              Center(
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      child: EditAndSettingOption(),
                    ),
                    Container(
                      width: double.maxFinite,
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
              ),
              SizedBox(
                height: 2.h,
              ),
              NameUsertypeBio(
                name: 'Name of the Person',
                bio: 'Complete Your Profile',
                userType: 'SolhVolunteer',
              ),
              SizedBox(
                height: 2.h,
              ),
              StatsRow(),
              SizedBox(
                height: 2.h,
              ),
              YouAreAlmostThere(),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                height: 2.h,
              ),
              OptionsColumn()
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
        Text(
          bio,
          style: SolhTextStyles.QS_caption,
        ),
      ],
    );
  }
}

class StatsRow extends StatelessWidget {
  const StatsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        getStatsItem(
            Icon(
              Icons.thumb_up,
              color: SolhColors.primary_green,
              size: 18,
            ),
            '27',
            'Likes'),
        getStatsItem(
            SvgPicture.asset(
              'assets/images/connect.svg',
            ),
            '27',
            'Connections'),
        getStatsItem(
            SvgPicture.asset(
              'assets/images/post.svg',
            ),
            '17',
            'Posts'),
        getStatsItem(
            Icon(
              Icons.star,
              color: SolhColors.primary_green,
              size: 18,
            ),
            '07',
            'Reviews'),
      ],
    );
  }
}

Container getStatsItem(Widget icon, String statNumber, String stat) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
    color: SolhColors.light_Bg,
    child: Column(
      children: [
        Row(
          children: [
            icon,
            SizedBox(
              width: 2.w,
            ),
            Text(
              statNumber,
              style: SolhTextStyles.QS_body_2,
            ),
          ],
        ),
        SizedBox(
          width: 1.h,
        ),
        Text(
          stat,
          style: SolhTextStyles.QS_caption,
        )
      ],
    ),
  );
}

class YouAreAlmostThere extends StatelessWidget {
  const YouAreAlmostThere({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: SolhColors.greenShade3,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'You are almost there',
                    style: SolhTextStyles.QS_body_1_bold,
                  ),
                  SizedBox(
                    width: 40.w,
                    child: Text(
                      "Let's take your profile from good to greate. The details matter",
                      style: SolhTextStyles.QS_cap_2,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_circle_right,
              color: SolhColors.primary_green,
              size: 36,
            )
          ],
        ),
      ),
    );
  }
}

class OptionsColumn extends StatelessWidget {
  const OptionsColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getOption(
            SvgPicture.asset(
              'assets/images/post.svg',
              height: 15,
            ),
            'Posts'),
        SizedBox(
          height: 8,
        ),
        getOption(
            Icon(
              Icons.calendar_month_rounded,
              color: SolhColors.primary_green,
              size: 20,
            ),
            'My Appointments'),
        SizedBox(
          height: 8,
        ),
        getOption(
            SvgPicture.asset(
              'assets/images/wheelOfEmotions.svg',
              height: 20,
            ),
            'Wheel of Emotions'),
      ],
    );
  }
}

Container getOption(Widget icon, String option) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
            Text(
              option,
              style: SolhTextStyles.QS_body_2_bold,
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
  );
}

class EditAndSettingOption extends StatelessWidget {
  const EditAndSettingOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: (() {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditProfileOptions()));
          }),
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: SolhColors.light_Bg,
            ),
            child: Center(
              child: Icon(
                Icons.edit,
                size: 20,
                color: SolhColors.primary_green,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        InkWell(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Setting())),
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: SolhColors.light_Bg,
            ),
            child: Center(
              child: Icon(
                Icons.settings,
                color: SolhColors.primary_green,
                size: 20,
              ),
            ),
          ),
        )
      ],
    );
  }
}
