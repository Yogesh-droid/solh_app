import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:solh/bottom-navigation/bottom_navigator_controller.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

import '../controllers/goal-setting/goal_setting_controller.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        HomeScreenRouter(),
        JournalingScreenRouter(),
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
                icon: Icon(
                  tabsRouter.activeIndex == 1
                      ? CupertinoIcons.person_3_fill
                      : CupertinoIcons.person_3,
                  size: 25,
                ),
                label: "journaling"),
            BottomNavigationBarItem(
              icon: tabsRouter.activeIndex == 2
                  ? SvgPicture.asset(
                      "assets/icons/bottom-navigation-bar/get-help.svg")
                  : SvgPicture.asset(
                      "assets/icons/bottom-navigation-bar/get-help-outline.svg"),
              label: "Get Help",
            ),
            BottomNavigationBarItem(
                icon: Icon(tabsRouter.activeIndex == 3
                    ? CupertinoIcons.check_mark_circled_solid
                    : CupertinoIcons.check_mark_circled),
                label: "My Goals"),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.line_horizontal_3,
                ),
                label: "My profile")
          ],
        );
      },
    );
  }
}
