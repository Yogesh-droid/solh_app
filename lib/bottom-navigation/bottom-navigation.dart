import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class MasterScreen extends StatefulWidget {
  MasterScreen({this.index});
  final int? index;
  @override
  _MasterScreenState createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        HomeScreenRouter(),
        ShareScreenRouter(),
        ConnectScreenRouter(),
        MyGoalsScreenRouter(),
        MyProfileScreenRouter(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        // if (widget.index != null) tabsRouter.setActiveIndex(widget.index!);
        return BottomNavigationBar(
          enableFeedback: true,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: SolhColors.green,
          showUnselectedLabels: true,
          iconSize: 20,
          unselectedItemColor: SolhColors.green,
          currentIndex: tabsRouter.activeIndex,
          unselectedLabelStyle: TextStyle(height: 1.5),
          selectedFontSize: 10,
          unselectedFontSize: 10,
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
                icon: Icon(tabsRouter.activeIndex == 1
                    ? CupertinoIcons.person_3_fill
                    : CupertinoIcons.person_3),
                label: "journaling"),
            BottomNavigationBarItem(
              icon: Icon(tabsRouter.activeIndex == 2
                  ? CupertinoIcons.person_add_solid
                  : CupertinoIcons.person_add),
              label: "Connect",
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
