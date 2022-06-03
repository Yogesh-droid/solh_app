import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:sizer/sizer.dart';
import '../../../controllers/profile/anon_controller.dart';
import '../../../widgets_constants/appbars/app-bar.dart';
import '../../../widgets_constants/buttons/custom_buttons.dart';
import 'enter-full-name.dart';

class PickUsernameScreen extends StatelessWidget {
  PickUsernameScreen({Key? key}) : super(key: key);
  TextEditingController _usernameEditingController = TextEditingController();
  final AnonController _anonController = Get.put(AnonController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ProfileSetupAppBar(
          title: "Username",
          onBackButton: () => Navigator.pop(context),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
          child: Column(
            children: [
              ProfielTextField(
                hintText: "Firstname",
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textEditingController: _usernameEditingController,
                validator: (value) => value == '' ? "Required*" : null,
                onChanged: (val) {
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
                  height: 6.h, child: Text("Next"), onPressed: () {})
            ],
          ),
        ));
  }
}
