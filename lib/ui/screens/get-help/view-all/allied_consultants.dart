import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';

import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/image_container.dart';
import 'package:solh/widgets_constants/solh_video_player.dart';

class AlliedConsultant extends StatelessWidget {
  const AlliedConsultant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: 6,
          itemBuilder: ((context, index) {
            return AlliedConsultantTile();
          })),
    );
  }
}

class AlliedConsultantTile extends StatelessWidget {
  const AlliedConsultantTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 24.h,
              width: 100.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color:
                          Color.fromRGBO(217, 217, 217, 1).withOpacity(0.4))),
              child: getProfileDetails(
                  context: context,
                  imageUrl: "https://picsum.photos/200",
                  startingPrice: '499',
                  previewUrl:
                      'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4'),
            ),
            SvgPicture.asset('assets/images/demo.svg')
          ],
        ),
        GetHelpDivider(),
      ],
    );
  }
}

getProfileDetails(
    {context,
    imageUrl,
    startingPrice,
    prefix,
    profession,
    experience,
    noOfPlans,
    previewUrl}) {
  return Padding(
    padding: const EdgeInsets.only(left: 12, top: 4),
    child: Column(
      children: [
        SizedBox(
          height: 1.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Recorded',
                style: SolhTextStyles.QS_cap_2_semi.copyWith(
                    color: SolhColors.primaryRed),
              ),
              Text(
                ' + ',
                style: SolhTextStyles.QS_cap_2_semi,
              ),
              Text(
                'Live',
                style: SolhTextStyles.QS_cap_2_semi.copyWith(
                    color: SolhColors.primary_green),
              )
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getProfileImg('https://picsum.photos/200', previewUrl, context),
            SizedBox(width: 3.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'prefix ',
                      style: SolhTextStyles.QS_body_2_semi,
                    ),
                    Text(
                      'name',
                      style: SolhTextStyles.QS_body_2_semi,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'bio/spelization ',
                      style: SolhTextStyles.QS_cap_semi,
                    ),
                    Row(
                      children: [
                        SolhDot(),
                        Text(
                          ' 8 years ',
                          style: SolhTextStyles.QS_cap_semi,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SolhDot(),
                        Text(
                          ' 2 plans',
                          style: SolhTextStyles.QS_cap_semi,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                getInteractionDetailsAllied()
              ],
            ),
          ],
        ),
        Expanded(
          child: Container(
            width: 100.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 13.w,
                  width: 25.w,
                  decoration: BoxDecoration(
                    color: SolhColors.blue_light,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Starting @',
                            style: SolhTextStyles.QS_cap_semi,
                          ),
                          Text(startingPrice,
                              style: SolhTextStyles.QS_cap_semi),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

getProfileImg(String? profilePicture, previewUrl, context) {
  return Stack(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SimpleImageContainer(
            // zoomEnabled: true,
            enableborder: true,
            enableGradientBorder: false,
            boxFit: BoxFit.cover,
            radius: 100,
            imageUrl: profilePicture!.isNotEmpty
                ? profilePicture
                : "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y"),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: ((context) {
                      return PreViewVideo(
                        videoUrl: previewUrl,
                      );
                    }));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: SolhColors.light_Bg_2,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 2,
                        color: Colors.black26,
                      )
                    ]),
                child: Center(
                    child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.play_rectangle,
                      size: 12,
                      color: SolhColors.primaryRed,
                    ),
                    Text(
                      ' Preview',
                      style: SolhTextStyles.QS_cap_2_semi,
                    )
                  ],
                )),
              ),
            ),
          ],
        ),
      )
    ],
  );
}

Widget getInteractionDetailsAllied() {
  return Row(
    children: [
      Row(
        children: [
          Icon(
            Icons.star_half,
            color: SolhColors.primary_green,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text('0',
              style: SolhTextStyles.QS_cap_semi.copyWith(
                  color: SolhColors.dark_grey))
        ],
      ),
      SizedBox(width: 3.w),
      Row(
        children: [
          Icon(
            CupertinoIcons.rectangle_stack_person_crop,
            size: 12,
            color: SolhColors.primary_green,
          ),
          SizedBox(
            width: 5,
          ),
          Text('0',
              style: SolhTextStyles.QS_cap_semi.copyWith(
                color: SolhColors.dark_grey,
              )),
        ],
      ),
    ],
  );
}

class SolhDot extends StatelessWidget {
  const SolhDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 5,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: SolhColors.primary_green),
    );
  }
}

class PreViewVideo extends StatelessWidget {
  const PreViewVideo({super.key, required this.videoUrl});

  final videoUrl;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        insetPadding: EdgeInsets.all(0),
        content: SolhVideoPlayer(
          videoUrl: videoUrl,
        ));
  }
}
