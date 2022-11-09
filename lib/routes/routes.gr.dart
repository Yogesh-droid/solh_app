// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'dart:io' as _i25;

import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i24;

import '../bottom-navigation/bottom-navigation.dart' as _i1;
import '../model/journals/journals_response_model.dart' as _i26;
import '../ui/screens/comment/comment-screen.dart' as _i18;
import '../ui/screens/connect/connect-screen.dart' as _i17;
import '../ui/screens/doctor/appointment_page.dart' as _i13;
import '../ui/screens/get-help/get-help.dart' as _i11;
import '../ui/screens/get-help/view-all/consultants.dart' as _i6;
import '../ui/screens/home/homescreen.dart' as _i9;
import '../ui/screens/intro/intro-crousel.dart' as _i2;
import '../ui/screens/journaling/create-journal.dart' as _i16;
import '../ui/screens/journaling/journaling.dart' as _i15;
import '../ui/screens/my-goals/my-goals-screen.dart' as _i14;
import '../ui/screens/my-profile/appointments/appointment_screen.dart' as _i12;
import '../ui/screens/my-profile/my-profile-screen.dart' as _i19;
import '../ui/screens/my-profile/posts/post.dart' as _i20;
import '../ui/screens/my-profile/profile/edit-profile.dart' as _i23;
import '../ui/screens/my-profile/settings/account-privacy.dart' as _i22;
import '../ui/screens/my-profile/settings/settings.dart' as _i21;
import '../ui/screens/phone-auth/otp-screen.dart' as _i5;
import '../ui/screens/phone-auth/phone-auth.dart' as _i4;
import '../ui/screens/profile-setup/profile-setup.dart' as _i3;
import '../ui/screens/sos/setup-sos.dart' as _i8;
import '../ui/screens/sos/sos.dart' as _i7;

class AppRouter extends _i10.RootStackRouter {
  AppRouter([_i24.GlobalKey<_i24.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    MasterScreenRouter.name: (routeData) {
      final args = routeData.argsAs<MasterScreenRouterArgs>(
          orElse: () => const MasterScreenRouterArgs());
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.MasterScreen());
    },
    IntroCarouselScreenRouter.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.IntroCrousel());
    },
    CreateProfileScreenRouter.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.CreateProfileScreen());
    },
    PhoneAuthScreenRouter.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.PhoneAuthScreen());
    },
    OTPScreenRouter.name: (routeData) {
      final args = routeData.argsAs<OTPScreenRouterArgs>();
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.OTPScreen(
            key: args.key,
            args: {},
            // phoneNo: args.phoneNo,
            // verificationId: args.verificationId
          ));
    },
    // ConsultantsScreenRouter.name: (routeData) {
    //   final args = routeData.argsAs<ConsultantsScreenRouterArgs>();
    //   return _i10.MaterialPageX<dynamic>(
    //       routeData: routeData,
    //       child: _i6.ConsultantsScreen(
    //           key: args.key,
    //           page: args.page,
    //           count: args.count,
    //           slug: args.slug,
    //           type: args.type));
    // },
    SOSScreenRouter.name: (routeData) {
      final args = routeData.argsAs<SOSScreenRouterArgs>(
          orElse: () => const SOSScreenRouterArgs());
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: _i7.SOSDialog(key: args.key));
    },
    SetupSOSScreenRouter.name: (routeData) {
      final args = routeData.argsAs<SetupSOSScreenRouterArgs>(
          orElse: () => const SetupSOSScreenRouterArgs());
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: _i8.SetupSOSScreen(key: args.key));
    },
    HomeScreenRouter.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.HomeScreen());
    },
    JournalingScreenRouter.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.EmptyRouterPage());
    },
    GetHelpScreenRouter.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.GetHelpMaster());
    },
    AppointmentsScreenRouter.name: (routeData) {
      final args = routeData.argsAs<AppointmentsScreenRouterArgs>(
          orElse: () => const AppointmentsScreenRouterArgs());
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: _i12.AppointmentScreen(key: args.key));
    },
    DoctorsAppointmentsScreenRouter.name: (routeData) {
      final args = routeData.argsAs<DoctorsAppointmentsScreenRouterArgs>(
          orElse: () => const DoctorsAppointmentsScreenRouterArgs());
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i13.DoctorsAppointmentPage(key: args.key));
    },
    MyGoalsScreenRouter.name: (routeData) {
      final args = routeData.argsAs<MyGoalsScreenRouterArgs>(
          orElse: () => const MyGoalsScreenRouterArgs());
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: _i14.MyGoalsScreen(key: args.key));
    },
    MyProfileScreenRouter.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.EmptyRouterPage());
    },
    JournalingScreen.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i15.JournalingScreen());
    },
    CreatePostScreenRouter.name: (routeData) {
      final args = routeData.argsAs<CreatePostScreenRouterArgs>(
          orElse: () => const CreatePostScreenRouterArgs());
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i16.CreatePostScreen(
              key: args.key,
              croppedFile: args.croppedFile,
              map: args.map,
              isPostedFromDiaryDetails: args.isPostedFromDiaryDetails));
    },
    // ConnectScreenRouter.name: (routeData) {
    //   final args = routeData.argsAs<ConnectScreenRouterArgs>();
    //   return _i10.MaterialPageX<dynamic>(
    //       routeData: routeData,
    //       child: _i17.ConnectProfileScreen(
    //           key: args.key,
    //           username: args.username,
    //           uid: args.uid,
    //           sId: args.sId));
    // },
    CommentScreenRouter.name: (routeData) {
      final args = routeData.argsAs<CommentScreenRouterArgs>();
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i18.CommentScreen(
              key: args.key,
              journalModel: args.journalModel,
              index: args.index));
    },
    MyProfileScreen.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i19.MyProfileScreen());
    },
    // PostScreenRouter.name: (routeData) {
    //   final args = routeData.argsAs<PostScreenRouterArgs>(
    //       orElse: () => const PostScreenRouterArgs());
    //   return _i10.MaterialPageX<dynamic>(
    //       routeData: routeData,
    //       child: _i20.PostScreen(key: args.key, sId: args.sId));
    // },
    SettingsScreenRouter.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i21.SettingsScreen());
    },
    AccountPrivacyScreenRouter.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i22.AccountPrivacyScreen());
    },
    EditMyProfileScreenRouter.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i23.EditMyProfileScreen());
    }
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(MasterScreenRouter.name,
            path: 'MasterScreen',
            children: [
              _i10.RouteConfig(HomeScreenRouter.name,
                  path: 'HomeScreen', parent: MasterScreenRouter.name),
              _i10.RouteConfig(JournalingScreenRouter.name,
                  path: 'JournalingScreen',
                  parent: MasterScreenRouter.name,
                  children: [
                    _i10.RouteConfig(JournalingScreen.name,
                        path: '', parent: JournalingScreenRouter.name),
                    _i10.RouteConfig(CreatePostScreenRouter.name,
                        path: 'CreatePostScreen',
                        parent: JournalingScreenRouter.name),
                    _i10.RouteConfig(ConnectScreenRouter.name,
                        path: 'ConnectScreen',
                        parent: JournalingScreenRouter.name),
                    _i10.RouteConfig(CommentScreenRouter.name,
                        path: 'CommentScreen',
                        parent: JournalingScreenRouter.name)
                  ]),
              _i10.RouteConfig(GetHelpScreenRouter.name,
                  path: 'GetHelpMaster', parent: MasterScreenRouter.name),
              _i10.RouteConfig(AppointmentsScreenRouter.name,
                  path: 'AppointmentsScreen', parent: MasterScreenRouter.name),
              _i10.RouteConfig(DoctorsAppointmentsScreenRouter.name,
                  path: 'DoctorsAppointmentsScreen',
                  parent: MasterScreenRouter.name),
              _i10.RouteConfig(MyGoalsScreenRouter.name,
                  path: 'MyGoalsScreen', parent: MasterScreenRouter.name),
              _i10.RouteConfig(MyProfileScreenRouter.name,
                  path: 'MyProfileScreen',
                  parent: MasterScreenRouter.name,
                  children: [
                    _i10.RouteConfig(MyProfileScreen.name,
                        path: '', parent: MyProfileScreenRouter.name),
                    _i10.RouteConfig(PostScreenRouter.name,
                        path: 'PostScreen', parent: MyProfileScreenRouter.name),
                    _i10.RouteConfig(SettingsScreenRouter.name,
                        path: 'SettingsScreen',
                        parent: MyProfileScreenRouter.name),
                    _i10.RouteConfig(AccountPrivacyScreenRouter.name,
                        path: 'AccountPrivacyScreen',
                        parent: MyProfileScreenRouter.name),
                    _i10.RouteConfig(EditMyProfileScreenRouter.name,
                        path: 'EditMyProfileScreen',
                        parent: MyProfileScreenRouter.name)
                  ])
            ]),
        _i10.RouteConfig(IntroCarouselScreenRouter.name,
            path: 'IntroCarouselScreen'),
        _i10.RouteConfig(CreateProfileScreenRouter.name,
            path: 'CreateProfileScreen'),
        _i10.RouteConfig(PhoneAuthScreenRouter.name, path: 'PhoneAuthScreen'),
        _i10.RouteConfig(OTPScreenRouter.name, path: 'OTPScreen'),
        _i10.RouteConfig(ConsultantsScreenRouter.name,
            path: 'ConsultantsScreen'),
        _i10.RouteConfig(SOSScreenRouter.name, path: 'SOSScreen'),
        _i10.RouteConfig(SetupSOSScreenRouter.name, path: 'SetupSOS')
      ];
}

/// generated route for
/// [_i1.MasterScreen]
class MasterScreenRouter extends _i10.PageRouteInfo<MasterScreenRouterArgs> {
  MasterScreenRouter({int? index, List<_i10.PageRouteInfo>? children})
      : super(MasterScreenRouter.name,
            path: 'MasterScreen',
            args: MasterScreenRouterArgs(index: index),
            initialChildren: children);

  static const String name = 'MasterScreenRouter';
}

class MasterScreenRouterArgs {
  const MasterScreenRouterArgs({this.index});

  final int? index;

  @override
  String toString() {
    return 'MasterScreenRouterArgs{index: $index}';
  }
}

/// generated route for
/// [_i2.IntroCrousel]
class IntroCarouselScreenRouter extends _i10.PageRouteInfo<void> {
  const IntroCarouselScreenRouter()
      : super(IntroCarouselScreenRouter.name, path: 'IntroCarouselScreen');

  static const String name = 'IntroCarouselScreenRouter';
}

/// generated route for
/// [_i3.CreateProfileScreen]
class CreateProfileScreenRouter extends _i10.PageRouteInfo<void> {
  const CreateProfileScreenRouter()
      : super(CreateProfileScreenRouter.name, path: 'CreateProfileScreen');

  static const String name = 'CreateProfileScreenRouter';
}

/// generated route for
/// [_i4.PhoneAuthScreen]
class PhoneAuthScreenRouter extends _i10.PageRouteInfo<void> {
  const PhoneAuthScreenRouter()
      : super(PhoneAuthScreenRouter.name, path: 'PhoneAuthScreen');

  static const String name = 'PhoneAuthScreenRouter';
}

/// generated route for
/// [_i5.OTPScreen]
class OTPScreenRouter extends _i10.PageRouteInfo<OTPScreenRouterArgs> {
  OTPScreenRouter(
      {_i24.Key? key, required String phoneNo, required String verificationId})
      : super(OTPScreenRouter.name,
            path: 'OTPScreen',
            args: OTPScreenRouterArgs(
                key: key, phoneNo: phoneNo, verificationId: verificationId));

  static const String name = 'OTPScreenRouter';
}

class OTPScreenRouterArgs {
  const OTPScreenRouterArgs(
      {this.key, required this.phoneNo, required this.verificationId});

  final _i24.Key? key;

  final String phoneNo;

  final String verificationId;

  @override
  String toString() {
    return 'OTPScreenRouterArgs{key: $key, phoneNo: $phoneNo, verificationId: $verificationId}';
  }
}

/// generated route for
/// [_i6.ConsultantsScreen]
class ConsultantsScreenRouter
    extends _i10.PageRouteInfo<ConsultantsScreenRouterArgs> {
  ConsultantsScreenRouter(
      {_i24.Key? key,
      int? page,
      int? count,
      required String slug,
      String? type})
      : super(ConsultantsScreenRouter.name,
            path: 'ConsultantsScreen',
            args: ConsultantsScreenRouterArgs(
                key: key, page: page, count: count, slug: slug, type: type));

  static const String name = 'ConsultantsScreenRouter';
}

class ConsultantsScreenRouterArgs {
  const ConsultantsScreenRouterArgs(
      {this.key, this.page, this.count, required this.slug, this.type});

  final _i24.Key? key;

  final int? page;

  final int? count;

  final String slug;

  final String? type;

  @override
  String toString() {
    return 'ConsultantsScreenRouterArgs{key: $key, page: $page, count: $count, slug: $slug, type: $type}';
  }
}

/// generated route for
/// [_i7.SOSDialog]
class SOSScreenRouter extends _i10.PageRouteInfo<SOSScreenRouterArgs> {
  SOSScreenRouter({_i24.Key? key})
      : super(SOSScreenRouter.name,
            path: 'SOSScreen', args: SOSScreenRouterArgs(key: key));

  static const String name = 'SOSScreenRouter';
}

class SOSScreenRouterArgs {
  const SOSScreenRouterArgs({this.key});

  final _i24.Key? key;

  @override
  String toString() {
    return 'SOSScreenRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.SetupSOSScreen]
class SetupSOSScreenRouter
    extends _i10.PageRouteInfo<SetupSOSScreenRouterArgs> {
  SetupSOSScreenRouter({_i24.Key? key})
      : super(SetupSOSScreenRouter.name,
            path: 'SetupSOS', args: SetupSOSScreenRouterArgs(key: key));

  static const String name = 'SetupSOSScreenRouter';
}

class SetupSOSScreenRouterArgs {
  const SetupSOSScreenRouterArgs({this.key});

  final _i24.Key? key;

  @override
  String toString() {
    return 'SetupSOSScreenRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.HomeScreen]
class HomeScreenRouter extends _i10.PageRouteInfo<void> {
  const HomeScreenRouter() : super(HomeScreenRouter.name, path: 'HomeScreen');

  static const String name = 'HomeScreenRouter';
}

/// generated route for
/// [_i10.EmptyRouterPage]
class JournalingScreenRouter extends _i10.PageRouteInfo<void> {
  const JournalingScreenRouter({List<_i10.PageRouteInfo>? children})
      : super(JournalingScreenRouter.name,
            path: 'JournalingScreen', initialChildren: children);

  static const String name = 'JournalingScreenRouter';
}

/// generated route for
/// [_i11.GetHelpMaster]
class GetHelpScreenRouter extends _i10.PageRouteInfo<void> {
  const GetHelpScreenRouter()
      : super(GetHelpScreenRouter.name, path: 'GetHelpMaster');

  static const String name = 'GetHelpScreenRouter';
}

/// generated route for
/// [_i12.AppointmentScreen]
class AppointmentsScreenRouter
    extends _i10.PageRouteInfo<AppointmentsScreenRouterArgs> {
  AppointmentsScreenRouter({_i24.Key? key})
      : super(AppointmentsScreenRouter.name,
            path: 'AppointmentsScreen',
            args: AppointmentsScreenRouterArgs(key: key));

  static const String name = 'AppointmentsScreenRouter';
}

class AppointmentsScreenRouterArgs {
  const AppointmentsScreenRouterArgs({this.key});

  final _i24.Key? key;

  @override
  String toString() {
    return 'AppointmentsScreenRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.DoctorsAppointmentPage]
class DoctorsAppointmentsScreenRouter
    extends _i10.PageRouteInfo<DoctorsAppointmentsScreenRouterArgs> {
  DoctorsAppointmentsScreenRouter({_i24.Key? key})
      : super(DoctorsAppointmentsScreenRouter.name,
            path: 'DoctorsAppointmentsScreen',
            args: DoctorsAppointmentsScreenRouterArgs(key: key));

  static const String name = 'DoctorsAppointmentsScreenRouter';
}

class DoctorsAppointmentsScreenRouterArgs {
  const DoctorsAppointmentsScreenRouterArgs({this.key});

  final _i24.Key? key;

  @override
  String toString() {
    return 'DoctorsAppointmentsScreenRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.MyGoalsScreen]
class MyGoalsScreenRouter extends _i10.PageRouteInfo<MyGoalsScreenRouterArgs> {
  MyGoalsScreenRouter({_i24.Key? key})
      : super(MyGoalsScreenRouter.name,
            path: 'MyGoalsScreen', args: MyGoalsScreenRouterArgs(key: key));

  static const String name = 'MyGoalsScreenRouter';
}

class MyGoalsScreenRouterArgs {
  const MyGoalsScreenRouterArgs({this.key});

  final _i24.Key? key;

  @override
  String toString() {
    return 'MyGoalsScreenRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i10.EmptyRouterPage]
class MyProfileScreenRouter extends _i10.PageRouteInfo<void> {
  const MyProfileScreenRouter({List<_i10.PageRouteInfo>? children})
      : super(MyProfileScreenRouter.name,
            path: 'MyProfileScreen', initialChildren: children);

  static const String name = 'MyProfileScreenRouter';
}

/// generated route for
/// [_i15.JournalingScreen]
class JournalingScreen extends _i10.PageRouteInfo<void> {
  const JournalingScreen() : super(JournalingScreen.name, path: '');

  static const String name = 'JournalingScreen';
}

/// generated route for
/// [_i16.CreatePostScreen]
class CreatePostScreenRouter
    extends _i10.PageRouteInfo<CreatePostScreenRouterArgs> {
  CreatePostScreenRouter(
      {_i24.Key? key,
      _i25.File? croppedFile,
      Map<String, dynamic>? map,
      bool? isPostedFromDiaryDetails})
      : super(CreatePostScreenRouter.name,
            path: 'CreatePostScreen',
            args: CreatePostScreenRouterArgs(
                key: key,
                croppedFile: croppedFile,
                map: map,
                isPostedFromDiaryDetails: isPostedFromDiaryDetails));

  static const String name = 'CreatePostScreenRouter';
}

class CreatePostScreenRouterArgs {
  const CreatePostScreenRouterArgs(
      {this.key, this.croppedFile, this.map, this.isPostedFromDiaryDetails});

  final _i24.Key? key;

  final _i25.File? croppedFile;

  final Map<String, dynamic>? map;

  final bool? isPostedFromDiaryDetails;

  @override
  String toString() {
    return 'CreatePostScreenRouterArgs{key: $key, croppedFile: $croppedFile, map: $map, isPostedFromDiaryDetails: $isPostedFromDiaryDetails}';
  }
}

/// generated route for
/// [_i17.ConnectProfileScreen]
class ConnectScreenRouter extends _i10.PageRouteInfo<ConnectScreenRouterArgs> {
  ConnectScreenRouter(
      {_i24.Key? key,
      String? username,
      required String uid,
      required String sId})
      : super(ConnectScreenRouter.name,
            path: 'ConnectScreen',
            args: ConnectScreenRouterArgs(
                key: key, username: username, uid: uid, sId: sId));

  static const String name = 'ConnectScreenRouter';
}

class ConnectScreenRouterArgs {
  const ConnectScreenRouterArgs(
      {this.key, this.username, required this.uid, required this.sId});

  final _i24.Key? key;

  final String? username;

  final String uid;

  final String sId;

  @override
  String toString() {
    return 'ConnectScreenRouterArgs{key: $key, username: $username, uid: $uid, sId: $sId}';
  }
}

/// generated route for
/// [_i18.CommentScreen]
class CommentScreenRouter extends _i10.PageRouteInfo<CommentScreenRouterArgs> {
  CommentScreenRouter(
      {_i24.Key? key, required _i26.Journals? journalModel, required int index})
      : super(CommentScreenRouter.name,
            path: 'CommentScreen',
            args: CommentScreenRouterArgs(
                key: key, journalModel: journalModel, index: index));

  static const String name = 'CommentScreenRouter';
}

class CommentScreenRouterArgs {
  const CommentScreenRouterArgs(
      {this.key, required this.journalModel, required this.index});

  final _i24.Key? key;

  final _i26.Journals? journalModel;

  final int index;

  @override
  String toString() {
    return 'CommentScreenRouterArgs{key: $key, journalModel: $journalModel, index: $index}';
  }
}

/// generated route for
/// [_i19.MyProfileScreen]
class MyProfileScreen extends _i10.PageRouteInfo<void> {
  const MyProfileScreen() : super(MyProfileScreen.name, path: '');

  static const String name = 'MyProfileScreen';
}

/// generated route for
/// [_i20.PostScreen]
class PostScreenRouter extends _i10.PageRouteInfo<PostScreenRouterArgs> {
  PostScreenRouter({_i24.Key? key, String? sId})
      : super(PostScreenRouter.name,
            path: 'PostScreen', args: PostScreenRouterArgs(key: key, sId: sId));

  static const String name = 'PostScreenRouter';
}

class PostScreenRouterArgs {
  const PostScreenRouterArgs({this.key, this.sId});

  final _i24.Key? key;

  final String? sId;

  @override
  String toString() {
    return 'PostScreenRouterArgs{key: $key, sId: $sId}';
  }
}

/// generated route for
/// [_i21.SettingsScreen]
class SettingsScreenRouter extends _i10.PageRouteInfo<void> {
  const SettingsScreenRouter()
      : super(SettingsScreenRouter.name, path: 'SettingsScreen');

  static const String name = 'SettingsScreenRouter';
}

/// generated route for
/// [_i22.AccountPrivacyScreen]
class AccountPrivacyScreenRouter extends _i10.PageRouteInfo<void> {
  const AccountPrivacyScreenRouter()
      : super(AccountPrivacyScreenRouter.name, path: 'AccountPrivacyScreen');

  static const String name = 'AccountPrivacyScreenRouter';
}

/// generated route for
/// [_i23.EditMyProfileScreen]
class EditMyProfileScreenRouter extends _i10.PageRouteInfo<void> {
  const EditMyProfileScreenRouter()
      : super(EditMyProfileScreenRouter.name, path: 'EditMyProfileScreen');

  static const String name = 'EditMyProfileScreenRouter';
}
