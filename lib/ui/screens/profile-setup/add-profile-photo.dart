import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/intro/intro-crousel.dart';
import 'package:solh/ui/screens/profile-setup/description.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';

class AddProfilePhoto extends StatelessWidget {
  const AddProfilePhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileSetupAppBar(
        title: "Add a Profile Photo",
      ),
      body: Column(
        children: [
          SizedBox(
            height: 12.h,
          ),
          Stack(
            children: [
              SvgPicture.asset("assets/icons/profile-setup/profile.svg"),
              Positioned(
                  right: 0,
                  bottom: 0,
                  child: SvgPicture.asset("assets/icons/profile-setup/add.svg"))
            ],
          ),
          Expanded(child: Container()),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SolhGreenButton(
                child: Text("Add Image"),
                height: 6.h,
                width: MediaQuery.of(context).size.width / 1.1,
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => DescriptionScreen())),
              ),
              SizedBox(
                height: 2.h,
              ),
              SkipButton(),
              SizedBox(
                height: 3.8.h,
              ),
            ],
          )
        ],
      ),
    );
  }
}
