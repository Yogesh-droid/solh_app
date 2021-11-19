import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screen.dart';
import 'package:solh/ui/screens/widgets/app-bar.dart';

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
                AutoRouter.of(context).push(AccountPrivacyScreenRouter());
              }),
          ProfileMenuTile(
              title: "Change Mobile No.",
              svgIconPath: "assets/icons/profile/phone.svg",
              onPressed: () {}),
          ProfileMenuTile(
              title: "Language",
              svgIconPath: "assets/icons/profile/language.svg",
              onPressed: () {}),
          ProfileMenuTile(
              title: "Block/unblock",
              svgIconPath: "assets/icons/profile/block.svg",
              onPressed: () {}),
        ],
      ),
    );
  }
}
