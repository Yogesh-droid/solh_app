import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import '../../../../controllers/profile/anon_controller.dart';
import '../../../../controllers/profile/profile_controller.dart';
import '../../../../widgets_constants/loader/my-loader.dart';

class AnonLandingPage extends StatelessWidget {
  AnonLandingPage({super.key});
  final AnonController anomymousController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              const Text(
                "Your profile is ready!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
              const Text(
                "If you want to maintain your privacy, select the 'Anonymous' option.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFFA6A6A6), fontSize: 16),
              ),
              SizedBox(height: 35.h),
              SolhGreenButton(
                  child: const Text("Lets Go"),
                  height: 6.h,
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (contex) {
                          return MyLoader();
                        });
                    try {
                      ProfileController profileController =
                          Get.put(ProfileController());
                      await anomymousController.createAnonProfile();
                      await profileController.getMyProfile();
                      Navigator.pop(context);
                      Navigator.pushNamed(context, AppRoutes.master);
                    } on Exception catch (e) {
                      Navigator.pop(context);
                      Utility.showToast(e.toString());
                    }
                  }),
              SizedBox(
                height: 1.h,
              ),
              // SolhGreenBorderButton(
              //   child: Text(
              //     "Create Anonymous",
              //     style: SolhTextStyles.GreenBorderButtonText,
              //   ),
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => PickUsernameScreen()));
              //   },
              //   height: 6.h,
              // ),
              SizedBox(
                height: 8.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
