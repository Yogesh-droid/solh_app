import 'package:flutter/material.dart';
import 'package:solh/bottom-navigation/bottom-navigation.dart';
import 'package:solh/ui/screens/chat/chat.dart';
import 'package:solh/ui/screens/connect/connect-screen.dart';
import 'package:solh/ui/screens/connect/connect_screen.dart';
import 'package:solh/ui/screens/get-help/view-all/consultants.dart';
import 'package:solh/ui/screens/groups/group_detail.dart';
import 'package:solh/ui/screens/groups/invite_member_ui.dart';
import 'package:solh/ui/screens/intro/intro-crousel.dart';
import 'package:solh/ui/screens/my-profile/appointments/appointment_screen.dart';
import 'package:solh/ui/screens/my-profile/posts/post.dart';
import 'package:solh/ui/screens/my-profile/settings/account-privacy.dart';
import 'package:solh/ui/screens/phone-auth/otp-screen.dart';
import 'package:solh/ui/screens/phone-auth/phone-auth.dart';
import 'package:solh/ui/screens/phone-authV2/get-started/get_started.dart';
import 'package:solh/ui/screens/profile-setup/profile-setup.dart';
import 'package:solh/ui/screens/psychology-test/psychology_test_page.dart';

class AppRoutes {
  ////  user profile related  /////
  ///
  static const String userProfile = '/userProfile';
  static const String connectScreen = '/connectScreen';
  static const String myProfile = '/myProfile';
  static const String editProfilePage = '/editProfilePage';
  static const String editAnonymousProfile = '/editAnonProfilePage';
  static const String createProfile = '/createProfile';
  static const String accountPrivacy = '/accountPrivacy';

  ////  post related  /////
  static const String commentScreen = '/commentScreen';
  static const String master = '/master';
  static const String introScreen = '/intro';
  static const String homeScreen = '/home';
  static const String journaling = '/journaling';
  static const String createJournal = '/createJournal';
  static const String userPostScreen = '/userPostScreen';

  /// chat and video call//
  static const String chatUser = '/chatUser';
  static const String chatProvider = '/chatProvider';

  ////    Get help related  ////////
  ///
  static const String getHelpPage = '/getHelpPage';
  static const String appointmentPage = '/appointmentPage';
  static const String viewAllConsultant = '/viewAllConsultant';

  /// Goal related  ////
  static const String myGoalScreen = '/myGoalScreen';
  static const String psychologyTest = '/psychologyTest';

  //// Auth related  ////
  static const String phoneAuthScreen = '/phoneAuthScreen';
  static const String otpScreen = '/otpScreen';

  /// Auth V2 ////

  static const String getStarted = '/getStarted';

  /// Group related  ///
  ///
  static const String inviteGroupMemberPage = '/inviteGroupMemberPage';

  /// errors  //////////
  ///
  static const String noInternetPage = '/noInternetPage';
  static const String notFoundPage = '/notFoundPage';

  //// .  Groups /////////
  ///
  static const String groupDetails = '/groupDetails';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final Object? args = routeSettings.arguments;

    switch (routeSettings.name) {
      case AppRoutes.master:
        print('Routing to ${routeSettings.name}');
        return MaterialPageRoute(builder: ((context) => MasterScreen()));
      case AppRoutes.introScreen:
        print('Routing to ${routeSettings.name}');
        return MaterialPageRoute(builder: ((context) => IntroCrousel()));
      case AppRoutes.phoneAuthScreen:
        print('Routing to ${routeSettings.name}');
        return MaterialPageRoute(builder: ((context) => PhoneAuthScreen()));
      case AppRoutes.otpScreen:
        return MaterialPageRoute(
            builder: ((context) => OTPScreen(args: args as Map)));
      case AppRoutes.psychologyTest:
        return MaterialPageRoute(builder: ((context) => PsychologyTestPage()));
      case AppRoutes.userProfile:
        print('Routing to ${routeSettings.name}');
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
      case AppRoutes.chatUser:
        return MaterialPageRoute(
            builder: ((context) => ChatScreen(args: args as Map)));
      case AppRoutes.connectScreen:
        return MaterialPageRoute(
            builder: ((context) => ConnectScreen2(args: args as Map)));
      case AppRoutes.accountPrivacy:
        return MaterialPageRoute(
            builder: ((context) => AccountPrivacyScreen(args: args as Map)));
      case AppRoutes.appointmentPage:
        return MaterialPageRoute(
            builder: ((context) => AppointmentScreen(args: args as Map)));

      case AppRoutes.getStarted:
        return MaterialPageRoute(
            builder: ((context) => GetStartedScreen(args: args as Map)));

      case AppRoutes.groupDetails:
        return MaterialPageRoute(
            builder: ((context) => GroupDetailsPage(args: args as Map)));

      default:
        return MaterialPageRoute(
            builder: ((context) => Scaffold(
                  appBar: AppBar(
                    title: Text('ERROR'),
                  ),
                )));
    }
  }
}
