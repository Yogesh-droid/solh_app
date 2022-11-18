import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/home/homescreen.dart';
import 'package:solh/ui/screens/journaling/journaling.dart';
import 'package:solh/ui/screens/journaling/side_drawer.dart';
import 'package:solh/ui/screens/my-goals/my-goals-screen.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screen.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import '../controllers/journals/journal_page_controller.dart';
import '../widgets_constants/constants/textstyles.dart';
import 'bottom_navigator_controller.dart';

class MasterScreen extends StatelessWidget {
  const MasterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SideDrawer(),
            MasterScreen2(),
          ],
        ),
      ),
    );
    ;
  }
}

class MasterScreen2 extends StatelessWidget {
  final JournalPageController journalPageController =
      Get.put(JournalPageController());
  final BottomNavigatorController bottomNavigatorController =
      Get.put(BottomNavigatorController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
      return _onWillPop(context);
    }, child: Obx(() {
      return AnimatedPositioned(
        duration: Duration(milliseconds: 300),
        left: bottomNavigatorController.isDrawerOpen.value ? 78.w : 0,
        child: Container(
          height: 100.h,
          width: 100.w,
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
          child: Scaffold(
              appBar: SolhAppBar(
                title: getDrawer(),
                isLandingScreen: true,
              ),
              body: Obx(
                () => IndexedStack(
                    index: bottomNavigatorController.activeIndex.value,
                    children: [
                      HomeScreen(),
                      Journaling(),
                      GetHelpScreen(),
                      MyGoalsScreen(),
                      MyProfileScreen()
                    ]),
              ),
              // body: Obx(() {
              //   switch (bottomNavigatorController.activeIndex.value) {
              //     case 0:
              //       return HomeScreen();
              //     case 1:
              //       return Journaling();
              //     case 3:
              //       return GetHelpScreen();
              //     case 4:
              //       return MyProfileScreen();
              //     default:
              //       return Center(child: Text('Page not found'));
              //   }
              // }),
              bottomNavigationBar: getBottomBar()),
        ),
      );
    }));
  }

  Future<bool> _onWillPop(BuildContext context) async {
    if (bottomNavigatorController.tabrouter!.activeIndex != 0) {
      bottomNavigatorController.tabrouter!.setActiveIndex(0);
      return Future.value(false);
    } else {
      return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              actionsPadding: EdgeInsets.all(8.0),
              content: Text(
                'Do you really want to exit app ?',
                style: SolhTextStyles.JournalingDescriptionText,
              ),
              actions: [
                TextButton(
                    child: Text(
                      'No',
                      style: SolhTextStyles.GreenButtonText,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    }),
                TextButton(
                    child: Text(
                      'Yes',
                      style: SolhTextStyles.GreenButtonText,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    }),
              ],
            );
          });
    }
  }

  BottomNavigationBar getBottomBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      enableFeedback: true,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: SolhColors.green,
      showUnselectedLabels: true,
      unselectedItemColor: SolhColors.grey102,
      unselectedLabelStyle: TextStyle(
        height: 1.5,
      ),
      selectedFontSize: 13,
      unselectedFontSize: 13,
      onTap: (index) => bottomNavigatorController.activeIndex.value = index,
      items: [
        BottomNavigationBarItem(
          icon: Obx(
            () => Icon(
              bottomNavigatorController.activeIndex.value == 0
                  ? CupertinoIcons.house_fill
                  : CupertinoIcons.house,
              color: bottomNavigatorController.activeIndex.value == 0
                  ? SolhColors.green
                  : SolhColors.grey102,
            ),
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
            icon: Obx(
              () => bottomNavigatorController.activeIndex.value == 1
                  ? SvgPicture.asset('assets/images/journaling.svg')
                  : SvgPicture.asset('assets/images/journalling outline.svg',
                      color: SolhColors.grey102),
            ),
            label: "journaling"),
        userBlocNetwork.getUserType == 'SolhProvider'
            ? BottomNavigationBarItem(
                icon: Obx((() => Icon(
                      CupertinoIcons.calendar_badge_plus,
                      color: bottomNavigatorController.activeIndex.value == 2
                          ? SolhColors.green
                          : SolhColors.grey102,
                    ))),
                label: "My Schedule")
            : BottomNavigationBarItem(
                icon:
                    Obx((() => bottomNavigatorController.activeIndex.value == 2
                        ? SvgPicture.asset("assets/images/get help tab.svg")
                        : SvgPicture.asset(
                            "assets/images/get help. outline.svg",
                            color: Colors.grey.shade600,
                          ))),
                label: "Get Help",
              ),
        BottomNavigationBarItem(
            icon: Obx(() => SvgPicture.asset(
                  'assets/images/groal tab vector.svg',
                  color: bottomNavigatorController.activeIndex.value == 3
                      ? SolhColors.green
                      : Colors.grey.shade600,
                )),
            label: "My Goals"),
        BottomNavigationBarItem(
            icon: Obx(() => SvgPicture.asset(
                  'assets/images/profile.svg',
                  color: bottomNavigatorController.activeIndex.value == 4
                      ? SolhColors.green
                      : Colors.grey.shade600,
                )),
            label: "My profile")
      ],
    );
  }

  Widget getDrawer() {
    return Container(
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: InkWell(
          onTap: () {
            print("side bar tapped");

            bottomNavigatorController.isDrawerOpen.value
                ? bottomNavigatorController.isDrawerOpen.value = false
                : bottomNavigatorController.isDrawerOpen.value = true;

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
        ));
  }
}






/* import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/bottom-navigation/bottom_navigator_controller.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import '../controllers/goal-setting/goal_setting_controller.dart';
import '../widgets_constants/constants/textstyles.dart';

class MasterScreen extends StatefulWidget {
  MasterScreen({this.index});
  final int? index;
  @override
  _MasterScreenState createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  GoalSettingController goalSettingController =
      Get.put(GoalSettingController());
  BottomNavigatorController bottomNavigatorController =
      Get.put(BottomNavigatorController());
  var backPressedTime;
  List<int> selectedIndex = [];

  @override
  void initState() {
    print("MasterScreen initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: AutoTabsScaffold(
        routes: [
          HomeScreenRouter(),
          JournalingScreenRouter(),
          if (userBlocNetwork.getUserType == 'SolhProvider')
            DoctorsAppointmentsScreenRouter()
          else
            GetHelpScreenRouter(),
          MyGoalsScreenRouter(),
          MyProfileScreenRouter(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          // if (widget.index != null) tabsRouter.setActiveIndex(widget.index!);
          bottomNavigatorController.tabrouter = tabsRouter;
          return BottomNavigationBar(
            enableFeedback: true,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: SolhColors.green,
            showUnselectedLabels: true,
            // iconSize: 20,
            unselectedItemColor: SolhColors.black666,
            currentIndex: tabsRouter.activeIndex,
            unselectedLabelStyle: TextStyle(height: 1.5),
            selectedFontSize: 13,
            unselectedFontSize: 13,
            // backgroundColor: SolhColors.green,
            // onTap: (index) async {
            //   if (index == 2 || index == 3) {
            //     bool isLogin = await authBlocNetwork.checkLogin(context);
            //     if (isLogin) {
            //       if (index == 2)
            //         context.pushRoute(MyBagRouter());
            //       else
            //         tabsRouter.setActiveIndex(index);
            //     }
            //   } else {
            //     tabsRouter.setActiveIndex(index);
            //   }
            // },
            onTap: (index) => tabsRouter.setActiveIndex(index),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    tabsRouter.activeIndex == 0
                        ? CupertinoIcons.house_fill
                        : CupertinoIcons.house,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: tabsRouter.activeIndex == 1
                      // ? SvgPicture.asset(
                      //     'assets/images/home_selected.svg',
                      //     fit: BoxFit.fitHeight,
                      //   )
                      ? SvgPicture.asset('assets/images/journaling.svg')
                      : SvgPicture.asset(
                          'assets/images/journalling outline.svg',
                          color: SolhColors.grey102),
                  label: "journaling"),
              userBlocNetwork.getUserType == 'SolhProvider'
                  ? BottomNavigationBarItem(
                      icon: tabsRouter.activeIndex == 2
                          ? Icon(
                              CupertinoIcons.calendar_badge_plus,
                              color: SolhColors.green,
                            )
                          : Icon(
                              CupertinoIcons.calendar_badge_plus,
                              color: SolhColors.grey102,
                            ),
                      label: "My Schedule")
                  : BottomNavigationBarItem(
                      icon: tabsRouter.activeIndex == 2
                          ? SvgPicture.asset("assets/images/get help tab.svg")
                          : SvgPicture.asset(
                              "assets/images/get help. outline.svg",
                              color: Colors.grey.shade600,
                            ),
                      label: "Get Help",
                    ),
              BottomNavigationBarItem(
                  icon: tabsRouter.activeIndex == 3
                      ? SvgPicture.asset(
                          'assets/images/groal tab vector.svg',
                          color: SolhColors.green,
                        )
                      : SvgPicture.asset(
                          'assets/images/groal tab vector.svg',
                          color: Colors.grey.shade600,
                        ),
                  label: "My Goals"),
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.person_circle,
                    size: 24,
                  ),
                  label: "My profile")
            ],
          );
        },
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (bottomNavigatorController.tabrouter!.activeIndex != 0) {
      bottomNavigatorController.tabrouter!.setActiveIndex(0);
      return Future.value(false);
    } else {
      return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              actionsPadding: EdgeInsets.all(8.0),
              content: Text(
                'Do you really want to exit app ?',
                style: SolhTextStyles.JournalingDescriptionText,
              ),
              actions: [
                TextButton(
                    child: Text(
                      'No',
                      style: SolhTextStyles.GreenButtonText,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    }),
                TextButton(
                    child: Text(
                      'Yes',
                      style: SolhTextStyles.GreenButtonText,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    }),
              ],
            );
          });

    
    }
  }
}
 */