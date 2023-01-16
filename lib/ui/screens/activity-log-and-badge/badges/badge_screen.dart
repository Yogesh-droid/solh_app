import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/journaling/side_drawer.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class BadgesScreen extends StatelessWidget {
  const BadgesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithLightBg2BackgroundArt(
      body: Column(
        children: [
          SizedBox(
            height: 8.h,
          ),
          CurrentBadge(),
          Column(
            children: [
              Text('Person_ Name'),
              GetBadge(userType: 'SolhVolunteer')
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Column(
            children: [
              Text(
                'Badges up Next',
                style: SolhTextStyles.QS_body_1_bold,
              ),
              Container(
                width: 80.w,
                child: Text(
                  'Earn more psychological capital for respective badge & make it yours',
                  style: SolhTextStyles.QS_body_2,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class CurrentBadge extends StatelessWidget {
  const CurrentBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            child: Image.asset(
              'assets/images/star_background2.png',
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30.w,
                  width: 30.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [
                        Color(0xff5F9B8C),
                        Color(0xffE1555A),
                      ])),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 14.w,
                  backgroundImage: NetworkImage('https://picsum.photos/200'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
