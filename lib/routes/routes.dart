import 'package:flutter/material.dart';
import 'package:solh/bottom-navigation/bottom-navigation.dart';

import 'package:solh/ui/screens/activity-log-and-badge/activity-log/activity_log.dart';
import 'package:solh/ui/screens/activity-log-and-badge/activity_badge_parent.dart';
import 'package:solh/ui/screens/activity-log-and-badge/psychological_points.dart';
import 'package:solh/ui/screens/chat/chat.dart';
import 'package:solh/ui/screens/connect/connect_screen.dart';
import 'package:solh/ui/screens/get-help/allied_consultant_screen.dart';
import 'package:solh/ui/screens/get-help/consultant-allied-parent/consultant_allied_parent.dart';
import 'package:solh/ui/screens/get-help/consultant_profile_page.dart';
import 'package:solh/ui/screens/get-help/inhouse_package_screen.dart';
import 'package:solh/ui/screens/get-help/payment/payment_screen.dart';
import 'package:solh/ui/screens/get-help/view-all/consultants.dart';
import 'package:solh/ui/screens/get-help/view-all/view_all_allied_categories.dart';
import 'package:solh/ui/screens/groups/group_detail.dart';
import 'package:solh/ui/screens/groups/invite_member_ui.dart';
import 'package:solh/ui/screens/groups/manage_groups.dart';
import 'package:solh/ui/screens/home/chat-anonymously/chat_anon_issues.dart';
import 'package:solh/ui/screens/home/chat-anonymously/waiting_screen.dart';
import 'package:solh/ui/screens/intro/intro-crousel.dart';
import 'package:solh/ui/screens/intro/playlist_page.dart';
import 'package:solh/ui/screens/journaling/create-journal.dart';
import 'package:solh/ui/screens/live_stream/live_stream.dart';
import 'package:solh/ui/screens/live_stream/live_stream_waiting.dart';
import 'package:solh/ui/screens/mood-meter/mood_analytic_page.dart';
import 'package:solh/ui/screens/my-profile/appointments/appointment_menu.dart';
import 'package:solh/ui/screens/my-profile/appointments/appointment_screen.dart';
import 'package:solh/ui/screens/my-profile/appointments/profile_transfer.dart';
import 'package:solh/ui/screens/my-profile/appointments/profile_transfer_detail.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/edit_profile_option.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/settings/edit_need_support.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/settings/language_setting_page.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/settings/organization/add_org.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/settings/organization/org_setting.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/settings/user_type.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/add_avatar.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/add_email.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/anonymous_profile.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/bio.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/emergency_contacts.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/part-of-org/part_of_org.dart';
import 'package:solh/ui/screens/my-profile/posts/post.dart';
import 'package:solh/ui/screens/my-profile/profile/edit-profile.dart';
import 'package:solh/ui/screens/my-profile/profile/edit_anonymous_profile.dart';
import 'package:solh/ui/screens/my-profile/settings/account-privacy.dart';
import 'package:solh/ui/screens/phone-auth/phone-auth.dart';
import 'package:solh/ui/screens/phone-authV2/get-started/get_started.dart';
import 'package:solh/ui/screens/phone-authV2/get-started/phonenumber-field/loginSignup/login_signup.dart';
import 'package:solh/ui/screens/phone-authV2/otp-verification/otp_verification_screen.dart';
import 'package:solh/ui/screens/profile-setupV2/Dob-page/dob_page.dart';
import 'package:solh/ui/screens/profile-setupV2/LetsCreateYourprofile/lets_create_your_profile.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/gender-page/gender_field.dart';
import 'package:solh/ui/screens/profile-setupV2/name-page/name_field.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/need-support-on/need_support_on.dart';
import 'package:solh/ui/screens/profile-setupV2/part-of-an-organisation/part_of_an_organisation.dart';
import 'package:solh/ui/screens/profile-setupV2/role-page/role_selection_screen_screen.dart';
import 'package:solh/ui/screens/profile-setup/profile-setup.dart';
import 'package:solh/ui/screens/psychology-test/psychology_test_page.dart';

import '../ui/screens/get-help/view-all/allied_consultants.dart';
import '../ui/screens/my-profile/connections/connections.dart';

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
  static const String connections = '/Connections';

  ////  post related  /////
  static const String commentScreen = '/commentScreen';
  static const String master = '/';
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
  static const String viewAllAlliedExpert = '/viewAllAlliedExpert';
  static const String consultantAlliedParent = '/consultantAlliedParent';
  static const String alliedConsultantScreen = '/alliedConsluntantScreen';
  static const String viewAllAlliedCategories = '/viewAllAlliedCategories';
  static const String inhousePackage = '/inhousePackage';
  static const String paymentscreen = '/paymentscreen';
  static const String consultantProfilePage = '/consultantProfilePage';

  /// Goal related  ////
  static const String myGoalScreen = '/myGoalScreen';
  static const String psychologyTest = '/psychologyTest';

  //// Auth related  ////
  static const String phoneAuthScreen = '/phoneAuthScreen';
  static const String otpScreen = '/otpScreen';

  /// Auth V2 ////

  static const String getStarted = '/getStarted';
  static const String loginSignup = '/login';
  static const String otpVerification = '/otpVerification';

  /// Group related  ///
  ///
  static const String inviteGroupMemberPage = '/inviteGroupMemberPage';

  /// mood related//
  static const String moodAnalytics = '/moodAnalytics';

  /// errors  //////////
  ///
  static const String noInternetPage = '/noInternetPage';
  static const String notFoundPage = '/notFoundPage';

  //// .  Groups /////////
  ///
  static const String groupDetails = '/groupDetails';

  ////   Profile Setup v2 /////////
  static const String letsCreateYourProfile = '/letsCreateYourProfile';
  static const String nameField = '/nameField';
  static const String dobField = '/dobField';
  static const String genderField = '/genderField';
  static const String roleField = '/roleField';
  static const String needSupportOn = '/needSupportOn';
  static const String partOfAnOrgnisation = '/partOfAnOrgnisation';
  static const String manageGroupPage = "/manageGroupPage";

  //my profile v2

  static const String editProfileOption = '/editProfileOption';
  static const String userType = '/userType';
  static const String addAvatar = '/addAvatar';
  static const String bio = '/bio';
  static const String anonymousProfile = '/anonymousProfile';
  static const String addEmail = '/addEmail';
  static const String emergencyContact = '/emergencyContact';
  static const String partOfOrg = '/partOfOrg';
  static const String editNeedSupportOn = '/editNeedSupportOn';
  static const String activityLog = '/activityLog';
  static const String activityBadgeParent = '/activityBadgeParent';
  static const String psychologicalCapital = '/psychologicalCapital';
  static const String videoPlaylist = '/videoPlaylist';
  static const String appointmentMenu = '/appointmentMenu';

  //appointment menu

  static const String profileTransfer = '/profileTransfer';
  static const String profileTransferDetail = '/profileTransferDetail';

  /// Chat anonymously///
  static const String chatAnonIssues = '/chatAnonIssues';
  static const String waitingScreen = '/waitingScreen';

  /// Live Stream
  static const String liveStream = '/liveStream';
  static const String liveStreamWaiting = '/liveStreamWaiting';

  //setting
  static const String languageSettingPage = '/languageSettingPage';
  static const String OrgSetting = '/OrgSetting';
  static const String addOrg = '/addOrg';
}

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    final Object? args = routeSettings.arguments;

    print('Current Route is ${routeSettings.name}');

    switch (routeSettings.name) {
      case AppRoutes.master:
        print('Routing to ${routeSettings.name}');
        return MaterialPageRoute(
            builder: ((context) => MasterScreen()),
            settings: RouteSettings(name: routeSettings.name));

      case AppRoutes.introScreen:
        print('Routing to ${routeSettings.name}');
        return MaterialPageRoute(builder: ((context) => IntroCrousel()));
      case AppRoutes.phoneAuthScreen:
        print('Routing to ${routeSettings.name}');
        return MaterialPageRoute(
            builder: ((context) => PhoneAuthScreen()),
            settings: RouteSettings(name: routeSettings.name));

      case AppRoutes.psychologyTest:
        return MaterialPageRoute(
            builder: ((context) => PsychologyTestPage()),
            settings: RouteSettings(name: routeSettings.name));
      // case AppRoutes.userProfile:
      //   print('Routing to ${routeSettings.name}');
      //   return MaterialPageRoute(
      //       builder: ((context) => ConnectProfileScreen(args: args as Map)));
      case AppRoutes.userPostScreen:
        return MaterialPageRoute(
            builder: ((context) => PostScreen(args: args as Map)),
            settings: RouteSettings(name: routeSettings.name));
      case AppRoutes.viewAllConsultant:
        return MaterialPageRoute(
            builder: ((context) => ConsultantsScreen(args: args as Map)),
            settings: RouteSettings(name: routeSettings.name));
      case AppRoutes.viewAllAlliedExpert:
        return MaterialPageRoute(
            builder: ((context) => AlliedConsultant(args: args as Map)),
            settings: RouteSettings(name: routeSettings.name));
      case AppRoutes.inviteGroupMemberPage:
        return MaterialPageRoute(
            builder: ((context) => InviteMembersUI(args: args as Map)));
      case AppRoutes.createProfile:
        return MaterialPageRoute(
            builder: ((context) => CreateProfileScreen()),
            settings: RouteSettings(name: routeSettings.name));
      case AppRoutes.chatUser:
        return MaterialPageRoute(
            builder: ((context) => ChatScreen(args: args as Map)),
            settings: RouteSettings(name: routeSettings.name));
      case AppRoutes.connectScreen:
        return MaterialPageRoute(
            builder: ((context) => ConnectScreen2(args: args as Map)),
            settings: RouteSettings(name: routeSettings.name));
      case AppRoutes.accountPrivacy:
        return MaterialPageRoute(
            builder: ((context) => AccountPrivacyScreen(args: args as Map)),
            settings: RouteSettings(name: routeSettings.name));
      case AppRoutes.appointmentPage:
        return MaterialPageRoute(
            builder: ((context) => AppointmentScreen(args: args as Map)),
            settings: RouteSettings(name: routeSettings.name));

      case AppRoutes.getStarted:
        return MaterialPageRoute(builder: ((context) => GetStartedScreen()));
      case AppRoutes.loginSignup:
        return MaterialPageRoute(
            builder: ((context) => LoginSignup(args: args as Map)),
            settings: RouteSettings(name: routeSettings.name));
      case AppRoutes.otpVerification:
        return MaterialPageRoute(
            builder: ((context) => OtpVerificationScreen(args: args as Map)),
            settings: RouteSettings(name: routeSettings.name));

      case AppRoutes.groupDetails:
        return MaterialPageRoute(
            builder: ((context) => GroupDetailsPage(args: args as Map)),
            settings: RouteSettings(name: routeSettings.name));
      case AppRoutes.letsCreateYourProfile:
        return MaterialPageRoute(
            builder: ((context) => LetsCreateYourProfile()));
      case AppRoutes.nameField:
        return MaterialPageRoute(builder: ((context) => NameField()));
      case AppRoutes.dobField:
        return MaterialPageRoute(builder: ((context) => DobField()));
      case AppRoutes.genderField:
        return MaterialPageRoute(
            builder: ((context) =>
                GenderField(args: args as Map<String, dynamic>)));
      case AppRoutes.roleField:
        return MaterialPageRoute(builder: ((context) => RoleSection()));
      case AppRoutes.needSupportOn:
        return MaterialPageRoute(
            builder: ((context) =>
                NeedSupportOn(args: args as Map<String, dynamic>)));
      case AppRoutes.moodAnalytics:
        return MaterialPageRoute(builder: ((context) => MoodAnalyticPage()));
      case AppRoutes.partOfAnOrgnisation:
        return MaterialPageRoute(
            builder: ((context) => PartOfAnOrganisationPage()));
      case AppRoutes.editProfileOption:
        return MaterialPageRoute(builder: ((context) => EditProfileOptions()));
      case AppRoutes.editProfilePage:
        return MaterialPageRoute(
            builder: ((context) => EditMyProfileScreen()),
            settings: RouteSettings(name: routeSettings.name));
      case AppRoutes.editAnonymousProfile:
        return MaterialPageRoute(
            builder: ((context) => EditAnonymousProfile()),
            settings: RouteSettings(name: routeSettings.name));
      case AppRoutes.userType:
        return MaterialPageRoute(builder: ((context) => UserType()));
      case AppRoutes.addAvatar:
        return MaterialPageRoute(
            builder: ((context) =>
                AddAvatar(args: args as Map<String, dynamic>)));
      case AppRoutes.bio:
        return MaterialPageRoute(
            builder: ((context) => Bio(args: args as Map<String, dynamic>)));
      case AppRoutes.anonymousProfile:
        return MaterialPageRoute(
            builder: ((context) =>
                AnonymousProfile(args: args as Map<String, dynamic>)));
      case AppRoutes.addEmail:
        return MaterialPageRoute(
            builder: ((context) =>
                AddEmail(args: args as Map<String, dynamic>)));
      case AppRoutes.emergencyContact:
        return MaterialPageRoute(
            builder: ((context) =>
                EmergencyContacts(args: args as Map<String, dynamic>)),
            settings: RouteSettings(name: routeSettings.name));
      case AppRoutes.partOfOrg:
        return MaterialPageRoute(
            builder: ((context) =>
                PartOfOrg(args: args as Map<String, dynamic>)));
      case AppRoutes.needSupportOn:
        return MaterialPageRoute(
            builder: ((context) =>
                NeedSupportOn(args: args as Map<String, dynamic>)));
      case AppRoutes.editNeedSupportOn:
        return MaterialPageRoute(builder: ((context) => EditNeedSupportOn()));
      case AppRoutes.chatAnonIssues:
        return MaterialPageRoute(builder: ((context) => ChatAnonIssues()));
      case AppRoutes.editNeedSupportOn:
        return MaterialPageRoute(builder: ((context) => EditNeedSupportOn()));
      case AppRoutes.activityLog:
        return MaterialPageRoute(builder: ((context) => ActivityLogScreen()));
      case AppRoutes.activityBadgeParent:
        return MaterialPageRoute(builder: ((context) => ActivityBadgeParent()));
      case AppRoutes.connections:
        return MaterialPageRoute(builder: ((context) => Connections()));
      case AppRoutes.createJournal:
        return MaterialPageRoute(builder: ((context) => CreatePostScreen()));
      case AppRoutes.psychologicalCapital:
        return MaterialPageRoute(
            builder: ((context) => PsychologicalCapital()));
      case AppRoutes.alliedConsultantScreen:
        return MaterialPageRoute(
            builder: ((context) =>
                AlliedConsultantScreen(args: args as Map<String, dynamic>)));
      case AppRoutes.consultantAlliedParent:
        return MaterialPageRoute(
            builder: ((context) =>
                ConsultantAlliedParent(args: args as Map<String, dynamic>)));
      case AppRoutes.waitingScreen:
        return MaterialPageRoute(builder: ((context) => WaitingScreen()));
      case AppRoutes.viewAllAlliedCategories:
        return MaterialPageRoute(
            builder: ((context) =>
                ViewAlAlliedCategories(args: args as Map<String, dynamic>)));
      case AppRoutes.languageSettingPage:
        return MaterialPageRoute(builder: ((context) => LanguageSettingPage()));
      case AppRoutes.inhousePackage:
        return MaterialPageRoute(
            builder: ((context) =>
                InhousePackageScreen(args: args as Map<String, dynamic>)));
      case AppRoutes.paymentscreen:
        return MaterialPageRoute(
            builder: ((context) =>
                PaymentScreen(args: args as Map<String, dynamic>)));
      case AppRoutes.videoPlaylist:
        return MaterialPageRoute(builder: ((context) => VideoPlaylist()));

      case AppRoutes.manageGroupPage:
        return MaterialPageRoute(builder: ((context) => ManageGroupPage()));
      case AppRoutes.appointmentMenu:
        return MaterialPageRoute(builder: ((context) => AppointmentMenu()));
      case AppRoutes.profileTransfer:
        return MaterialPageRoute(builder: ((context) => ProfileTransfer()));
      case AppRoutes.addOrg:
        return MaterialPageRoute(builder: ((context) => AddOrg()));
      case AppRoutes.profileTransferDetail:
        return MaterialPageRoute(
            builder: ((context) => ProfileTransferDetail()));
      case AppRoutes.OrgSetting:
        return MaterialPageRoute(builder: ((context) => OrgSetting()));
      case AppRoutes.liveStream:
        return MaterialPageRoute(
            builder: ((context) =>
                LiveStream(args: args as Map<String, dynamic>)));
      case AppRoutes.liveStreamWaiting:
        return MaterialPageRoute(builder: ((context) => LiveStreamWaiting()));
      case AppRoutes.consultantProfilePage:
        return MaterialPageRoute(
            builder: ((context) => ConsultantProfilePage()));
      // case "/":
      //   return MaterialPageRoute(builder: ((context) => MasterScreen()));
      default:
        break;
    }
  }
}
