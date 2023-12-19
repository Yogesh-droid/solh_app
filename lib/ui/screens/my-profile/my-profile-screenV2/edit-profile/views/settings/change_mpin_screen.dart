import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/settings/setting-controller/setting_controller.dart';
import 'package:solh/ui/screens/phone-authV2/phone-auth-controller/phone_auth_controller.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';
import 'package:timeago/timeago.dart';

class ChangeMpinScreen extends StatefulWidget {
  ChangeMpinScreen({super.key});

  @override
  State<ChangeMpinScreen> createState() => _ChangeMpinScreenState();
}

class _ChangeMpinScreenState extends State<ChangeMpinScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController currentPinController = TextEditingController();

  final TextEditingController newPinController = TextEditingController();

  final TextEditingController confirmPinController = TextEditingController();

  final SettingController settingController = Get.find();

  final PhoneAuthController phoneAuthController =
      Get.put(PhoneAuthController());

  final ProfileController profileController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkIfUserPinExist();
    });

    super.initState();
  }

  Future<void> checkIfUserPinExist() async {
    showDialog(
        context: context,
        builder: (context) {
          return MyLoader();
        });

    bool response = await phoneAuthController.isMpinSet(
        profileController.myProfileModel.value.body!.user!.mobile ?? '');
    print(response);
    if (!response) {
      phoneAuthController.countryCode = '';
      phoneAuthController.phoneNumber.text =
          profileController.myProfileModel.value.body!.user!.mobile ?? '';
      print(phoneAuthController.phoneNumber.text);

      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.createMpinScreen);
      }
    } else {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundArt(
      appBar: SolhAppBarTanasparentOnlyBackButton(
          onBackButton: () => Navigator.pop(context)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Change mPin',
                style: SolhTextStyles.Large2BlackTextS24W7,
              ),
              const SizedBox(
                height: 32,
              ),
              const Text(
                'Enter current mPIN',
                style: SolhTextStyles.QS_body_2_semi,
              ),
              const SizedBox(
                height: 10,
              ),
              PinCodeTextField(
                obscureText: true,
                controller: currentPinController,
                mainAxisAlignment: MainAxisAlignment.start,
                validator: (value) {
                  if (value?.trim() == '') {
                    return "Field can't be empty";
                  }
                  return null;
                },
                appContext: context,
                length: 4,
                keyboardType: TextInputType.number,
                separatorBuilder: (a, b) {
                  return SizedBox(
                    width: 20,
                  );
                },
                pinTheme: PinTheme(
                    inactiveColor: SolhColors.grey_2,
                    borderWidth: 1,
                    borderRadius: BorderRadius.circular(8),
                    activeColor: SolhColors.primary_green,
                    shape: PinCodeFieldShape.box,
                    selectedColor: SolhColors.primary_green),
              ),
              const Text(
                'Set new mPIN',
                style: SolhTextStyles.QS_body_2_semi,
              ),
              const SizedBox(
                height: 10,
              ),
              PinCodeTextField(
                obscureText: true,
                controller: newPinController,
                mainAxisAlignment: MainAxisAlignment.start,
                separatorBuilder: (a, b) {
                  return SizedBox(
                    width: 20,
                  );
                },
                validator: (value) {
                  if (newPinController.text.trim().isEmpty) {
                    return 'Field can\'t be empty';
                  }
                  return null;
                },
                appContext: context,
                length: 4,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                    inactiveColor: SolhColors.grey_2,
                    borderWidth: 1,
                    borderRadius: BorderRadius.circular(8),
                    activeColor: SolhColors.primary_green,
                    shape: PinCodeFieldShape.box,
                    selectedColor: SolhColors.primary_green),
              ),
              const Text(
                'Confirm mPIN',
                style: SolhTextStyles.QS_body_2_semi,
              ),
              const SizedBox(
                height: 10,
              ),
              PinCodeTextField(
                controller: confirmPinController,
                mainAxisAlignment: MainAxisAlignment.start,
                separatorBuilder: (a, b) {
                  return SizedBox(
                    width: 20,
                  );
                },
                validator: (value) {
                  if (confirmPinController.text.trim().isEmpty) {
                    return 'Field can\'t be empty';
                  }

                  if (newPinController.text.trim() !=
                      confirmPinController.text.trim()) {
                    return '';
                  }
                  return null;
                },
                appContext: context,
                length: 4,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                    inactiveColor: SolhColors.grey_2,
                    borderWidth: 1,
                    activeColor: SolhColors.primary_green,
                    borderRadius: BorderRadius.circular(8),
                    shape: PinCodeFieldShape.box,
                    selectedColor: SolhColors.primary_green),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    return settingController.isChangingPin.value
                        ? const ButtonLoadingAnimation()
                        : SolhGreenButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                (bool, String) response =
                                    await settingController.changeMpin(
                                        currentPinController.text.trim(),
                                        newPinController.text.trim());

                                if (response.$1) {
                                  SolhSnackbar.success('Success', response.$2);
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                } else {
                                  SolhSnackbar.error('Error', response.$2);
                                }
                              }
                            },
                            width: 70.w,
                            child: Text('Change mPIN',
                                style: SolhTextStyles.CTA
                                    .copyWith(color: SolhColors.white)));
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
