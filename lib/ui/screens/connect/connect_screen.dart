import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/connect/connect_screen_controller/connect_screen_controller.dart';
import 'package:solh/ui/screens/journaling/side_drawer.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/image_container.dart';

class ConnectScreen2 extends StatelessWidget {
  ConnectScreen2({Key? key}) : super(key: key);
  ConnectScreenController connectScreenController =
      Get.put(ConnectScreenController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: SolhAppBar(
        isLandingScreen: false,
        title: Text('Connect', style: SolhTextStyles.AppBarText),
      ),
      body: ListView(children: [
        SizedBox(
          height: 5.h,
        ),
        SimpleImageContainer(
          imageUrl: "https://picsum.photos/200",
          enableborder: true,
          radius: 15.h,
        ),
        SizedBox(
          height: 2.h,
        ),
        GetNaameBadgeAndBio(),
        SizedBox(
          height: 5.h,
        ),
        GetProfileStats(),
        GetMessageButton(),
        GetConnectJoinUnfriendButton(),
      ]),
    ));
  }
}

class GetNaameBadgeAndBio extends StatelessWidget {
  const GetNaameBadgeAndBio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "John Conor",
          style: SolhTextStyles.LargeNameText,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBadge(userType: 'SolhVolunteer'),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 80.w,
          child: Text(
            'Bio/Self experiences When the pain passes, you eventually see how much good.',
            style: SolhTextStyles.UniversalText,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class GetProfileStats extends StatelessWidget {
  const GetProfileStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.thumb_up,
                    color: SolhColors.green,
                    size: 16,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '27',
                    style: SolhTextStyles.ToggleLinkText,
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Likes',
                style: SolhTextStyles.LandingParaText,
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/images/connect.svg'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '27',
                    style: SolhTextStyles.ToggleLinkText,
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Connections',
                style: SolhTextStyles.LandingParaText,
              ),
            ],
          ),
          // Column(
          //   children: [
          //     Row(
          //       children: [
          //         Icon(
          //           Icons.thumb_up,
          //           color: SolhColors.green,
          //         ),
          //         SizedBox(
          //           width: 5,
          //         ),
          //         Text(
          //           '27',
          //           style: SolhTextStyles.ToggleLinkText,
          //         )
          //       ],
          //     ),
          //     Text(
          //       'Likes',
          //       style: SolhTextStyles.LandingParaText,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class GetMessageButton extends StatelessWidget {
  const GetMessageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        SolhGreenButton(
          width: 70.w,
          child: Text(
            'Message',
            style: SolhTextStyles.GreenButtonText,
          ),
        ),
      ],
    );
  }
}

class GetConnectJoinUnfriendButton extends StatelessWidget {
  const GetConnectJoinUnfriendButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        SolhGreenBorderButton(
            width: 70.w,
            child: Text(
              'Unfriend',
              style: SolhTextStyles.GreenBorderButtonText,
            )),
      ],
    );
  }
}
