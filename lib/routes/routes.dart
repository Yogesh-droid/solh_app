import 'package:auto_route/auto_route.dart';
import 'package:solh/bottom-navigation/bottom-navigation.dart';
import 'package:solh/phone-auth/otp-screen.dart';
import 'package:solh/phone-auth/phone-auth.dart';
import 'package:solh/ui/screens/comment/comment-screen.dart';
import 'package:solh/ui/screens/connect/connect-screen.dart';
import 'package:solh/ui/screens/home/homescreen.dart';
import 'package:solh/ui/screens/intro/intro-crousel.dart';
import 'package:solh/ui/screens/my-goals/my-goals-screen.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screen.dart';
import 'package:solh/ui/screens/journaling/create-post.dart';
import 'package:solh/ui/screens/journaling/share-screen.dart';

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
              page: EmptyRouterPage,
              children: [
                AutoRoute(
                  path: "",
                  page: ShareScreen,
                ),
                AutoRoute(
                  path: "CreatePostScreen",
                  name: "CreatePostScreenRouter",
                  page: CreatePostScreen,
                ),
                AutoRoute(
                  path: "CommentScreen",
                  name: "CommentScreenRouter",
                  page: CommentScreen,
                )
              ]),
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
    AutoRoute(
      path: "IntroCarouselScreen",
      name: "IntroCarouselScreenRouter",
      page: IntroCrousel,
    ),
    AutoRoute(
      path: "PhoneAuthScreen",
      name: "PhoneAuthScreenRouter",
      page: PhoneAuthScreen,
    ),
    AutoRoute(
      path: "OTPScreen",
      name: "OTPScreenRouter",
      page: OTPScreen,
    )
  ],
)
class $AppRouter {}
