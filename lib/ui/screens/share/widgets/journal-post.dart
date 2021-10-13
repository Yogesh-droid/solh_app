import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:svg_icon/svg_icon.dart';

class JournalPost extends StatefulWidget {
  const JournalPost({ Key? key }) : super(key: key);

  @override
  _JournalPostState createState() => _JournalPostState();
}

class _JournalPostState extends State<JournalPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/1.57,
               width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 20,
                    //vertical: MediaQuery.of(context).size.height/80,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CircleAvatar(
                        child: Image.asset(
                          "assets/images/journal-demo/post-user-profile-picture.png"
                        ),
                        backgroundColor: SolhColors.pink224,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context).size.width / 40,
                                        ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "John Cornor",
                                        style: SolhTextStyles.JournalingUsernameText,
                                      ),
                                      Text(
                                        "2H ago",
                                        style: SolhTextStyles.JournalingTimeStampText,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: MediaQuery.of(context).size.height/40,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context).size.width/40,
                                  ),
                                  decoration: BoxDecoration(  
                                    color: SolhColors.grey239,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Solh Expert",
                                        style: SolhTextStyles.JournalingBadgeText,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: MediaQuery.of(context).size.width/80,
                                          ),
                                          child: Icon( 
                                            Icons.verified,
                                            color: SolhColors.green,
                                            size: 14,
                                          ),
                                        ),
                                    ],
                                  ),
                                  ),
                              ],
                            ),
                        //     IconButton(
                        //   onPressed: () => {}, 
                        // icon: SvgIcon("assets/icons/journaling/post-settings.svg"),
                        // iconSize: 20,
                        // color: SolhColors.grey102,
                        // ),
                        PopupMenuButton(
                icon: Icon(
                  Icons.more_vert,
                color: SolhColors.grey102,
                ),
                iconSize: 20,
                color: SolhColors.white,
                padding: EdgeInsets.zero,
                offset: Offset(10,0),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width/20,
                        bottom: MediaQuery.of(context).size.height/30,
                      ),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: SolhColors.grey239),
                        )
                      ),
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context), 
                          icon: Icon(
                            Icons.close,
                          ),
                          iconSize: 18,
                          color: SolhColors.grey102,
                          splashRadius: 16,
                          ),
                      ),
                    ),
                    value: 0,
                    textStyle: SolhTextStyles.JournalingPostMenuText,
                    padding: EdgeInsets.zero,
                  ),
                   PopupMenuItem(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width/20,
                        vertical: MediaQuery.of(context).size.height/80,
                      ),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: SolhColors.grey239),
                        )
                      ),
                      child: Text(
                        "Save this post",
                        ),
                    ),
                    value: 1,
                    textStyle: SolhTextStyles.JournalingPostMenuText,
                    padding: EdgeInsets.zero,
                  ),
                  PopupMenuItem(
                    child: Container(
                       alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width/20,
                        vertical: MediaQuery.of(context).size.height/80,
                      ),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: SolhColors.grey239),
                        )
                      ),
                      child: Text(
                        "Don't see this post again",
                        ),
                    ),
                    value: 2,
                    textStyle: SolhTextStyles.JournalingPostMenuText,
                    padding: EdgeInsets.zero,
                  ),
                  PopupMenuItem(
                    child: Container(
                       alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width/20,
                        vertical: MediaQuery.of(context).size.height/80,
                      ),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: SolhColors.grey239),
                        )
                      ),
                      child: Text(
                        "Block this person",
                        ),
                    ),
                    value: 3,
                    textStyle: SolhTextStyles.JournalingPostMenuText,
                    padding: EdgeInsets.zero,
                  ),
                  PopupMenuItem(
                    child: Container(
                       alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width/20,
                        vertical: MediaQuery.of(context).size.height/80,
                      ),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: SolhColors.grey239),
                        )
                      ),
                      child: Text(
                        "Report this post",
                        ),
                    ),
                    value: 4,
                    textStyle: SolhTextStyles.JournalingPostMenuText,
                    padding: EdgeInsets.zero,
                  ),
                ]
            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 20,
                  ),
                  child: Divider(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "#Feeling lazy",
                        style: SolhTextStyles.JournalingHashtagText,
                      ),
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                  text: TextSpan(
                    text: "Amet, consectetur adipiscing elit. Elit odio sollicitudin accumsan gravida. Vitae lacus at facilisis",
                  style: SolhTextStyles.JournalingDescriptionText,
                  children: [
                    TextSpan(
                    text: " see more.",
                  style: SolhTextStyles.JournalingDescriptionReadMoreText,
                    ),
                  ],
                  ),
                ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/3,
                  margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height/80,
                  ),
                  decoration: BoxDecoration(  
                    image: DecorationImage(  
                      image: AssetImage(
                        "assets/images/journal-demo/demo-post-picture.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SolhGreenBorderMiniButton(
                        width: MediaQuery.of(context).size.width/3.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgIcon(
                              "assets/icons/journaling/post-like.svg",
                              width: 15,
                              height: 14,
                              color: SolhColors.green,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width/40,
                              ),
                              child: Text(
                                "45",
                                style: SolhTextStyles.GreenBorderButtonText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SolhGreenBorderMiniButton(
                        width: MediaQuery.of(context).size.width/3.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgIcon(
                              "assets/icons/journaling/post-comment.svg",
                              width: 16,
                              height: 14,
                              color: SolhColors.green,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width/40,
                              ),
                              child: Text(
                                "27",
                                style: SolhTextStyles.GreenBorderButtonText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SolhGreenBorderMiniButton(
                        width: MediaQuery.of(context).size.width/3.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgIcon(
                              "assets/icons/journaling/post-connect.svg",
                              width: 15,
                              height: 16,
                              color: SolhColors.green,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width/40,
                              ),
                              child: Text(
                                "Connect",
                                style: SolhTextStyles.GreenBorderButtonText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 20,
                    //vertical: MediaQuery.of(context).size.height/140,
                  ),
                  child: Divider(),
                ),
              ],
            ),
          );
  }
}