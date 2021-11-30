import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/model/journal.dart';
import 'package:solh/model/user/journal-user.dart';
import 'package:solh/ui/screens/journaling/widgets/journal-post.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class ConnectProfileScreen extends StatelessWidget {
  const ConnectProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SolhAppBar(
          isLandingScreen: false,
          title: Text(
            "Connect",
            style: SolhTextStyles.AppBarText,
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: [
                    SizedBox(height: 2.5.h),
                    CircleAvatar(
                      radius: 6.h,
                      backgroundImage: CachedNetworkImageProvider(
                        'https://static0.cbrimages.com/wordpress/wp-content/uploads/2020/09/The-Vampire-Diaries-Elena-Gilbert.jpg?q=50&fit=crop&w=767&h=450&dpr=1.5',
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("John Conor", style: TextStyle(fontSize: 21)),
                        Icon(Icons.people, color: SolhColors.grey)
                      ],
                    ),
                    Text(
                      "Solh Expert",
                      style: SolhTextStyles.GreenBorderButtonText,
                    ),
                    SizedBox(height: 1.5.h),
                    Container(
                      width: 75.w,
                      child: Text(
                          '''Bio/Self experiences/Qoate/When the pain passes, you eventually see how much good.'''),
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.thumb_up,
                                  size: 18,
                                  color: SolhColors.green,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  '27',
                                  style: SolhTextStyles.GreenBorderButtonText
                                      .copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                            Text("Likes"),
                          ],
                        ),
                        // Divider(),
                        Column(
                          children: [
                            Text(
                              '17',
                              style:
                                  SolhTextStyles.GreenBorderButtonText.copyWith(
                                      fontSize: 18),
                            ),
                            Text("Connections"),
                          ],
                        ),
                        // Divider(),
                        Column(
                          children: [
                            Text(
                              '17',
                              style:
                                  SolhTextStyles.GreenBorderButtonText.copyWith(
                                      fontSize: 18),
                            ),
                            Text("Reviews"),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 3.h),
                    SolhGreenButton(
                        width: 90.w,
                        height: 6.3.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text("Connect/Join")],
                        )),
                    SizedBox(height: 3.h),
                  ],
                ),
              ]),
            )
          ],
          body: TabView(),
        ));
  }
}

class TabView extends StatefulWidget {
  const TabView({
    Key? key,
  }) : super(key: key);

  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 6.h,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            GestureDetector(
              onTap: () {
                _pageController.jumpToPage(0);
              },
              child: Text(
                "Posts",
                style: TextStyle(
                    color:
                        _currentPage == 0 ? SolhColors.green : SolhColors.grey,
                    fontSize: 20),
              ),
            ),
            GestureDetector(
              onTap: () {
                _pageController.jumpToPage(1);
              },
              child: Text(
                "Reviews",
                style: TextStyle(
                    color:
                        _currentPage == 1 ? SolhColors.green : SolhColors.grey,
                    fontSize: 20),
              ),
            ),
          ]),
        ),
        Expanded(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              ListView.builder(
                  itemCount: 8,
                  itemBuilder: (_, index) => Column(
                        children: [
                          PostTile(
                              journalModel: JournalModel(
                                  feelings: "happy",
                                  likes: 24,
                                  comments: 15,
                                  description: "tehre",
                                  imageUrl: "",
                                  postedBy: JournalUserModel(
                                    name: "Geetansh",
                                    isSolhAdviser: false,
                                    isSolhCounselor: true,
                                    isSolhExpert: true,
                                  ))),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 1.h),
                            height: 0.8.h,
                            color: Colors.green.shade400
                                .withOpacity(0.25)
                                .withAlpha(80)
                                .withGreen(160),
                          ),
                        ],
                      )),
              Container()
            ],
            onPageChanged: (value) {
              setState(() {
                _currentPage = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
