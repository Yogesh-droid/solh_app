import 'package:flutter/material.dart';
import 'package:solh/bottom-navigation/bottom-navigation.dart';
import 'package:solh/features/lms/display/course_cart/ui/screens/course_checkout_page.dart';
import 'package:solh/features/lms/display/course_detail/ui/screens/course_detail_screen.dart';
import 'package:solh/features/lms/display/course_listing/ui/screens/course_list_screen.dart';

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
import 'package:solh/ui/screens/my-goals/my-goals-screen.dart';
import 'package:solh/ui/screens/my-profile/appointments/appointment_menu.dart';
import 'package:solh/ui/screens/my-profile/appointments/appointment_screen.dart';
import 'package:solh/ui/screens/my-profile/appointments/profile_transfer.dart';
import 'package:solh/ui/screens/my-profile/appointments/profile_transfer_detail.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/edit_profile_option.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/settings/change_mpin_screen.dart';
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
import 'package:solh/ui/screens/phone-authV2/create_mpin/create_mpin_screen.dart';
import 'package:solh/ui/screens/phone-authV2/enter_mpin/enter_mpin.dart';
import 'package:solh/ui/screens/phone-authV2/forgot_mpin/forgot_mpin_screen.dart';
import 'package:solh/ui/screens/phone-authV2/get-started/get_started.dart';
import 'package:solh/ui/screens/phone-authV2/get-started/phonenumber-field/loginSignup/login_signup.dart';
import 'package:solh/ui/screens/phone-authV2/otp-verification/otp_verification_screen.dart';
import 'package:solh/ui/screens/products/features/cart/ui/views/screen/add_address_page.dart';
import 'package:solh/ui/screens/products/features/cart/ui/views/screen/checkout_screen.dart';
import 'package:solh/ui/screens/products/features/home/ui/views/screens/product_home.dart';
import 'package:solh/ui/screens/products/features/order_summary/ui/view/screen/cancel_order_page.dart';
import 'package:solh/ui/screens/products/features/order_summary/ui/view/screen/order_detail_page.dart';
import 'package:solh/ui/screens/products/features/order_summary/ui/view/screen/order_list.dart';
import 'package:solh/ui/screens/products/features/product_detail/ui/views/screens/product_detail_screen.dart';
import 'package:solh/ui/screens/products/features/product_payment/ui/screens/product_payment_page.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/screens/product_listing.dart';
import 'package:solh/ui/screens/products/features/wishlist/ui/view/screen/product_wishlist_screen.dart';
import 'package:solh/ui/screens/profile-setupV2/Dob-page/dob_page.dart';
import 'package:solh/ui/screens/profile-setupV2/LetsCreateYourprofile/lets_create_your_profile.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/gender-page/gender_field.dart';
import 'package:solh/ui/screens/profile-setupV2/email/email_onborading.dart';
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
  static const String enterMpinScreen = '/enterMpinScreen';
  static const String createMpinScreen = '/createMpinScreen';
  static const String forgotMpinScreen = '/forgotMpinScreen';
  static const String courseListScreen = '/courseListScree';
  static const String courseDetailScreen = '/courseDetailScreen';
  static const String courseCheckoutScreen = '/courseCheckoutScreen';

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
  static const String addEmailOnboarding = "/addEmailOnboarding";

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
  static const String changeMpinScreen = '/changeMpinScreen';

  //products
  static const String productsHome = '/productsHome';
  static const String productDetailScreen = '/productDetailScreen';
  static const String checkoutScreen = "/checkoutScreen";
  static const String productList = "/productList";
  static const String productWishlistScreen = "/productWishlistScreen";

  static const String orderListScreen = "/orderListScreen";
  static const String productPaymentPage = "/productPaymentPage";
  static const String addAddressPage = '/addAddressPage';
  static const String orderdetails = '/orderDetails';
  static const String cancelOrderPage = '/cancelOrderPage';
  static const String myGoalsScreen = '/myGoalScreen';
}

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    final Object? args = routeSettings.arguments;

    debugPrint('Current Route is ${routeSettings.name}');

    switch (routeSettings.name) {
      case AppRoutes.master:
        debugPrint('Routing to ${routeSettings.name}');
        return MaterialPageRoute(
            builder: ((context) => MasterScreen()),
            settings: const RouteSettings(name: AppRoutes.master));

      case AppRoutes.introScreen:
        debugPrint('Routing to ${routeSettings.name}');
        return MaterialPageRoute(
            builder: ((context) => const IntroCrousel()),
            settings: const RouteSettings(name: AppRoutes.introScreen));
      case AppRoutes.phoneAuthScreen:
        debugPrint('Routing to ${routeSettings.name}');
        return MaterialPageRoute(
            builder: ((context) => const PhoneAuthScreen()),
            settings: const RouteSettings(name: AppRoutes.phoneAuthScreen));

      case AppRoutes.psychologyTest:
        return MaterialPageRoute(
            builder: ((context) => const PsychologyTestPage()),
            settings: const RouteSettings(name: AppRoutes.psychologyTest));

      case AppRoutes.userPostScreen:
        return MaterialPageRoute(
            builder: ((context) => PostScreen(args: args as Map)),
            settings: const RouteSettings(name: AppRoutes.userPostScreen));

      // Add Address
      case AppRoutes.addAddressPage:
        return MaterialPageRoute(
            builder: ((context) => AddAddressPage(args: args as Map)),
            settings: const RouteSettings(name: AppRoutes.addAddressPage));

      case AppRoutes.viewAllConsultant:
        return MaterialPageRoute(
            builder: ((context) => ConsultantsScreen(args: args as Map)),
            settings: const RouteSettings(name: AppRoutes.viewAllConsultant));
      case AppRoutes.viewAllAlliedExpert:
        return MaterialPageRoute(
            builder: ((context) => AlliedConsultant(args: args as Map)),
            settings: const RouteSettings(name: AppRoutes.viewAllAlliedExpert));
      case AppRoutes.inviteGroupMemberPage:
        return MaterialPageRoute(
            builder: ((context) => InviteMembersUI(args: args as Map)),
            settings:
                const RouteSettings(name: AppRoutes.inviteGroupMemberPage));
      case AppRoutes.createProfile:
        return MaterialPageRoute(
            builder: ((context) => const CreateProfileScreen()),
            settings: const RouteSettings(name: AppRoutes.createProfile));
      case AppRoutes.chatUser:
        return MaterialPageRoute(
            builder: ((context) => ChatScreen(args: args as Map)),
            settings: const RouteSettings(name: AppRoutes.chatUser));
      case AppRoutes.connectScreen:
        return MaterialPageRoute(
            builder: ((context) => ConnectScreen2(args: args as Map)),
            settings: const RouteSettings(name: AppRoutes.connectScreen));
      case AppRoutes.accountPrivacy:
        return MaterialPageRoute(
            builder: ((context) => AccountPrivacyScreen(args: args as Map)),
            settings: const RouteSettings(name: AppRoutes.accountPrivacy));
      case AppRoutes.appointmentPage:
        return MaterialPageRoute(
            builder: ((context) => AppointmentScreen(args: args as Map)),
            settings: const RouteSettings(name: AppRoutes.appointmentPage));

      case AppRoutes.getStarted:
        debugPrint('Routing to ${routeSettings.name}');
        return MaterialPageRoute(
            builder: ((context) => GetStartedScreen()),
            settings: const RouteSettings(name: AppRoutes.getStarted));
      case AppRoutes.loginSignup:
        return MaterialPageRoute(
            builder: ((context) => LoginSignup(args: args as Map)),
            settings: const RouteSettings(name: AppRoutes.loginSignup));
      case AppRoutes.otpVerification:
        return MaterialPageRoute(
            builder: ((context) => OtpVerificationScreen(args: args as Map)),
            settings: const RouteSettings(name: AppRoutes.otpVerification));

      case AppRoutes.groupDetails:
        return MaterialPageRoute(
            builder: ((context) => GroupDetailsPage(args: args as Map)),
            settings: const RouteSettings(name: AppRoutes.groupDetails));
      case AppRoutes.letsCreateYourProfile:
        return MaterialPageRoute(
            builder: ((context) => LetsCreateYourProfile()),
            settings:
                const RouteSettings(name: AppRoutes.letsCreateYourProfile));
      case AppRoutes.nameField:
        return MaterialPageRoute(
            builder: ((context) => NameField()),
            settings: const RouteSettings(name: AppRoutes.nameField));
      case AppRoutes.dobField:
        return MaterialPageRoute(
            builder: ((context) => DobField()),
            settings: const RouteSettings(name: AppRoutes.dobField));
      case AppRoutes.genderField:
        return MaterialPageRoute(
            builder: ((context) =>
                GenderField(args: args as Map<String, dynamic>)),
            settings: const RouteSettings(name: AppRoutes.genderField));
      case AppRoutes.roleField:
        return MaterialPageRoute(
            builder: ((context) => RoleSection()),
            settings: const RouteSettings(name: AppRoutes.roleField));
      case AppRoutes.needSupportOn:
        return MaterialPageRoute(
            builder: ((context) =>
                NeedSupportOn(args: args as Map<String, dynamic>)),
            settings: const RouteSettings(name: AppRoutes.needSupportOn));
      case AppRoutes.moodAnalytics:
        return MaterialPageRoute(
            builder: ((context) => MoodAnalyticPage()),
            settings: const RouteSettings(name: AppRoutes.moodAnalytics));
      case AppRoutes.partOfAnOrgnisation:
        return MaterialPageRoute(
            builder: ((context) => PartOfAnOrganisationPage()),
            settings: const RouteSettings(name: AppRoutes.partOfAnOrgnisation));
      case AppRoutes.editProfileOption:
        return MaterialPageRoute(
            builder: ((context) => EditProfileOptions()),
            settings: const RouteSettings(name: AppRoutes.editProfileOption));
      case AppRoutes.editProfilePage:
        return MaterialPageRoute(
            builder: ((context) => const EditMyProfileScreen()),
            settings: const RouteSettings(name: AppRoutes.editProfilePage));
      case AppRoutes.editAnonymousProfile:
        return MaterialPageRoute(
            builder: ((context) => const EditAnonymousProfile()),
            settings:
                const RouteSettings(name: AppRoutes.editAnonymousProfile));
      case AppRoutes.userType:
        return MaterialPageRoute(
            builder: ((context) => UserType()),
            settings: const RouteSettings(name: AppRoutes.userType));
      case AppRoutes.addAvatar:
        return MaterialPageRoute(
            builder: ((context) =>
                AddAvatar(args: args as Map<String, dynamic>)),
            settings: const RouteSettings(name: AppRoutes.addAvatar));
      case AppRoutes.bio:
        return MaterialPageRoute(
            builder: ((context) => Bio(args: args as Map<String, dynamic>)),
            settings: const RouteSettings(name: AppRoutes.bio));
      case AppRoutes.anonymousProfile:
        return MaterialPageRoute(
            builder: ((context) =>
                AnonymousProfile(args: args as Map<String, dynamic>)),
            settings: const RouteSettings(name: AppRoutes.anonymousProfile));
      case AppRoutes.addEmail:
        return MaterialPageRoute(
            builder: ((context) =>
                AddEmail(args: args as Map<String, dynamic>)),
            settings: const RouteSettings(name: AppRoutes.addEmail));
      case AppRoutes.emergencyContact:
        return MaterialPageRoute(
            builder: ((context) =>
                EmergencyContacts(args: args as Map<String, dynamic>)),
            settings: const RouteSettings(name: AppRoutes.emergencyContact));
      case AppRoutes.partOfOrg:
        return MaterialPageRoute(
            builder: ((context) =>
                PartOfOrg(args: args as Map<String, dynamic>)),
            settings: const RouteSettings(name: AppRoutes.partOfOrg));
      case AppRoutes.editNeedSupportOn:
        return MaterialPageRoute(
            builder: ((context) => EditNeedSupportOn()),
            settings: const RouteSettings(name: AppRoutes.editNeedSupportOn));
      case AppRoutes.chatAnonIssues:
        return MaterialPageRoute(
            builder: ((context) => ChatAnonIssues()),
            settings: const RouteSettings(name: AppRoutes.chatAnonIssues));

      case AppRoutes.activityLog:
        return MaterialPageRoute(
            builder: ((context) => const ActivityLogScreen()),
            settings: const RouteSettings(name: AppRoutes.activityLog));
      case AppRoutes.activityBadgeParent:
        return MaterialPageRoute(
            builder: ((context) => const ActivityBadgeParent()),
            settings: const RouteSettings(name: AppRoutes.activityBadgeParent));
      case AppRoutes.connections:
        return MaterialPageRoute(
            builder: ((context) => Connections()),
            settings: const RouteSettings(name: AppRoutes.connections));
      case AppRoutes.createJournal:
        return MaterialPageRoute(
            builder: ((context) => CreatePostScreen()),
            settings: const RouteSettings(name: AppRoutes.createJournal));
      case AppRoutes.psychologicalCapital:
        return MaterialPageRoute(
            builder: ((context) => const PsychologicalCapital()),
            settings:
                const RouteSettings(name: AppRoutes.psychologicalCapital));
      case AppRoutes.alliedConsultantScreen:
        return MaterialPageRoute(
            builder: ((context) =>
                AlliedConsultantScreen(args: args as Map<String, dynamic>)),
            settings:
                const RouteSettings(name: AppRoutes.alliedConsultantScreen));
      case AppRoutes.consultantAlliedParent:
        return MaterialPageRoute(
            builder: ((context) =>
                ConsultantAlliedParent(args: args as Map<String, dynamic>)),
            settings:
                const RouteSettings(name: AppRoutes.consultantAlliedParent));
      case AppRoutes.waitingScreen:
        return MaterialPageRoute(
            builder: ((context) => const WaitingScreen()),
            settings: const RouteSettings(name: AppRoutes.waitingScreen));
      case AppRoutes.viewAllAlliedCategories:
        return MaterialPageRoute(
            builder: ((context) =>
                ViewAlAlliedCategories(args: args as Map<String, dynamic>)),
            settings:
                const RouteSettings(name: AppRoutes.viewAllAlliedCategories));
      case AppRoutes.languageSettingPage:
        return MaterialPageRoute(
            builder: ((context) => const LanguageSettingPage()),
            settings: const RouteSettings(name: AppRoutes.languageSettingPage));
      case AppRoutes.inhousePackage:
        return MaterialPageRoute(
            builder: ((context) =>
                InhousePackageScreen(args: args as Map<String, dynamic>)),
            settings: const RouteSettings(name: AppRoutes.inhousePackage));
      case AppRoutes.paymentscreen:
        return MaterialPageRoute(
            builder: ((context) =>
                PaymentScreen(args: args as Map<String, dynamic>)),
            settings: const RouteSettings(name: AppRoutes.paymentscreen));
      case AppRoutes.videoPlaylist:
        return MaterialPageRoute(
            builder: ((context) => VideoPlaylist()),
            settings: const RouteSettings(name: AppRoutes.videoPlaylist));

      case AppRoutes.manageGroupPage:
        return MaterialPageRoute(
            builder: ((context) => ManageGroupPage()),
            settings: const RouteSettings(name: AppRoutes.manageGroupPage));
      case AppRoutes.appointmentMenu:
        return MaterialPageRoute(
            builder: ((context) => const AppointmentMenu()),
            settings: const RouteSettings(name: AppRoutes.appointmentMenu));
      case AppRoutes.profileTransfer:
        return MaterialPageRoute(
            builder: ((context) => ProfileTransfer()),
            settings: const RouteSettings(name: AppRoutes.profileTransfer));
      case AppRoutes.addOrg:
        return MaterialPageRoute(
            builder: ((context) => AddOrg()),
            settings: const RouteSettings(name: AppRoutes.addOrg));
      case AppRoutes.profileTransferDetail:
        return MaterialPageRoute(
            builder: ((context) => ProfileTransferDetail()),
            settings:
                const RouteSettings(name: AppRoutes.profileTransferDetail));
      case AppRoutes.OrgSetting:
        return MaterialPageRoute(
            builder: ((context) => OrgSetting()),
            settings: const RouteSettings(name: AppRoutes.OrgSetting));
      case AppRoutes.liveStream:
        return MaterialPageRoute(
            builder: ((context) =>
                LiveStream(args: args as Map<String, dynamic>)),
            settings: const RouteSettings(name: AppRoutes.liveStream));
      case AppRoutes.liveStreamWaiting:
        return MaterialPageRoute(
            builder: ((context) => const LiveStreamWaiting()),
            settings: const RouteSettings(name: AppRoutes.liveStreamWaiting));
      case AppRoutes.consultantProfilePage:
        return MaterialPageRoute(
            builder: ((context) => ConsultantProfilePage()),
            settings:
                const RouteSettings(name: AppRoutes.consultantProfilePage));
      case AppRoutes.addEmailOnboarding:
        return MaterialPageRoute(
            builder: ((context) => AddEmailOnboarding()),
            settings: const RouteSettings(name: AppRoutes.addEmailOnboarding));
      case AppRoutes.productsHome:
        return MaterialPageRoute(
            builder: ((context) => const ProductsHome()),
            settings: const RouteSettings(name: AppRoutes.productsHome));
      case AppRoutes.orderListScreen:
        return MaterialPageRoute(
            builder: ((context) => const OrderListScreen()),
            settings: const RouteSettings(name: AppRoutes.orderListScreen));
      case AppRoutes.productWishlistScreen:
        return MaterialPageRoute(
            builder: ((context) => const ProductWishlistScreen()),
            settings:
                const RouteSettings(name: AppRoutes.productWishlistScreen));
      case AppRoutes.productDetailScreen:
        return MaterialPageRoute(
            builder: ((context) =>
                ProductDetailScreen(args: args as Map<String, dynamic>)),
            settings: const RouteSettings(name: AppRoutes.productDetailScreen));
      case AppRoutes.checkoutScreen:
        return MaterialPageRoute(
            builder: ((context) => const CheckoutScreen()),
            settings: const RouteSettings(name: AppRoutes.checkoutScreen));
      case AppRoutes.productList:
        return MaterialPageRoute(
            builder: ((context) => ProductLisingPage(
                  args: args as Map<String, dynamic>,
                )),
            settings: const RouteSettings(name: AppRoutes.productList));

      case AppRoutes.productPaymentPage:
        return MaterialPageRoute(
            builder: ((context) => ProductPaymentPage(
                  args: args as Map<String, dynamic>,
                )),
            settings: const RouteSettings(name: AppRoutes.productPaymentPage));

      case AppRoutes.orderdetails:
        return MaterialPageRoute(
            builder: ((context) => OrderDetailPage(
                  args: args as Map<String, dynamic>,
                )),
            settings: const RouteSettings(name: AppRoutes.orderdetails));

      case AppRoutes.cancelOrderPage:
        return MaterialPageRoute(
            builder: ((context) => CancelOrderPage()),
            settings: RouteSettings(
                name: AppRoutes.cancelOrderPage, arguments: args));

      case AppRoutes.myGoalScreen:
        return MaterialPageRoute(
            builder: ((context) => const MyGoalsScreen()),
            settings: RouteSettings(
                name: AppRoutes.cancelOrderPage, arguments: args));
      case AppRoutes.enterMpinScreen:
        return MaterialPageRoute(
            builder: ((context) => EnterMpinScreen(
                  args: args as Map<String, dynamic>,
                )),
            settings: const RouteSettings(name: AppRoutes.cancelOrderPage));
      case AppRoutes.createMpinScreen:
        return MaterialPageRoute(
            builder: ((context) => CreateMpinScren()),
            settings: const RouteSettings(name: AppRoutes.createMpinScreen));
      case AppRoutes.changeMpinScreen:
        return MaterialPageRoute(
            builder: ((context) => ChangeMpinScreen()),
            settings: const RouteSettings(name: AppRoutes.changeMpinScreen));
      case AppRoutes.forgotMpinScreen:
        return MaterialPageRoute(
            builder: ((context) => const ForgotMpinScreen()),
            settings: const RouteSettings(name: AppRoutes.forgotMpinScreen));

      case AppRoutes.courseListScreen:
        return MaterialPageRoute(
            builder: ((context) =>
                CourseListScreen(args: args as Map<String, dynamic>)),
            settings: const RouteSettings(name: AppRoutes.courseListScreen));

      case AppRoutes.courseDetailScreen:
        return MaterialPageRoute(
            builder: ((context) =>
                CourseDetailScreen(args: args as Map<String, dynamic>)),
            settings: const RouteSettings(name: AppRoutes.courseDetailScreen));

      case AppRoutes.courseCheckoutScreen:
        return MaterialPageRoute(
            builder: ((context) => const CourseCheckoutPage()),
            settings:
                const RouteSettings(name: AppRoutes.courseCheckoutScreen));

      // case "/":
      //   return MaterialPageRoute(builder: ((context) => MasterScreen()));
      default:
        break;
    }
    return null;
  }
}
