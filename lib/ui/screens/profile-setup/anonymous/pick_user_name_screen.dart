import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/profile-setup/anonymous/add_profile_pic_anon.dart';
import '../../../../controllers/profile/anon_controller.dart';
import '../../../../widgets_constants/appbars/app-bar.dart';
import '../../../../widgets_constants/buttons/custom_buttons.dart';
import '../../../../widgets_constants/constants/textstyles.dart';
import '../enter-full-name.dart';

class PickUsernameScreen extends StatelessWidget {
  PickUsernameScreen({Key? key}) : super(key: key);
  TextEditingController _usernameEditingController = TextEditingController();
  final AnonController _anonController = Get.put(AnonController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ProfileSetupAppBar(
          title: "Anonymous Username",
          onBackButton: () => Navigator.pop(context),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              Text(
                "Please enter your username, through which you can Post/Comment anonymously",
                style: SolhTextStyles.ProfileSetupSubHeading,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 3.5.h,
              ),
              ProfielTextField(
                hintText: "Username",
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textEditingController: _usernameEditingController,
                validator: (value) {
                  if (value!.isEmpty) {
                    _anonController.isNameTaken.value = false;
                  }
                  return value == '' ? "Required*" : null;
                },
                onChanged: (val) {
                  _anonController.isNameTaken.value = false;
                  if (val!.length >= 3) {
                    _anonController.checkIfUserNameTaken(val);
                  }
                },
              ),
              Obx(() {
                return _anonController.isNameTaken.value
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
                    //AutoRouter.of(context).push(AddProfilePicAnon());
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
                      if (_usernameEditingController.text.isNotEmpty) {
                        _anonController.userName.value =
                            _usernameEditingController.text;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddProfilePicAnon()));
                      } else {
                        SnackBar snackBar = SnackBar(
                          content: Text("Please enter a username"),
                          action: SnackBarAction(
                            label: "OK",
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  })
            ],
          ),
        ));
  }
}
