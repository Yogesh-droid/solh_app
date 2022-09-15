import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:new_version/new_version.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/bottom-navigation/bottom_navigator_controller.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import '../controllers/goal-setting/goal_setting_controller.dart';
import '../widgets_constants/buttons/custom_buttons.dart';
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
    checkVersion(context);
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
            iconSize: 20,
            unselectedItemColor: SolhColors.black666,
            currentIndex: tabsRouter.activeIndex,
            unselectedLabelStyle: TextStyle(height: 1.5),
            selectedFontSize: 11,
            unselectedFontSize: 11,
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

  Future<void> checkVersion(BuildContext context) async {
    print("&" * 30 + " Running checkVersion");
    try {
      final newVersion = NewVersion(
        iOSId: 'com.solh.solhApp',
        androidId: 'com.solh.app',
      );
      var value = await newVersion.getVersionStatus();
      if (value != null) {
        print("&" * 30 + " ${value.toString()}");
        print("&" * 30 + " ${value.appStoreLink.toString()}");
        print("&" * 30 + " ${value.localVersion.toString()}");
        print("&" * 30 + " ${value.storeVersion.toString()}");
      } else {
        print("value is null");
      }
      newVersion.showAlertIfNecessary(context: context);
    } on Exception catch (e) {
      print("&" * 30 + " ${e.toString()}");
    }
  }

  // actions: [
  //               SolhPinkBorderMiniButton(
  //                 child: Text(
  //                   'No',
  //                   style: SolhTextStyles.PinkBorderButtonText,
  //                 ),
  //                 onPressed: () {
  //                   Navigator.of(context).pop(false);
  //                 },
  //               ),
  //               SolhGreenMiniButton(
  //                 child: Text(
  //                   'Yes',
  //                   style: SolhTextStyles.GreenButtonText,
  //                 ),
  //                 onPressed: () {
  //                   Navigator.of(context).pop(true);
  //                 },
  //               )
  //             ],

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

      // print(bottomNavigatorController.tabrouter!.activeIndex);
      // DateTime now = DateTime.now();
      // if (backPressedTime == null ||
      //     now.difference(backPressedTime) > Duration(seconds: 2)) {
      //   backPressedTime = now;
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text(
      //       'Press back button again to exit',
      //       style: TextStyle(color: Colors.white),
      //     ),
      //     backgroundColor: Colors.red,
      //     elevation: 5,
      //     duration: Duration(seconds: 2),
      //     shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.only(
      //             topLeft: Radius.circular(5), topRight: Radius.circular(5))),
      //   ));
      //   return Future.value(false);
      // } else {
      //   return Future.value(true);
      // }
    }
  }
}
