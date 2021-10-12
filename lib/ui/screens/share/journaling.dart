import 'package:flutter/material.dart';
import 'package:solh/ui/screens/share/widgets/journal-post.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:svg_icon/svg_icon.dart';

class Journaling extends StatefulWidget {
  const Journaling({Key? key}) : super(key: key);

  @override
  _JournalingState createState() => _JournalingState();
}

class _JournalingState extends State<Journaling> {
  final _newPostKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 20,
                vertical: MediaQuery.of(context).size.height / 80,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    child: Image.asset(
                            "assets/images/journal-demo/demo-viewing-user-profile-picture.png"
                          ),
                    backgroundColor: SolhColors.pink224,
                    radius: 20,
                  ),
                  SolhGreenBorderMiniButton(
                    height: MediaQuery.of(context).size.height / 18,
                    width: MediaQuery.of(context).size.width / 1.8,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 30,
                    ),
                    child: Form(
                      key: _newPostKey,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "What's on your mind?",
                          hintStyle: SolhTextStyles.JournalingHintText,
                          contentPadding: EdgeInsets.only(bottom: 9),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: IconButton(
                            iconSize: 24,
                            splashRadius: 20,
                            padding: EdgeInsets.zero,
                            onPressed: () => {},
                            icon: SvgIcon("assets/icons/journaling/post-photo.svg"),
                            color: SolhColors.green,
                          ),
                        ),
                        VerticalDivider(
                          color: SolhColors.blackop05,
                        ),
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: IconButton(
                            iconSize: 24,
                            splashRadius: 20,
                            padding: EdgeInsets.zero,
                            onPressed: () => {},
                            icon: SvgIcon("assets/icons/journaling/switch-profile.svg"),
                            color: SolhColors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ), 
           JournalPost(),
           JournalPost(),
          //  ListView.builder(
          //    itemCount: 2,
          //    itemBuilder: (BuildContext context, int index) {
          //      return JournalPost();
          //    }
          //    ),
          ],
        ),
      ),
    );
  }
}
