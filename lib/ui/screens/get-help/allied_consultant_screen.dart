import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class AlliedConsultantScreen extends StatelessWidget {
  const AlliedConsultantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldGreenWithBackgroundArt(
      appBar: SolhAppBar(
        isLandingScreen: false,
        backgroundColor: Colors.transparent,
        title: Text(''),
      ),
      body: Column(
        children: [getProfileDetail(), Expanded(child: AboutAndPlans())],
      ),
    );
  }
}

Widget getProfileDetail() {
  return Container(
      child: Row(
    children: [
      getProfileImage(),
      Column(
        children: [
          Text('Allied therapist Name '),
          Text('Profession(Yoga)'),
          Text('07 years'),
          Row(
            children: [
              getAnalyticsBox(
                  icon: Icon(CupertinoIcons.person_crop_rectangle),
                  no: fakeJson['numberOfConsultations'],
                  title: 'Consultations'),
              getAnalyticsBox(
                  icon: Icon(CupertinoIcons.star),
                  no: fakeJson['rating'],
                  title: 'Rating'),
              getAnalyticsBox(
                  icon: Icon(CupertinoIcons.person_crop_rectangle),
                  no: fakeJson['posts'],
                  title: 'Posts')
            ],
          )
        ],
      )
    ],
  ));
}

Widget getAnalyticsBox(
    {required Widget icon, required no, required String title}) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5), color: SolhColors.greenShade1),
    child: Column(
      children: [
        Row(
          children: [
            icon,
            SizedBox(
              width: 5,
            ),
            Text(
              no.toString(),
              style: SolhTextStyles.SmallTextWhiteS12W7,
            )
          ],
        ),
        Text(
          title,
          style: SolhTextStyles.SmallTextWhiteS12W7,
        )
      ],
    ),
  );
}

Widget getProfileImage() {
  return Stack(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: SolhColors.white),
              borderRadius: BorderRadius.circular(8)),
          height: 45.w,
          width: 35.w,
          child: FittedBox(
            fit: BoxFit.fill,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                fakeJson['profilePicture'],
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 6.w,
              width: 12.w,
              decoration: BoxDecoration(
                  color: SolhColors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 2,
                      color: Colors.black26,
                    )
                  ]),
              child: Center(
                  child: SvgPicture.asset(
                'assets/images/verified_consultant.svg',
                color: SolhColors.primary_green,
                height: 15,
              )),
            ),
          ],
        ),
      )
    ],
  );
}

class AboutAndPlans extends StatefulWidget {
  const AboutAndPlans({super.key});

  @override
  State<AboutAndPlans> createState() => _AboutAndPlansState();
}

class _AboutAndPlansState extends State<AboutAndPlans>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState

    _tabController =
        TabController(length: fakeJson['plans'].length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        color: SolhColors.bg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Column(
        children: [
          Text('About'),
          Text(
            fakeJson['bio'],
          ),
          SizedBox(
            width: 100.w,
            height: 50,
            child: TabBar(
                controller: _tabController,
                tabs: fakeJson['plans'].map<Widget>((e) {
                  return Tab(
                    child: Text(
                      'plan ${fakeJson['plans'].indexOf(e) + 1}',
                      style: SolhTextStyles.QS_body_1_bold,
                    ),
                  );
                }).toList()),
          ),
          SizedBox(
            height: 50.h,
            width: 100.w,
            child: TabBarView(
                controller: _tabController,
                children: fakeJson['plans'].map<Widget>((e) {
                  return Container();
                }).toList()),
          )
        ],
      ),
    );
  }
}

Map<String, dynamic> fakeJson = {
  "name": 'Allied therapist Name',
  "profession": 'Profession(Yoga)',
  "experience": "07 Year ",
  "numberOfConsultations": 27,
  "rating": '4.5',
  "posts": 17,
  "bio":
      "Self experiences/ package highlights etc/Other Achivements,  orci cras. Elementum, Lorem ipsum dolor amet, consectetur adipiscing elit. More",
  "previewVideo": "",
  "isVerified": "",
  "profilePicture": "https://picsum.photos/200",
  "plans": [
    {
      "Duration": "4.5 hours",
      "numberOfVideos": "5",
      "sessionDuration": "7 days",
      "price": "2500",
      "currency": "Rs",
      "highlightedPoint": [
        "Full value Yoga-practice includes pranayama kriyas, asanas, relaxation. ",
        "2 private yoga session for 30 mins each"
      ],
      "Benefits": [
        "Yoga improves strength, balance and flexibility",
        "Yoga helps with back pain relief",
        "Yoga can ease arthritis symptoms",
      ],
      "VideoPackage": [
        {
          "videoName": "",
          "duration": "30 mins",
          "aboutVideo":
              "About video session Lorem ipsum dolor sit amet consectetur. Tortor consequat ut leo sed at. Dui vulputate in ",
        },
        {
          "videoName": "",
          "duration": "30 mins",
          "aboutVideo":
              "About video session Lorem ipsum dolor sit amet consectetur. Tortor consequat ut leo sed at. Dui vulputate in ",
        },
        {
          "videoName": "",
          "duration": "30 mins",
          "aboutVideo":
              "About video session Lorem ipsum dolor sit amet consectetur. Tortor consequat ut leo sed at. Dui vulputate in ",
        },
        {
          "videoName": "",
          "duration": "30 mins",
          "aboutVideo":
              "About video session Lorem ipsum dolor sit amet consectetur. Tortor consequat ut leo sed at. Dui vulputate in ",
        },
      ],
    },
    {
      "Duration": "4.5 hours",
      "numberOfVideos": "5",
      "sessionDuration": "7 days",
      "price": "2500",
      "currency": "Rs",
      "highlightedPoint": [
        "Full value Yoga-practice includes pranayama kriyas, asanas, relaxation. ",
        "2 private yoga session for 30 mins each"
      ],
      "Benefits": [
        "Yoga improves strength, balance and flexibility",
        "Yoga helps with back pain relief",
        "Yoga can ease arthritis symptoms",
      ],
      "VideoPackage": [
        {
          "videoName": "",
          "duration": "30 mins",
          "aboutVideo":
              "About video session Lorem ipsum dolor sit amet consectetur. Tortor consequat ut leo sed at. Dui vulputate in ",
        },
        {
          "videoName": "",
          "duration": "30 mins",
          "aboutVideo":
              "About video session Lorem ipsum dolor sit amet consectetur. Tortor consequat ut leo sed at. Dui vulputate in ",
        },
        {
          "videoName": "",
          "duration": "30 mins",
          "aboutVideo":
              "About video session Lorem ipsum dolor sit amet consectetur. Tortor consequat ut leo sed at. Dui vulputate in ",
        },
        {
          "videoName": "",
          "duration": "30 mins",
          "aboutVideo":
              "About video session Lorem ipsum dolor sit amet consectetur. Tortor consequat ut leo sed at. Dui vulputate in ",
        },
      ],
    },
    {
      "Duration": "4.5 hours",
      "numberOfVideos": "5",
      "sessionDuration": "7 days",
      "price": "2500",
      "currency": "Rs",
      "highlightedPoint": [
        "Full value Yoga-practice includes pranayama kriyas, asanas, relaxation. ",
        "2 private yoga session for 30 mins each"
      ],
      "Benefits": [
        "Yoga improves strength, balance and flexibility",
        "Yoga helps with back pain relief",
        "Yoga can ease arthritis symptoms",
      ],
      "VideoPackage": [
        {
          "videoName": "",
          "duration": "30 mins",
          "aboutVideo":
              "About video session Lorem ipsum dolor sit amet consectetur. Tortor consequat ut leo sed at. Dui vulputate in ",
        },
        {
          "videoName": "",
          "duration": "30 mins",
          "aboutVideo":
              "About video session Lorem ipsum dolor sit amet consectetur. Tortor consequat ut leo sed at. Dui vulputate in ",
        },
        {
          "videoName": "",
          "duration": "30 mins",
          "aboutVideo":
              "About video session Lorem ipsum dolor sit amet consectetur. Tortor consequat ut leo sed at. Dui vulputate in ",
        },
        {
          "videoName": "",
          "duration": "30 mins",
          "aboutVideo":
              "About video session Lorem ipsum dolor sit amet consectetur. Tortor consequat ut leo sed at. Dui vulputate in ",
        },
      ],
    }
  ],
  "reviews": [
    {
      "seekerProfilePicture": "https://picsum.photos/200",
      "seekername": "",
      "time": "",
      "rating": "4.5",
      "review":
          "Lorem ipsum dolor sit amet consectetur. Accumsan turpis eu egestas tincidunt. Id nisl gravida.",
    },
    {
      "seekerProfilePicture": "https://picsum.photos/200",
      "seekername": "",
      "time": "",
      "rating": "4.5",
      "review":
          "Lorem ipsum dolor sit amet consectetur. Accumsan turpis eu egestas tincidunt. Id nisl gravida.",
    },
    {
      "seekerProfilePicture": "https://picsum.photos/200",
      "seekername": "",
      "time": "",
      "rating": "4.5",
      "review":
          "Lorem ipsum dolor sit amet consectetur. Accumsan turpis eu egestas tincidunt. Id nisl gravida.",
    },
    {
      "seekerProfilePicture": "https://picsum.photos/200",
      "seekername": "",
      "time": "",
      "rating": "4.5",
      "review":
          "Lorem ipsum dolor sit amet consectetur. Accumsan turpis eu egestas tincidunt. Id nisl gravida.",
    }
  ]
};
