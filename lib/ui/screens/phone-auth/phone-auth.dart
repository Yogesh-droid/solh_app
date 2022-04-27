import 'dart:async';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/assets-path.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import '../../../constants/api.dart';
import '../../../services/firebase/auth.dart';
import '../../../services/network/network.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  String? _countryCode = '+91';
  late FocusNode _focusNode;
  late TextEditingController _phoneController;

  bool _hintShown = false;
  final SmsAutoFill _autoFill = SmsAutoFill();

  void _signInWithPhone(String phoneNo) {
    print(phoneNo);
    FirebaseNetwork().signInWithPhoneNumber(phoneNo,
        onCodeSent: (String verificationId) => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() async {
      if (_focusNode.hasFocus && !_hintShown) {
        _hintShown = true;
        scheduleMicrotask(() {
          _askPhoneHint();
        });
      }
    });
  }

  Future<void> _askPhoneHint() async {
    String? hint = await _autoFill.hint;
    _phoneController.value = TextEditingValue(text: hint!.substring(3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppBar(
        primaryTitle: 'SignUp/LogIn',
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
                            onCountryChange: (CountryCode countryCode) {
                          print(countryCode.dialCode);
                          _countryCode = countryCode.dialCode;
                        }),
                        Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height / 15,
                          child: TextField(
                            focusNode: _focusNode,
                            autofillHints: [AutofillHints.telephoneNumber],
                            textAlignVertical: TextAlignVertical.bottom,
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            onSubmitted: (value) {
                              _signInWithPhone('$_countryCode$value');
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 5.8.h,
                        width: 80.w,
                        child: TextButton(
                          onPressed: () async {
                            print("Phone no: " +
                                _countryCode! +
                                _phoneController.text);
                            _signInWithPhone(
                                "${_countryCode.toString()}${_phoneController.text}");
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
                  ),
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
