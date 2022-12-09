import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/profile-setupV2/profile-setup-controller/profile_setup_controller.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class LetsCreateYourProfile extends StatelessWidget {
  LetsCreateYourProfile({Key? key}) : super(key: key);

  ProfileSetupController profileSetupController =
      Get.put(ProfileSetupController());

  @override
  Widget build(BuildContext context) {
    return ScaffoldGreenWithBackgroundArt(
      appBar: SolhAppBarTanasparentOnlyBackButton(
        backButtonColor: SolhColors.white,
        onBackButton: () => Navigator.of(context).pop(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: 100.h,
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              CreateYourProfile(),
              Expanded(child: SizedBox()),
              CreateProfileButton(),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateYourProfile extends StatelessWidget {
  const CreateYourProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Let's Create your Profile",
          style: SolhTextStyles.Large2TextWhiteS24W7,
        ),
        Text(
          'Be a part of the Solh community and access all the interesting features right away.',
          textAlign: TextAlign.center,
          style: SolhTextStyles.NormalTextWhiteS14W5,
        )
      ],
    );
  }
}

class CreateProfileButton extends StatelessWidget {
  const CreateProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SolhGreenButtonWithWhiteBorder(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create Profile',
                style: SolhTextStyles.NormalTextWhiteS14W6,
              ),
              Icon(Icons.arrow_right_alt_rounded),
            ],
          ),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.nameField),
        ),
        SizedBox(
          height: 3.5.h,
        ),
        // Text(
        //   'Do it later',
        //   style: SolhTextStyles.NormalTextWhiteS14W6,
        // )
      ],
    );
  }
}
