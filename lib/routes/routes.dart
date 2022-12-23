import 'package:flutter/material.dart';
import 'package:solh/bottom-navigation/bottom-navigation.dart';
import 'package:solh/ui/screens/chat/chat.dart';
import 'package:solh/ui/screens/connect/connect-screen.dart';
import 'package:solh/ui/screens/connect/connect_screen.dart';
import 'package:solh/ui/screens/get-help/view-all/consultants.dart';
import 'package:solh/ui/screens/groups/group_detail.dart';
import 'package:solh/ui/screens/groups/invite_member_ui.dart';
import 'package:solh/ui/screens/home/chat-anonymously/chat_anon_issues.dart';
import 'package:solh/ui/screens/intro/intro-crousel.dart';
import 'package:solh/ui/screens/mood-meter/mood_analytic_page.dart';
import 'package:solh/ui/screens/my-profile/appointments/appointment_screen.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/edit_profile_option.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/settings/edit_need_support.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/settings/user_type.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/add_avatar.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/add_email.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/anonymous_profile.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/bio.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/emergency_contacts.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/part_of_org.dart';
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
import 'package:solh/ui/screens/profile-setupV2/gender-page/gender_field.dart';
import 'package:solh/ui/screens/profile-setupV2/name-page/name_field.dart';
import 'package:solh/ui/screens/profile-setupV2/need-support-on/need_support_on.dart';
import 'package:solh/ui/screens/profile-setupV2/part-of-an-organisation/part_of_an_organisation.dart';
import 'package:solh/ui/screens/profile-setupV2/role-page/role_selection_screen_screen.dart';
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

  /// Chat anonymously///
  static const String chatAnonIssues = '/chatAnonIssues';
}

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    final Object? args = routeSettings.arguments;

    print('Current Route is ${routeSettings.name}');

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
        return MaterialPageRoute(builder: ((context) => GetStartedScreen()));
      case AppRoutes.loginSignup:
        return MaterialPageRoute(
            builder: ((context) => LoginSignup(args: args as Map)));
      case AppRoutes.otpVerification:
        return MaterialPageRoute(
            builder: ((context) => OtpVerificationScreen(args: args as Map)));

      case AppRoutes.groupDetails:
        return MaterialPageRoute(
            builder: ((context) => GroupDetailsPage(args: args as Map)));
      case AppRoutes.letsCreateYourProfile:
        return MaterialPageRoute(
            builder: ((context) => LetsCreateYourProfile()));
      case AppRoutes.nameField:
        return MaterialPageRoute(builder: ((context) => NameField()));
      case AppRoutes.dobField:
        return MaterialPageRoute(builder: ((context) => DobField()));
      case AppRoutes.genderField:
        return MaterialPageRoute(builder: ((context) => GenderField()));
      case AppRoutes.roleField:
        return MaterialPageRoute(builder: ((context) => RoleSection()));
      case AppRoutes.needSupportOn:
        return MaterialPageRoute(builder: ((context) => NeedSupportOn()));
      case AppRoutes.moodAnalytics:
        return MaterialPageRoute(builder: ((context) => MoodAnalyticPage()));
      case AppRoutes.partOfAnOrgnisation:
        return MaterialPageRoute(
            builder: ((context) => PartOfAnOrganisationPage()));
      case AppRoutes.editProfileOption:
        return MaterialPageRoute(builder: ((context) => EditProfileOptions()));
      case AppRoutes.editProfilePage:
        return MaterialPageRoute(builder: ((context) => EditMyProfileScreen()));
      case AppRoutes.editAnonymousProfile:
        return MaterialPageRoute(
            builder: ((context) => EditAnonymousProfile()));
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
                EmergencyContacts(args: args as Map<String, dynamic>)));
      case AppRoutes.partOfOrg:
        return MaterialPageRoute(builder: ((context) => PartOfOrg()));
      case AppRoutes.needSupportOn:
        return MaterialPageRoute(builder: ((context) => NeedSupportOn()));
      case AppRoutes.editNeedSupportOn:
        return MaterialPageRoute(builder: ((context) => EditNeedSupportOn()));
      case AppRoutes.chatAnonIssues:
        return MaterialPageRoute(builder: ((context) => ChatAnonIssues()));
      case AppRoutes.editNeedSupportOn:
        return MaterialPageRoute(builder: ((context) => EditNeedSupportOn()));

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
