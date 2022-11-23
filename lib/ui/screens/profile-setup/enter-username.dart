import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/model/user/provider-user.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import '../../../controllers/profile/anon_controller.dart';
import 'enter-full-name.dart';

class EnterUsernameScreen extends StatelessWidget {
  EnterUsernameScreen(
      {Key? key, required VoidCallback onNext, required VoidCallback onBack})
      : _onNext = onNext,
        _onBack = onBack,
        super(key: key);

  final TextEditingController _userNameController = TextEditingController();
  //final AnonController _anonController = Get.put(AnonController());
  final AnonController _anonController = Get.find();
  final PageController _pageController = PageController();

  final VoidCallback _onNext;
  final VoidCallback _onBack;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onBack();
        return false;
      },
      child: Scaffold(
        appBar: ProfileSetupAppBar(
          enableSkip: true,
          onBackButton: _onBack,
          onSkip: _onNext,
          title: "Your Username",
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              Text(
                "Please enter your username",
                style: SolhTextStyles.ProfileSetupSubHeading,
              ),
              SizedBox(
                height: 3.5.h,
              ),
              ProfielTextField(
                hintText: "Username",
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textEditingController: _userNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    _anonController.isNormalNameTaken.value = false;
                  }
                  return value == ''
                      ? "Required*"
                      : value.length < 3
                          ? "Username must be at least 3 characters long"
                          : null;
                },
                onChanged: (val) {
                  _anonController.isNormalNameTaken.value = false;
                  if (val!.length >= 3) {
                    _anonController.checkIfNormalUserNameTaken(val);
                  }
                },
              ),
              Obx(() {
                return _anonController.isNormalNameTaken.value
                    ? Text(
                        "Username Already taken",
                        style: TextStyle(color: Colors.red),
                      )
                    : Container();
              }),
              SizedBox(
                height: 6.h,
              ),
              SolhGreenButton(
                  height: 6.h,
                  child: Text("Next"),
                  onPressed: () {
                    if (_anonController.isNameTaken.value) {
                      SnackBar snackBar = SnackBar(
                        content: Text("Username Already taken"),
                        action: SnackBarAction(
                          label: "OK",
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      Provider.of<ProviderUser>(context, listen: false)
                          .setUserName = _userNameController.text;
                      print('_onNextCalled');
                      _onNext();
                    }
                  }
                  //  Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (_) => AddProfilePhotoPage(onNext: ,))),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
