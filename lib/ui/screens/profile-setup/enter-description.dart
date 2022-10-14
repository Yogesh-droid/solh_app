import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/model/user/provider-user.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class EnterDescriptionPage extends StatelessWidget {
  EnterDescriptionPage(
      {Key? key, required VoidCallback onNext, required VoidCallback onBack})
      : _onNext = onNext,
        _onBack = onBack,
        super(key: key);

  final VoidCallback _onNext;
  final VoidCallback _onBack;

  final TextEditingController _descriptionEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onBack();
        return false;
      },
      child: Scaffold(
        appBar: ProfileSetupAppBar(
          title: "Description",
          onBackButton: _onBack,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              Text(
                "Tell others a little about yourself",
                style: SolhTextStyles.ProfileSetupSubHeading,
              ),
              SizedBox(
                height: 3.5.h,
              ),
              TextField(
                controller: _descriptionEditingController,
                maxLines: 4,
                decoration: InputDecoration(
                    hintText: "Add Description(Optional)",
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 6.h,
              ),
              SolhGreenButton(
                  height: 6.h,
                  child: Text("Next"),
                  onPressed: () {
                    Provider.of<ProviderUser>(context, listen: false).setBio =
                        _descriptionEditingController.text;
                    _onNext();
                  }),
              SizedBox(
                height: 2.h,
              ),
              // SkipButton(),
            ],
          ),
        ),
      ),
    );
  }
}
