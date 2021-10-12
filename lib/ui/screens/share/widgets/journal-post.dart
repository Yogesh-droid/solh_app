import 'package:flutter/material.dart';
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
                            IconButton(
                          onPressed: () => {}, 
                        icon: SvgIcon("assets/icons/journaling/post-settings.svg"),
                        iconSize: 20,
                        color: SolhColors.grey102,
                        ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}