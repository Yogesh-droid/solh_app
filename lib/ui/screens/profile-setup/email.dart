import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:provider/provider.dart';
import 'package:solh/model/user/provider-user.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/profile-setup/profile-created.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/buttons/skip-button.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

import '../../../widgets_constants/constants/colors.dart';

class EmailScreen extends StatefulWidget {
  EmailScreen(
      {Key? key, required VoidCallback onNext, required VoidCallback onBack})
      : _onNext = onNext,
        _onBack = onNext,
        super(key: key);

  final VoidCallback _onNext;
  final VoidCallback _onBack;

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  TextEditingController emailController = TextEditingController();
  bool isEmailCorrect = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileSetupAppBar(
        title: "Email id",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            Text(
              "Enter your email for future correspondence and account recovery",
              textAlign: TextAlign.center,
              style: SolhTextStyles.ProfileSetupSubHeading,
            ),
            SizedBox(
              height: 3.5.h,
            ),
            Expanded(
                child: Column(
              children: [
                TextFormField(
                  onChanged: ((value) {
                    isEmailCorrect = emailVarification(value);
                    setState(() {});
                  }),
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "johnconor@email.com",
                      border: OutlineInputBorder()),
                ),
              ],
            )),
            isEmailCorrect
                ? SolhGreenButton(
                    height: 6.h,
                    child: Text("Next"),
                    onPressed: () {
                      Provider.of<ProviderUser>(context, listen: false)
                          .setEmail = emailController.text;
                      widget._onNext();
                    })
                : greyButton(),
            SizedBox(
              height: 3.h,
            ),
            InkWell(
              child: Text(
                'Skip',
                style: SolhTextStyles.GreenBorderButtonText,
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
          ],
        ),
      ),
    );
  }
}

bool emailVarification(email) {
  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email)) {
    return false;
  } else {
    return true;
  }
}

Widget greyButton() {
  return Container(
    height: 6.h,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    child: Center(
        child: Text(
      'Next',
      style: SolhTextStyles.GreenButtonText,
    )),
  );
}
