import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/services/controllers/otp_verification_controller.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/assets-path.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import '../../../services/firebase/auth.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  String? _countryCode = '+91';
  String? country = 'IN';
  late FocusNode _focusNode;
  late TextEditingController _phoneController;
  OtpVerificationController _otpVerificationController = Get.put(
    OtpVerificationController(),
  );

  bool _hintShown = false;

  void _signInWithPhone(String phoneNo, String country) {
    print(phoneNo);
    _otpVerificationController.isLoading.value = true;
    setState(() {});
    FirebaseNetwork().signInWithPhoneNumber(phoneNo,
        onCodeSent: (String verificationId) => setState(() {
              _otpVerificationController.isLoading.value = false;
            }));
  }

  Future<void> saveCountryToPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('userCountry', country ?? '');
  }

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _focusNode = FocusNode();
    saveCountryToPrefs();
    // _focusNode.addListener(() async {
    //   if (_focusNode.hasFocus && !_hintShown) {
    //     _hintShown = true;
    //     scheduleMicrotask(() {
    //       _askPhoneHint();
    //     });
    //   }
    // });
  }

  // Future<void> _askPhoneHint() async {
  //   String? hint = await _autoFill.hint;
  //   if (hint != null) {
  //     _phoneController.value =
  //         TextEditingValue(text: hint.substring(hint.length - 10, hint.length));
  //   }
  //   print(_phoneController.value.text);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppBar(
        primaryTitle: 'Signup/Login',
        secondaryTitle: 'Please enter your phone number',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.2,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(AssetPaths.introNumonic),
                  Container(
                    height: MediaQuery.of(context).size.height / 6.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SolhCountryCodePicker(
                            onCountryChange: (CountryCode countryCode) async {
                          print(countryCode.dialCode);
                          print(countryCode.name);
                          print(countryCode.code);
                          _countryCode = countryCode.dialCode;
                          country = countryCode.code;
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          await sharedPreferences.setString(
                              'userCountry', country ?? '');
                        }),
                        Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height / 15,
                          child: TextField(
                            scrollPadding: EdgeInsets.only(bottom: 150),
                            focusNode: _focusNode,
                            autofillHints: [AutofillHints.telephoneNumber],
                            textAlignVertical: TextAlignVertical.bottom,
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            onSubmitted: (value) {
                              _signInWithPhone(
                                  '$_countryCode$value', country ?? '');
                            },
                            decoration: InputDecoration(
                                hintText: " Phone No.",
                                hintStyle: TextStyle(),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)))),
                          ),
                        ),
                        // TextField(
                        //     // keyboardType: TextInputType,
                        //     onSubmitted: (value) {
                        //
                        // }),
                      ],
                    ),
                  ),
                  Obx(() {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _otpVerificationController.isLoading.value
                            ? CircularProgressIndicator()
                            : Container(
                                height: 5.8.h,
                                width: 80.w,
                                child: TextButton(
                                  onPressed: () async {
                                    print(country);
                                    print("Phone no: " +
                                        _countryCode! +
                                        _phoneController.text);
                                    if (_phoneController.text.trim() == '') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Enter a valid phone No.')));
                                    } else {
                                      _signInWithPhone(
                                          "${_countryCode.toString()}${_phoneController.text}",
                                          country ?? '');
                                    }
                                  },
                                  child: Text(
                                    "Continue",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SolhCountryCodePicker extends StatelessWidget {
  const SolhCountryCodePicker({
    Key? key,
    required Function(CountryCode) onCountryChange,
  })  : _onCountryChange = onCountryChange,
        super(key: key);

  final Function(CountryCode) _onCountryChange;

  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      showFlag: true,
      builder: (CountryCode? countryCode) {
        return Container(
          height: MediaQuery.of(context).size.height / 15,
          decoration: BoxDecoration(
              border: Border.all(color: SolhColors.black166),
              borderRadius: BorderRadius.all(Radius.circular(4))),
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height / 60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${countryCode!.dialCode}(${countryCode.name})',
                style: TextStyle(color: SolhColors.green),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: SolhColors.green,
              )
            ],
          ),
        );
      },
      showDropDownButton: true,
      showFlagDialog: true,
      showFlagMain: false,

      onChanged: _onCountryChange,
      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
      initialSelection: 'IN',
      // optional. Shows only country name and flag when popup is closed.
      showOnlyCountryWhenClosed: false,
      showCountryOnly: false,
      // optional. aligns the flag and the Text left
      alignLeft: true,
    );
  }
}
