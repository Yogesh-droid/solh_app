import 'package:auto_route/auto_route.dart';
import 'package:solh/bottom-navigation/bottom-navigation.dart';
import 'package:solh/ui/screens/home/homescreen.dart';

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
            page: HomeScreen,
          ),
          AutoRoute(
            path: "ConnectScreen",
            name: "ConnectScreenRouter",
            page: HomeScreen,
          ),
          AutoRoute(
            path: "MyGoalsScreen",
            name: "MyGoalsScreenRouter",
            page: HomeScreen,
          ),
        ]),
  ],
)
class $AppRouter {}
