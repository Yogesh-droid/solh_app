import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class FirstTimeLandingLoginSignup extends StatefulWidget {
  const FirstTimeLandingLoginSignup({ Key? key }) : super(key: key);

  @override
  _FirstTimeLandingLoginSignupState createState() => _FirstTimeLandingLoginSignupState();
}

class _FirstTimeLandingLoginSignupState extends State<FirstTimeLandingLoginSignup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width/15,
          vertical: MediaQuery.of(context).size.height/20,
        ),
        decoration: BoxDecoration(  
          color: SolhColors.white,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/10,
                  decoration: BoxDecoration(  
                    color: Colors.transparent,
                    image: DecorationImage(  
                      image: AssetImage(
                        "assets/images/logo/solh-logo.png",
                      ),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SolhGreenButton(
                        child: Text(
                          "New User",
                          style: SolhTextStyles.GreenButtonText,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height/40,
                        ),
                        child: SolhGreenBorderButton(
                          child: Text(
                            "Login",
                            style: SolhTextStyles.GreenBorderButtonText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),      
    );
  }
}