import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/getHelp/get_help_controller.dart';
import 'package:solh/controllers/getHelp/search_market_controller.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/ui/screens/get-help/search_screen.dart';
import 'package:solh/ui/screens/get-help/view-all/consultants.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/others/semi-circle.dart';
import 'package:solh/widgets_constants/solh_search_field.dart';
import 'package:url_launcher/url_launcher.dart';

class GetHelpScreen extends StatefulWidget {
  const GetHelpScreen({Key? key}) : super(key: key);

  @override
  State<GetHelpScreen> createState() => _GetHelpScreenState();
}

class _GetHelpScreenState extends State<GetHelpScreen> {
  GetHelpController getHelpController = Get.find();
  SearchMarketController searchMarketController =
      Get.put(SearchMarketController());
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

  final List<Map<String, String>> _topConsultants = [
    {
      "name": 'DR. PRAKASH CHANDRA',
      "bio":
          'Depression, OCD, Behavioural Issues, Couples Therapy, Anxiety, Personality Issues.',
      "mobile": "9313592008"
    },
    {
      "name": "Ms.Ekta Singh",
      "bio":
          "Counselling Psychologist, Educational Psychologist, Psychotherapist, Relationship Counsellor, Child Psychologist",
      "mobile": "9953553440"
    },
    {
      "name": "Dr. Sakshi Gupta",
      "bio":
          "Clinical psychologist, Child Counsellor, Career Counsellor,Psychologist,internships",
      "mobile": "8860082131"
    },
    {
      "name": "Lalit Sharma",
      "bio": "Speech And Language Therapist ",
      "mobile": "8285366721"
    },
    {
      "name": "Nidhi Sharma",
      "bio": "speech rehabilitation, Occupational Therapy &  special education",
      "mobile": "9312408234"
    },
    {
      "name": "Dr Ankit Goel",
      "bio": "Psychiatrist,psychologist,behaviour therapy,counselling",
      "mobile": "9152571051"
    },
    {
      "name": "Ms Mariella Zanoletti",
      "bio": "Therapist, counselling psychologist, psychotherapist",
      "mobile": "9899186443"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Row(
          children: [
            // GestureDetector(
            //   onTap: () {
            //     print("side bar tapped");
            //     setState(() {
            //       _isDrawerOpen = !_isDrawerOpen;
            //     });
            //     print("opened");
            //   },
            //   child: SvgPicture.asset(
            //     "assets/icons/app-bar/app-bar-menu.svg",
            //     width: 26,
            //     height: 24,
            //     color: SolhColors.green,
            //   ),
            // ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SolhSearchField(
                  hintText: 'Anxiety, Corporate Stress, Family Isues',
                  icon: 'assets/icons/app-bar/search.svg',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ),
                    );
                  }),
            ),
            GetHelpDivider(),
            GetHelpCategory(
              title: "Search by issues",
            ),
            Container(
                margin:
                    EdgeInsets.only(left: 1.5.w, right: 1.5.w, bottom: 1.5.h),
                child: Wrap(children: [
                  Wrap(
                    children: getHelpController
                        .getIssueResponseModel.value.specializationList!
                        .sublist(
                            0,
                            getHelpController.getIssueResponseModel.value
                                        .specializationList!.length >
                                    10
                                ? 10
                                : getHelpController.getIssueResponseModel.value
                                    .specializationList!.length)
                        .map((issue) {
                      return IssuesTile(
                        title: issue.name ?? '',
                        onPressed: () {
                          AutoRouter.of(context).push(ConsultantsScreenRouter(
                              slug: issue.slug ?? '', type: 'issue'));
                        },
                      );
                    }).toList(),
                  ),
                  if (getHelpController.getIssueResponseModel.value
                          .specializationList!.length >
                      10)
                    IssuesTile(title: 'view all', onPressed: () {})
                ])),
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
                itemCount: getHelpController
                    .getSpecializationModel.value.specializationList!.length,
                shrinkWrap: true,
                itemBuilder: (_, index) => GestureDetector(
                  onTap: () {
                    AutoRouter.of(context).push(ConsultantsScreenRouter(
                        slug: getHelpController.getSpecializationModel.value
                                .specializationList![index].slug ??
                            '',
                        type: 'specialization'));
                  },
                  child: Container(
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
                              child: Image.asset(
                                  "assets/images/logo/solh-logo.png"),
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Container(
                          width: 25.w,
                          child: Text(
                            getHelpController.getSpecializationModel.value
                                    .specializationList![index].name ??
                                '',
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GetHelpDivider(),
            GetHelpCategory(
              title: "Top Consultants",
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ConsultantsScreen(
                        slug: '',
                      ))),
            ),
            Container(
              height: 17.h,
              margin: EdgeInsets.only(bottom: 2.h),
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (_, index) => TopConsultantsTile(
                        bio: _topConsultants[index]["bio"].toString(),
                        name: _topConsultants[index]["name"].toString(),
                        mobile: _topConsultants[index]["mobile"].toString(),
                      )),
            ),
            GetHelpDivider(),
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
    required VoidCallback onPressed,
  })  : _title = title,
        _onPressed = onPressed,
        super(key: key);

  final String _title;
  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressed,
      child: Container(
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
      ),
    );
  }
}

class TopConsultantsTile extends StatelessWidget {
  const TopConsultantsTile({
    required String name,
    required String bio,
    required String mobile,
    Key? key,
  })  : _name = name,
        _bio = bio,
        _mobile = mobile,
        super(key: key);

  final String _mobile;
  final String _name;
  final String _bio;

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 70.w,
      //height: 25.h,
      margin: EdgeInsets.symmetric(horizontal: 2.5.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: SolhColors.grey196.withOpacity(0.4))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
            child: Image.network(
              "https://e7.pngegg.com/pngimages/1001/748/png-clipart-doctor-raising-right-hand-illustration-physician-hospital-medicine-doctor-s-office-health-doctor-s-child-face.png",
              width: 25.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 2.w),
          Container(
              width: 42.w,
              // height: 15.h,
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(_name),
                  // Text(_qualification),
                  Text(
                    _bio,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF666666),
                        fontWeight: FontWeight.w300),
                  ),
                  Center(
                    child: SolhGreenButton(
                      height: 5.h,
                      width: 35.w,
                      child: Text(
                        "Book Appointment",
                        style: TextStyle(fontSize: 12),
                      ),
                      onPressed: () {
                        launch("tel://$_mobile");
                      },
                    ),
                  )
                  // Text(
                  //   "07 Year of Experience",
                  //   style: TextStyle(fontSize: 12),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 1.w),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Icon(
                  //             Icons.people,
                  //             color: SolhColors.green,
                  //             size: 18,
                  //           ),
                  //           Text(
                  //             "72",
                  //             style: SolhTextStyles.GreenBorderButtonText,
                  //           )
                  //         ],
                  //       ),
                  //       Text(
                  //         "Free",
                  //         style: TextStyle(color: SolhColors.green),
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              )),
        ],
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
