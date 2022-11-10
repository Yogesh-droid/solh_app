import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:solh/bottom-navigation/bottom-navigation.dart';
import 'package:solh/ui/screens/comment/comment-screen.dart';
import 'package:solh/ui/screens/connect/connect-screen.dart';
import 'package:solh/ui/screens/connect/connect_screen.dart';
import 'package:solh/ui/screens/doctor/appointment_page.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/get-help/view-all/consultants.dart';
import 'package:solh/ui/screens/groups/invite_member_ui.dart';
import 'package:solh/ui/screens/home/homescreen.dart';
import 'package:solh/ui/screens/intro/intro-crousel.dart';
import 'package:solh/ui/screens/journaling/journaling.dart';
import 'package:solh/ui/screens/my-goals/my-goals-screen.dart';
import 'package:solh/ui/screens/my-profile/appointments/appointment_screen.dart';
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
import 'package:solh/widgets_constants/appbars/app-bar.dart';

class AppRoutes {
  ////  user profile related  /////
  ///
  static const String userProfile = '/userProfile';
  static const String connectScreen = '/connectScreen';
  static const String myProfile = '/myProfile';
  static const String editProfilePage = '/editProfilePage';
  static const String editAnonymousProfile = '/editAnonProfilePage';
  static const String createProfile = '/createProfile';

  ////  post related  /////
  static const String commentScreen = '/commentScreen';
  static const String master = '/';
  static const String introScreen = '/intro';
  static const String homeScreen = '/home';
  static const String journaling = '/journaling';
  static const String createJournal = '/createJournal';
  static const String userPostScreen = '/userPostScreen';

  ////    Get help related  ////////
  ///
  static const String getHelpPage = '/getHelpPage';
  static const String appointmentPage = '/appointmentPage';
  static const String viewAllConsultant = '/viewAllConsultant';

  /// Goal related  ////
  static const String myGoalScreen = '/myGoalScreen';

  //// Auth related  ////
  static const String phoneAuthScreen = '/phoneAuthScreen';
  static const String otpScreen = '/otpScreen';

  /// Group related  ///
  ///
  static const String inviteGroupMemberPage = '/inviteGroupMemberPage';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final Object? args = routeSettings.arguments;

    switch (routeSettings.name) {
      case AppRoutes.master:
        return MaterialPageRoute(builder: ((context) => MasterScreen()));
      case AppRoutes.introScreen:
        return MaterialPageRoute(builder: ((context) => IntroCrousel()));
      case AppRoutes.phoneAuthScreen:
        return MaterialPageRoute(builder: ((context) => PhoneAuthScreen()));
      case AppRoutes.otpScreen:
        return MaterialPageRoute(
            builder: ((context) => OTPScreen(args: args as Map)));
      case AppRoutes.userProfile:
        return MaterialPageRoute(
            builder: ((context) => ConnectProfileScreen(args: args as Map)));
      case AppRoutes.userPostScreen:
        return MaterialPageRoute(
            builder: ((context) => PostScreen(args: args as Map)));
      case AppRoutes.viewAllConsultant:
        return MaterialPageRoute(
            builder: ((context) => ConsultantsScreen(args: args as Map)));
      case AppRoutes.inviteGroupMemberPage:
        return MaterialPageRoute(
            builder: ((context) => InviteMembersUI(args: args as Map)));
      case AppRoutes.createProfile:
        return MaterialPageRoute(builder: ((context) => CreateProfileScreen()));
      case AppRoutes.connectScreen:
        return MaterialPageRoute(builder: ((context) => ConnectScreen2()));
      default:
        return MaterialPageRoute(
            builder: ((context) => Scaffold(
                  appBar:
                      SolhAppBar(title: Text('ERROR'), isLandingScreen: false),
                )));
    }
  }
}

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
            path: "GetHelpMaster",
            name: "GetHelpScreenRouter",
            page: GetHelpMaster,
          ),
          AutoRoute(
            path: "AppointmentsScreen",
            name: "AppointmentsScreenRouter",
            page: AppointmentScreen,
          ),
          AutoRoute(
            path: "DoctorsAppointmentsScreen",
            name: "DoctorsAppointmentsScreenRouter",
            page: DoctorsAppointmentPage,
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
  ],
)
class $AppRouter {}
