import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/ui/screens/profile-setup/enter-full-name.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/privacy_web.dart';

import '../../../model/user/provider-user.dart';
import '../../../widgets_constants/appbars/app-bar.dart';
import '../../../widgets_constants/buttons/custom_buttons.dart';

class UserTypeScreen extends StatefulWidget {
  UserTypeScreen({Key? key, required VoidCallback onNext})
      : _onNext = onNext,
        super(key: key);
  final VoidCallback _onNext;

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _userEmailEditingController = TextEditingController();

  String radioGroupValue = 'Seeker';
  bool isTnCChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileSetupAppBar(
        title: "Select the one most related to you",
        onBackButton: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.h),
              Text(
                "You are",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 2.5.h,
              ),
              getRadioBtn(context, title: "Here to seek help", type: "Seeker"),
              SizedBox(
                height: 2.5.h,
              ),
              getRadioBtn(context,
                  title: "Here to volunteer & seek help ",
                  type: "SolhVolunteer"),
              SizedBox(
                height: 2.5.h,
              ),
              getRadioBtn(context,
                  title: "Mental health professional", type: "SolhProvider"),
              SizedBox(
                height: 2.5.h,
              ),
              getRadioBtn(context,
                  title: "Here to explore Solh", type: "Undefined"),
              radioGroupValue == 'SolhVolunteer'
                  ? getVolunteerNote()
                  : radioGroupValue == 'SolhProvider'
                      ? getProviderNote()
                      : Container(),
              SizedBox(
                height: 3.5.h,
              ),
              getTnC(),
              SizedBox(
                height: 2.5.h,
              ),
              SolhGreenButton(
                  height: 6.h,
                  child: Text("Next"),
                  onPressed: () {
                    if (isTnCChecked) {
                      if (radioGroupValue == 'Undefined') {
                        userBlocNetwork.updateUserType = 'Seeker';
                        print(' userType ${userBlocNetwork.getUserType}');
                      }
                      if (radioGroupValue == 'SolhProvider' &&
                          _userEmailEditingController.text.isEmpty) {
                        userBlocNetwork.updateUserType = 'SolhProvider';
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please enter your email"),
                          backgroundColor: Colors.red,
                        ));
                        print(' userType ${userBlocNetwork.getUserType}');
                        return;
                      }
                      Provider.of<ProviderUser>(context, listen: false)
                          .setUserType = radioGroupValue;
                      Provider.of<ProviderUser>(context, listen: false)
                          .setEmail = _userEmailEditingController.text;
                      widget._onNext();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Please accept the terms and conditions",
                        ),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  }),
              SizedBox(
                height: 4.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRadioBtn(BuildContext context,
      {required String title, required String type}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: radioGroupValue == type ? Colors.green : Colors.white,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: RadioListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: TextStyle(
            color: Color(0xFF222222),
          ),
        ),
        value: type,
        groupValue: radioGroupValue,
        onChanged: (value) {
          setState(() {
            print(value);
            radioGroupValue = value.toString();
          });
        },
      ),
    );
  }

  Widget getTnC() {
    return Row(
      children: [
        Expanded(
          child: RichText(
              text: TextSpan(
            text: "By clicking next, you agree to our ",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: SolhColors.grey,
            ),
            children: [
              TextSpan(
                  text: "Terms and Conditions",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: SolhColors.green,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrivacyWeb(
                              url: 'https://solhapp.com/termsandcondition.html',
                              title: 'Terms and condtions'),
                        ),
                      );
                    }),
            ],
          )),
        ),
        Switch(
          value: isTnCChecked,
          activeColor: SolhColors.green,
          onChanged: (value) {
            setState(() {
              isTnCChecked = value;
            });
          },
        ),
      ],
    );
  }

  Widget getVolunteerNote() {
    return Container(
      child: RichText(
          text: TextSpan(
              text: "Note :",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: SolhColors.green,
              ),
              children: [
            TextSpan(
              text:
                  "This role comes up with many important reponsibilities, our coaching manual & screening processes will guide to further.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: SolhColors.grey,
              ),
            )
          ])),
    );
  }

  Widget getProviderNote() {
    return Column(
      children: [
        Text(
          '''To complete further processes, provide email-id below. E-mail from solh will guide you further.''',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: SolhColors.grey102,
          ),
        ),
        SizedBox(
          height: 2.5.h,
        ),
        ProfielTextField(
          textEditingController: _userEmailEditingController,
          hintText: "Johnconor@email.com",
          onChanged: (value) {
            print(value);
          },
        ),
      ],
    );
  }
}
