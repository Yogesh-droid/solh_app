import 'package:auto_route/auto_route.dart';
import 'package:solh/main.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: "/",
      name: "MyHomePageRouter",
      page: MyHomePage,
    ),
  ],
)
class $AppRouter {}
