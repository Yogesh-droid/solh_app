import 'package:auto_route/auto_route.dart';
import 'package:solh/bottom-navigation/bottom-navigation.dart';
import 'package:solh/ui/screens/comment/comment-screen.dart';
import 'package:solh/ui/screens/connect/connect-screen.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/get-help/view-all/consultants.dart';
import 'package:solh/ui/screens/home/homescreen.dart';
import 'package:solh/ui/screens/intro/intro-crousel.dart';
import 'package:solh/ui/screens/journaling/journaling.dart';
import 'package:solh/ui/screens/my-goals/my-goals-screen.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screen.dart';
import 'package:solh/ui/screens/journaling/create-journal.dart';
import 'package:solh/ui/screens/my-profile/posts/post.dart';
import 'package:solh/ui/screens/my-profile/profile/edit-profile.dart';
import 'package:solh/ui/screens/my-profile/settings/account-privacy.dart';
import 'package:solh/ui/screens/my-profile/settings/settings.dart';
import 'package:solh/ui/screens/phone-auth/otp-screen.dart';
import 'package:solh/ui/screens/phone-auth/phone-auth.dart';
import 'package:solh/ui/screens/profile-setup/profile-setup.dart';
import 'package:solh/ui/screens/sos/setup-sos.dart';
import 'package:solh/ui/screens/sos/sos.dart';
import 'package:solh/ui/screens/video-call/video-call-counsellor.dart';

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
              path: "JournalingScreen",
              name: "JournalingScreenRouter",
              page: EmptyRouterPage,
              children: [
                AutoRoute(path: "", page: JournalingScreen),
                AutoRoute(
                  path: "CreatePostScreen",
                  name: "CreatePostScreenRouter",
                  page: CreatePostScreen,
                ),
                AutoRoute(
                  path: "ConnectScreen",
                  name: "ConnectScreenRouter",
                  page: ConnectProfileScreen,
                ),
                AutoRoute(
                  path: "CommentScreen",
                  name: "CommentScreenRouter",
                  page: CommentScreen,
                )
              ]),
          AutoRoute(
            path: "GetHelpScreen",
            name: "GetHelpScreenRouter",
            page: GetHelpScreen,
          ),
          AutoRoute(
            path: "MyGoalsScreen",
            name: "MyGoalsScreenRouter",
            page: MyGoalsScreen,
          ),
          AutoRoute(
              path: "MyProfileScreen",
              name: "MyProfileScreenRouter",
              page: EmptyRouterPage,
              children: [
                AutoRoute(path: "", page: MyProfileScreen),
                AutoRoute(
                  path: "PostScreen",
                  name: "PostScreenRouter",
                  page: PostScreen,
                ),
                AutoRoute(
                  path: "SettingsScreen",
                  name: "SettingsScreenRouter",
                  page: SettingsScreen,
                ),
                AutoRoute(
                  path: "AccountPrivacyScreen",
                  name: "AccountPrivacyScreenRouter",
                  page: AccountPrivacyScreen,
                ),
                AutoRoute(
                  path: "EditMyProfileScreen",
                  name: "EditMyProfileScreenRouter",
                  page: EditMyProfileScreen,
                ),
              ]),
        ]),
    AutoRoute(
      path: "IntroCarouselScreen",
      name: "IntroCarouselScreenRouter",
      page: IntroCrousel,
    ),
    AutoRoute(
        path: "CreateProfileScreen",
        name: "CreateProfileScreenRouter",
        page: CreateProfileScreen),
    AutoRoute(
      path: "PhoneAuthScreen",
      name: "PhoneAuthScreenRouter",
      page: PhoneAuthScreen,
    ),
    AutoRoute(
      path: "OTPScreen",
      name: "OTPScreenRouter",
      page: OTPScreen,
    ),
    AutoRoute(
      path: "ConsultantsScreen",
      name: "ConsultantsScreenRouter",
      page: ConsultantsScreen,
    ),
    AutoRoute(
      path: "SOSScreen",
      name: "SOSScreenRouter",
      page: SOSDialog,
    ),
    AutoRoute(
      path: "SetupSOS",
      name: "SetupSOSScreenRouter",
      page: SetupSOSScreen,
    ),
    AutoRoute(
      path: "VideoCallCounsellor",
      name: "VideoCallCounsellorRouter",
      page: VideoCallCounsellor,
    ),
  ],
)
class $AppRouter {}
