import 'package:auto_route/auto_route.dart';
import 'package:solh/bottom-navigation/bottom-navigation.dart';
import 'package:solh/ui/screens/connect/connect-screen.dart';
import 'package:solh/ui/screens/home/homescreen.dart';
import 'package:solh/ui/screens/my-goals/my-goals-screen.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screen.dart';
import 'package:solh/ui/screens/share/share-screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
        path: "MasterScreen",
        name: "MasterScreenRouter",
        page: MasterScreen,
        children: [
          AutoRoute(
            path: "HomeScreen",
            name: "HomeScreenRouter",
            page: HomeScreen,
          ),
          AutoRoute(
            path: "ShareScreen",
            name: "ShareScreenRouter",
            page: ShareScreen,
          ),
          AutoRoute(
            path: "ConnectScreen",
            name: "ConnectScreenRouter",
            page: ConnectScreen,
          ),
          AutoRoute(
            path: "MyGoalsScreen",
            name: "MyGoalsScreenRouter",
            page: MyGoalsScreen,
          ),
          AutoRoute(
            path: "MyProfileScreen",
            name: "MyProfileScreenRouter",
            page: MyProfileScreen,
          ),
        ]),
  ],
)
class $AppRouter {}
