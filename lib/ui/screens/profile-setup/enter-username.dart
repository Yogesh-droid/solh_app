import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/model/user/provider-user.dart';
import 'package:provider/provider.dart';

class EnterUsernameScreen extends StatelessWidget {
  EnterUsernameScreen(
      {Key? key, required VoidCallback onNext, required VoidCallback onBack})
      : _onNext = onNext,
        _onBack = onBack,
        super(key: key);

  final TextEditingController _userNameController = TextEditingController();

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
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                    hintText: "John Conor", border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 6.h,
              ),
              SolhGreenButton(
                  height: 6.h,
                  child: Text("Next"),
                  onPressed: () {
                    Provider.of<ProviderUser>(context, listen: false)
                        .setUserName = _userNameController.text;
                    _onNext();
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
