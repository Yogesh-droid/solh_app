import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/get-help/view-all/view-all.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/others/semi-circle.dart';

class GetHelpScreen extends StatefulWidget {
  const GetHelpScreen({Key? key}) : super(key: key);

  @override
  State<GetHelpScreen> createState() => _GetHelpScreenState();
}

class _GetHelpScreenState extends State<GetHelpScreen> {
  bool _isDrawerOpen = false;
  List<String> _specialities = [
    "Psychotherapist",
    "Psychologist",
    "Counseling Psychologists",
    "Psychiatrist",
    "Cognitive Behavioural Therapistt",
    "Organizational Psychologists",
    "Developmental Psychologists",
    "Expressive Art Therapists"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                print("side bar tapped");
                setState(() {
                  _isDrawerOpen = !_isDrawerOpen;
                });
                print("opened");
              },
              child: SvgPicture.asset(
                "assets/icons/app-bar/app-bar-menu.svg",
                width: 26,
                height: 24,
                color: SolhColors.green,
              ),
            ),
            SizedBox(
              width: 2.h,
            ),
            Text(
              "Get Help",
              style: SolhTextStyles.AppBarText,
            ),
          ],
        ),
        isLandingScreen: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 2.h),
            //   alignment: Alignment.center,
            //   child: Container(
            //     width: MediaQuery.of(context).size.width / 1.1,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(25.0),
            //         border: Border.all(color: SolhColors.green)),
            //     padding: EdgeInsets.only(left: 3.w),
            //     child: TextField(
            //         decoration: InputDecoration(
            //             suffixIcon: Icon(
            //               Icons.search,
            //               color: SolhColors.green,
            //             ),
            //             border: InputBorder.none,
            //             hintStyle: TextStyle(color: Color(0xFFA6A6A6)),
            //             hintText: "Anxiety, Corporate Stress, Family Issues")),
            //   ),
            // ),
            // GetHelpDivider(),
            GetHelpCategory(
              title: "Top Consultants",
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ViewAllScreen())),
            ),
            Container(
              height: 15.h,
              margin: EdgeInsets.only(bottom: 2.h),
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (_, index) => TopConsultantsTile()),
            ),
            GetHelpDivider(),

            GetHelpCategory(
              title: "Search by issues",
            ),
            Container(
                margin:
                    EdgeInsets.only(left: 1.5.w, right: 1.5.w, bottom: 1.5.h),
                child: Wrap(
                  children: [
                    IssuesTile(
                      title: 'Anxiety',
                    ),
                    IssuesTile(
                      title: 'Corporate Stress',
                    ),
                    IssuesTile(
                      title: 'Family Issues',
                    ),
                    IssuesTile(
                      title: 'Work Problems',
                    ),
                    IssuesTile(
                      title: 'Relationship Struggles',
                    ),
                    IssuesTile(
                      title: 'Corporate Stress',
                    ),
                    IssuesTile(
                      title: 'Family Issues',
                    ),
                  ],
                )),

            GetHelpDivider(),
            GetHelpCategory(
              title: "Search by speciality",
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 2.5.w,
                    crossAxisSpacing: 2.5.w,
                    crossAxisCount: 2,
                    childAspectRatio: 2),
                physics: NeverScrollableScrollPhysics(),
                itemCount: _specialities.length,
                shrinkWrap: true,
                itemBuilder: (_, index) => Container(
                  height: 1.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFEFEFEF)),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 8.w,
                        child: CircleAvatar(
                          radius: 7.8.w,
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child:
                                Image.asset("assets/images/logo/solh-logo.png"),
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Container(
                        width: 25.w,
                        child: Text(
                          _specialities[index],
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GetHelpDivider(),

            // GetHelpCategory(
            //   title: "Instantly Available",
            // ),
            // Container(
            //   height: 15.h,
            //   margin: EdgeInsets.only(bottom: 2.h),
            //   child: ListView.builder(
            //       shrinkWrap: true,
            //       scrollDirection: Axis.horizontal,
            //       itemCount: 6,
            //       itemBuilder: (_, index) => TopConsultantsTile()),
            // ),
            // GetHelpDivider(),
            // GetHelpCategory(
            //   title: "Solh Volunteers",
            // ),
            // Container(
            //   height: 38.h,
            //   padding: EdgeInsets.symmetric(horizontal: 3.5.w),
            //   child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       shrinkWrap: true,
            //       itemCount: 8,
            //       itemBuilder: (_, index) => Container(
            //             child: Container(
            //               margin: EdgeInsets.symmetric(horizontal: 1.w),
            //               decoration: BoxDecoration(
            //                   border: Border.all(color: Color(0xFFEFEFEF)),
            //                   borderRadius: BorderRadius.circular(8)),
            //               height: 25.h,
            //               width: 42.w,
            //               child: Column(
            //                 children: [
            //                   ProfilePictureHeader(),
            //                   Text("John Conor"),
            //                   Row(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     children: [
            //                       Text(
            //                         "Solh Expert",
            //                         style: SolhTextStyles.JournalingBadgeText,
            //                       ),
            //                       Padding(
            //                         padding: EdgeInsets.only(
            //                           left: MediaQuery.of(context).size.width /
            //                               80,
            //                         ),
            //                         child: Icon(
            //                           Icons.verified,
            //                           color: SolhColors.green,
            //                           size: 14,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.symmetric(
            //                         vertical: 1.h, horizontal: 2.5.w),
            //                     child: Text(
            //                         "Bio/Self experiences/Qoate/When the pain passes, you eventually see how much...",
            //                         style: SolhTextStyles.SOSGreyText.copyWith(
            //                             fontSize: 12,
            //                             fontWeight: FontWeight.w300)),
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.symmetric(
            //                         vertical: 0.5.h, horizontal: 4.w),
            //                     child: Row(
            //                       mainAxisAlignment:
            //                           MainAxisAlignment.spaceAround,
            //                       children: [
            //                         Row(
            //                           children: [
            //                             SvgPicture.asset(
            //                               "assets/icons/profile/connections.svg",
            //                               height: 12,
            //                               width: 12,
            //                             ),
            //                             SizedBox(width: 1.6.w),
            //                             Text(
            //                               "45",
            //                               style: SolhTextStyles
            //                                       .GreenBorderButtonText
            //                                   .copyWith(fontSize: 12),
            //                             ),
            //                           ],
            //                         ),
            //                         Row(
            //                           children: [
            //                             SvgPicture.asset(
            //                               "assets/icons/profile/connections.svg",
            //                               height: 12,
            //                               width: 12,
            //                             ),
            //                             SizedBox(width: 1.6.w),
            //                             Text(
            //                               "45",
            //                               style: SolhTextStyles
            //                                       .GreenBorderButtonText
            //                                   .copyWith(fontSize: 12),
            //                             ),
            //                           ],
            //                         ),
            //                         Row(
            //                           children: [
            //                             SvgPicture.asset(
            //                               "assets/icons/profile/connections.svg",
            //                               height: 12,
            //                               width: 12,
            //                             ),
            //                             SizedBox(width: 1.6.w),
            //                             Text(
            //                               "45",
            //                               style: SolhTextStyles
            //                                       .GreenBorderButtonText
            //                                   .copyWith(fontSize: 12),
            //                             ),
            //                           ],
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     height: 2.5.h,
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.symmetric(horizontal: 2.w),
            //                     child: SolhGreenButton(
            //                         height: 4.h,
            //                         child: Row(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.center,
            //                           children: [
            //                             SvgPicture.asset(
            //                               "assets/icons/profile/connections.svg",
            //                               color: Colors.white,
            //                             ),
            //                             SizedBox(
            //                               width: 2.w,
            //                             ),
            //                             Text("Connect"),
            //                           ],
            //                         )),
            //                   )
            //                 ],
            //               ),
            //             ),
            //           )),
            // ),
            // SizedBox(
            //   height: 5.h,
            // ),
          ],
        ),
      ),
    );
  }
}

class IssuesTile extends StatelessWidget {
  const IssuesTile({
    Key? key,
    required String title,
  })  : _title = title,
        super(key: key);

  final String _title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFEFEFEF),
        ),
        borderRadius: BorderRadius.circular(18),
        color: Color(0xFFFBFBFB),
      ),
      child: Text(
        _title,
        style: TextStyle(color: Color(0xFF666666)),
      ),
    );
  }
}

class TopConsultantsTile extends StatelessWidget {
  const TopConsultantsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 15.h,
      margin: EdgeInsets.symmetric(horizontal: 2.5.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: SolhColors.grey196.withOpacity(0.4))),
      child: Container(
        height: 18.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  height: 15.h,
                  width: 25.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8)),
                    child: Image.network(
                      "https://e7.pngegg.com/pngimages/1001/748/png-clipart-doctor-raising-right-hand-illustration-physician-hospital-medicine-doctor-s-office-health-doctor-s-child-face.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Positioned(
                //   bottom: 0,
                //   child: Container(
                //     height: 2.5.h,
                //     width: 25.w,
                //     color: Colors.white70,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         CircleAvatar(
                //           backgroundColor: Color(0xFFE1555A),
                //           radius: 1.4.w,
                //         ),
                //         SizedBox(
                //           width: 1.5.w,
                //         ),
                //         Text("Active")
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
            SizedBox(width: 2.w),
            Container(
                width: 42.w,
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Dr. Sakshi Trivedi"),
                    Text("(PhD)"),
                    Text(
                      "Areas of specialization In layman language...",
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "07 Year of Experience",
                      style: TextStyle(fontSize: 12),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.people,
                                color: SolhColors.green,
                                size: 18,
                              ),
                              Text(
                                "72",
                                style: SolhTextStyles.GreenBorderButtonText,
                              )
                            ],
                          ),
                          Text(
                            "Free",
                            style: TextStyle(color: SolhColors.green),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class ProfilePictureHeader extends StatelessWidget {
  const ProfilePictureHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12.8.h,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
                color: SolhColors.green,
                borderRadius: BorderRadius.circular(8)),
            height: 6.5.h,
          ),
          Positioned(
            top: 1.54.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                MyArc(
                  diameter: 10.h,
                  color: Colors.white,
                ),
                RotatedBox(quarterTurns: 2, child: MyArc(diameter: 10.h)),
                CircleAvatar(
                  radius: 4.75.h,
                  backgroundImage: CachedNetworkImageProvider(
                    "https://techcrunch.com/wp-content/uploads/2017/09/sunshine.jpg?w=1000",
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

class GetHelpCategory extends StatelessWidget {
  const GetHelpCategory({
    Key? key,
    required String title,
    VoidCallback? onPressed,
  })  : _title = title,
        _onPressed = onPressed,
        super(key: key);

  final String _title;
  final VoidCallback? _onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.5.w, vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _title,
            style: TextStyle(fontSize: 20, color: Color(0xFF666666)),
          ),
          if (_onPressed != null)
            InkWell(
              onTap: _onPressed,
              child: Text(
                "View All",
                style: TextStyle(color: SolhColors.green),
              ),
            )
        ],
      ),
    );
  }
}

class GetHelpDivider extends StatelessWidget {
  const GetHelpDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0x30D9D9D9),
      height: 1.8.h,
    );
  }
}
