import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/journaling/widgets/journal_tile.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:swipe_deck/swipe_deck.dart';

import '../../../bloc/user-bloc.dart';
import '../../../controllers/getHelp/get_help_controller.dart';
import '../../../controllers/group/create_group_controller.dart';
import '../../../controllers/journals/journal_comment_controller.dart';
import '../../../controllers/journals/journal_page_controller.dart';
import '../../../controllers/mood-meter/mood_meter_controller.dart';
import '../../../controllers/my_diary/my_diary_controller.dart';
import '../../../widgets_constants/constants/colors.dart';
import '../journaling/side_drawer.dart';
import '../journaling/whats_in_your_mind_section.dart';
import '../mood-meter/mood_meter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CreateGroupController _controller = Get.put(CreateGroupController());
  JournalPageController _journalPageController =
      Get.put(JournalPageController());
  MyDiaryController myDiaryController = Get.put(MyDiaryController());
  GetHelpController getHelpController = Get.put(GetHelpController());
  JournalCommentController journalCommentController =
      Get.put(JournalCommentController());
  MoodMeterController moodMeterController = Get.find();
  late DateTime _lastDateMoodMeterShown;
  late bool isMoodMeterShown;
  @override
  void initState() {
    super.initState();
    userBlocNetwork.getMyProfileSnapshot();
    openMoodMeter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SideDrawer(),
            HomePage(),
          ],
        ),
      ),
    );
  }

  Future<void> openMoodMeter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('lastDateShown') != null) {
      if (DateTime.fromMillisecondsSinceEpoch(prefs.getInt('lastDateShown')!)
              .day ==
          DateTime.now().day) {
        return;
      } else {
        await moodMeterController.getMoodList();
        if (moodMeterController.moodList.length > 0) {
          showBottomSheet(
              enableDrag: true,
              context: context,
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/intro/png/mood_meter_bg.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Container()),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: MoodMeter(),
                      ),
                    ],
                  ),
                );
              });
        }

        prefs.setBool('moodMeterShown', true);
        prefs.setInt('lastDateShown', DateTime.now().millisecondsSinceEpoch);
      }
    } else {
      await moodMeterController.getMoodList();
      if (moodMeterController.moodList.length > 0) {
        showBottomSheet(
            enableDrag: true,
            context: context,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/intro/png/mood_meter_bg.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Container()),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: MoodMeter(),
                    ),
                  ],
                ),
              );
            });
      }

      prefs.setBool('moodMeterShown', true);
      prefs.setInt('lastDateShown', DateTime.now().millisecondsSinceEpoch);
    }
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  JournalPageController _journalPageController = Get.find();
  bool _isDrawerOpen = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      left: _isDrawerOpen ? 78.w : 0,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.35),
                offset: const Offset(
                  14.0,
                  14.0,
                ),
                blurRadius: 20.0,
                spreadRadius: 4.0,
              )
            ],
            color: Colors.white),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Scaffold(
              appBar: getAppBar(),
              body: Column(children: [
                WhatsOnYourMindSection(),
                SizedBox(
                  height: 10,
                ),
                getTrendingPostUI(),
              ]),
            ),
            if (_isDrawerOpen)
              GestureDetector(
                onTap: () => setState(() => _isDrawerOpen = false),
                child: Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
          ],
        ),
      ),
    );
  }

  SolhAppBar getAppBar() {
    return SolhAppBar(
      title: Row(
        children: [
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: InkWell(
              onTap: () {
                print("side bar tapped");
                setState(() {
                  _isDrawerOpen = !_isDrawerOpen;
                });
                print("opened");
              },
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                height: 40,
                width: 40,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: SvgPicture.asset(
                  "assets/icons/app-bar/app-bar-menu.svg",
                  width: 26,
                  height: 24,
                  color: SolhColors.green,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 2.h,
          ),
          Text(
            "Home",
            style: SolhTextStyles.AppBarText,
          ),
        ],
      ),
      isLandingScreen: true,
    );
  }

  Widget getTrendingPostUI() {
    return CarouselSlider(
        items: _journalPageController.journalsList.map((journal) {
          return Container(
            child: PostContentWidget(
              journalModel: journal,
              index: _journalPageController.journalsList.indexOf(journal),
              isMyJournal: false,
            ),
          );
        }).toList(),
        options: CarouselOptions(
          height: 300,
          aspectRatio: 3 / 4,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: false,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 2000),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            setState(() {});
          },
          scrollDirection: Axis.horizontal,
        ));
  }
}
