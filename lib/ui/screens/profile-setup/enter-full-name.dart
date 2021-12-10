import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/model/user/provider-user.dart';
import 'package:solh/ui/screens/profile-setup/enter-username.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class EnterFullNameScreen extends StatelessWidget {
  EnterFullNameScreen({Key? key}) : super(key: key);

  final TextEditingController _firstnameEditingController =
      TextEditingController();
  final TextEditingController _lastnameEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileSetupAppBar(
        title: "Enter your details",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            Text(
              "What do you want people to call you?",
              style: SolhTextStyles.ProfileSetupSubHeading,
            ),
            SizedBox(
              height: 3.5.h,
            ),
            ProfielTextField(
              hintText: "Firstname",
            ),
            SizedBox(
              height: 3.5.h,
            ),
            ProfielTextField(hintText: "Lastname"),
            SizedBox(
              height: 6.h,
            ),
            SolhGreenButton(
                height: 6.h,
                child: Text("Next"),
                onPressed: () {
                  Provider.of<ProviderUser>(context, listen: false)
                      .setFirstName = _firstnameEditingController.text;
                  Provider.of<ProviderUser>(context, listen: false)
                      .setFirstName = _lastnameEditingController.text;

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => EnterUsernameScreen()));
                })
          ],
        ),
      ),
    );
  }
}

class ProfielTextField extends StatelessWidget {
  const ProfielTextField(
      {Key? key,
      String? hintText,
      TextEditingController? textEditingController})
      : _hintText = hintText,
        _textEditingController = textEditingController,
        super(key: key);

  final String? _hintText;
  final TextEditingController? _textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.5.w),
          hintText: _hintText,
          border: OutlineInputBorder()),
    );
  }
}
