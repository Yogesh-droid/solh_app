import 'package:flutter/material.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screen.dart';
import 'package:solh/ui/screens/my-profile/settings/account-privacy.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        isLandingScreen: false,
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          ProfileMenuTile(
              title: "Account Privacy",
              svgIconPath: "assets/icons/profile/privacy.svg",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AccountPrivacyScreen();
                }));
              }),
          // ProfileMenuTile(
          //     title: "Change Mobile No.",
          //     svgIconPath: "assets/icons/profile/phone.svg",
          //     onPressed: () {}),
          // ProfileMenuTile(
          //     title: "Language",
          //     svgIconPath: "assets/icons/profile/language.svg",
          //     onPressed: () {}),
          // ProfileMenuTile(
          //     title: "Block/unblock",
          //     svgIconPath: "assets/icons/profile/block.svg",
          //     onPressed: () {}),
        ],
      ),
    );
  }
}
