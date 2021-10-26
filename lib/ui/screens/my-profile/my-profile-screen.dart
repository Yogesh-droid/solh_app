import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/ui/screens/widgets/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        Text(
          "Profile",
          style: SolhTextStyles.AppBarText,
        ),
        true,
      ),
      body: Center(
          child: Container(
        child: TextButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            AutoRouter.of(context).pushAndPopUntil(IntroCarouselScreenRouter(),
                predicate: (value) => false);
          },
          child: Text("Logout",
              textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
        ),
      )),
    );
  }
}
