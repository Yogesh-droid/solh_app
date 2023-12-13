import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/phone-authV2/phone-auth-controller/phone_auth_controller.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';

class CreateMpinScren extends StatelessWidget {
  CreateMpinScren({super.key, required Map<dynamic, dynamic> args})
      : _phoneNumber = args["phoneNumber"];

  final String _phoneNumber;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController pin1Controller = TextEditingController();
  final TextEditingController pin2Controller = TextEditingController();
  final PhoneAuthController phoneAuthController = Get.find();
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundArt(
      appBar: SolhAppBarTanasparentOnlyBackButton(
        onBackButton: () => Navigator.of(context).pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Set Up mPIN',
                style: SolhTextStyles.Large2BlackTextS24W7,
              ),
              Text(
                'Please enter your 4 digit pin',
                style:
                    SolhTextStyles.QS_body_2.copyWith(color: SolhColors.grey),
              ),
              const SizedBox(
                height: 32,
              ),
              const Text(
                'Enter mPIN',
                style: SolhTextStyles.QS_body_2_semi,
              ),
              const SizedBox(
                height: 10,
              ),
              PinCodeTextField(
                controller: pin1Controller,
                validator: (value) {
                  if (value?.trim() == '') {
                    return "Field can't be empty";
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
                controller: pin2Controller,
                validator: (value) {
                  if (pin1Controller.text != pin2Controller.text) {
                    return "Pin not matched";
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
                    shape: PinCodeFieldShape.box,
                    selectedColor: SolhColors.primary_green),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SolhGreenButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool response = await phoneAuthController.createMpin(
                              _phoneNumber, pin1Controller.text);

                          if (response) {
                            if (context.mounted) {
                              Navigator.of(context).pushNamed(AppRoutes.master);
                            } else {
                              SolhSnackbar.error(
                                  'Error', "unable to create pin");
                            }
                          }
                        }
                      },
                      width: 70.w,
                      child: Text('Create mPIN',
                          style: SolhTextStyles.CTA
                              .copyWith(color: SolhColors.white))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
