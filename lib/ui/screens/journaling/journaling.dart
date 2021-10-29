import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/ui/screens/journaling/widgets/journal-post.dart';
import 'package:solh/ui/screens/journaling/widgets/stories.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class Journaling extends StatefulWidget {
  const Journaling({Key? key}) : super(key: key);

  @override
  _JournalingState createState() => _JournalingState();
}

class _JournalingState extends State<Journaling> {
  // final _newPostKey = GlobalKey<FormState>();

  final List<String> _images = [
    "https://mir-s3-cdn-cf.behance.net/project_modules/disp/11462520706403.562efc838c1db.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDKwiSfAles5soFVbStddLdTd2VGg0hV8fGQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHJmKT56IxtNPFdhgZIuA5I7brj5c9ch96Rg&usqp=CAU",
    "https://mir-s3-cdn-cf.behance.net/project_modules/disp/11462520706403.562efc838c1db.jpg",
    "https://mir-s3-cdn-cf.behance.net/project_modules/disp/11462520706403.562efc838c1db.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0)
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 20,
                            vertical: MediaQuery.of(context).size.height / 80,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SolhGreenBorderMiniButton(
                                  height:
                                      MediaQuery.of(context).size.height / 18,
                                  width: 64.w,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                  ),
                                  onPressed: () => AutoRouter.of(context)
                                      .push(CreatePostScreenRouter()),
                                  child: Text(
                                    "What's on your mind?",
                                    style: SolhTextStyles.JournalingHintText,
                                  )
                                  // child: TextFormField(
                                  //   decoration: InputDecoration(

                                  //     contentPadding:
                                  //         EdgeInsets.only(bottom: 9),
                                  //     border: InputBorder.none,
                                  //     enabledBorder: InputBorder.none,
                                  //     focusedBorder: InputBorder.none,
                                  //     disabledBorder: InputBorder.none,
                                  //   ),
                                  // ),
                                  ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    iconSize: 24,
                                    splashRadius: 20,
                                    padding: EdgeInsets.zero,
                                    onPressed: () => {},
                                    icon: SvgPicture.asset(
                                        "assets/icons/journaling/post-photo.svg"),
                                    color: SolhColors.green,
                                  ),
                                  Container(
                                    height: 3.h,
                                    width: 0.2,
                                    color: SolhColors.blackop05,
                                  ),
                                  IconButton(
                                    iconSize: 24,
                                    splashRadius: 20,
                                    padding: EdgeInsets.zero,
                                    onPressed: () => {},
                                    icon: SvgPicture.asset(
                                        "assets/icons/journaling/switch-profile.svg"),
                                    color: SolhColors.green,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Stories(),
                      ],
                    );
                  return Column(
                    children: [
                      Container(
                        child: JournalPost(
                          imgUrl: _images[index],
                        ),
                        decoration: BoxDecoration(),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 1.h),
                        height: 0.8.h,
                        color: Colors.green.shade400
                            .withOpacity(0.25)
                            .withAlpha(80)
                            .withGreen(160),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
