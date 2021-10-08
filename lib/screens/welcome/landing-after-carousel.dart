import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/buttons/toggle_button.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class FirstTimeLandingAfterCarousel extends StatefulWidget {
  const FirstTimeLandingAfterCarousel({ Key? key }) : super(key: key);

  @override
  _FirstTimeLandingAfterCarouselState createState() => _FirstTimeLandingAfterCarouselState();
}

class _FirstTimeLandingAfterCarouselState extends State<FirstTimeLandingAfterCarousel> {
  bool _switchValue = false;

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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height/10,
              ),
              child: Text(
                "Good to have you here",
                style: SolhTextStyles.LandingTitleText,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height/40,
                bottom: MediaQuery.of(context).size.height/80,
              ),
              child: Text(
                "Solh Provides insight into your emotional health and how you can work on it. The app is developed by the therapists, but it is important that you understand that it is not a substitute for diagnosis of psychotherapy.",
                style: SolhTextStyles.LandingParaText,
              ),
            ),
            Text(
              "The processing of health data requires your consent. This is voluntary and can be revoked at any time.",
              style: SolhTextStyles.LandingParaText,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height/15,
                          horizontal: MediaQuery.of(context).size.width/40,
                        ),
                        child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                            text: "I have read and understood ",
                            style: SolhTextStyles.ToggleParaText,
                            children: [
                              TextSpan(
                            text: "the terms of use ",
                            style: SolhTextStyles.ToggleLinkText,
                              ),
                              TextSpan(
                            text: "and ",
                            style: SolhTextStyles.ToggleParaText,
                              ),
                              TextSpan(
                            text: "privacy policy",
                            style: SolhTextStyles.ToggleLinkText,
                              ),
                            ]
                            ),
                                       ),
                        ),
                     SolhToggleButton(switchValue: _switchValue),
                    ],
                  ),
                      ),
                      SolhGreenButton(
                        child: Text(
                          "CONTINUE",
                          style: SolhTextStyles.GreenButtonText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}