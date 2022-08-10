// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i23;

import '../bottom-navigation/bottom-navigation.dart' as _i1;
import '../model/journal.dart' as _i24;
import '../model/journals/journals_response_model.dart';
import '../ui/screens/comment/comment-screen.dart' as _i17;
import '../ui/screens/connect/connect-screen.dart' as _i16;
import '../ui/screens/get-help/get-help.dart' as _i12;
import '../ui/screens/get-help/view-all/consultants.dart' as _i6;
import '../ui/screens/home/homescreen.dart' as _i10;
import '../ui/screens/intro/intro-crousel.dart' as _i2;
import '../ui/screens/journaling/create-journal.dart' as _i15;
import '../ui/screens/journaling/journaling.dart' as _i14;
import '../ui/screens/my-goals/my-goals-screen.dart' as _i13;
import '../ui/screens/my-profile/my-profile-screen.dart' as _i18;
import '../ui/screens/my-profile/posts/post.dart' as _i19;
import '../ui/screens/my-profile/profile/edit-profile.dart' as _i22;
import '../ui/screens/my-profile/settings/account-privacy.dart' as _i21;
import '../ui/screens/my-profile/settings/settings.dart' as _i20;
import '../ui/screens/phone-auth/otp-screen.dart' as _i5;
import '../ui/screens/phone-auth/phone-auth.dart' as _i4;
import '../ui/screens/profile-setup/profile-setup.dart' as _i3;
import '../ui/screens/sos/setup-sos.dart' as _i8;
import '../ui/screens/sos/sos.dart' as _i7;
import '../ui/screens/video-call/video-call-user.dart' as _i9;

class AppRouter extends _i11.RootStackRouter {
  AppRouter([_i23.GlobalKey<_i23.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    MasterScreenRouter.name: (routeData) {
      final args = routeData.argsAs<MasterScreenRouterArgs>(
          orElse: () => const MasterScreenRouterArgs());
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.MasterScreen(index: args.index));
    },
    IntroCarouselScreenRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.IntroCrousel());
    },
    CreateProfileScreenRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.CreateProfileScreen());
    },
    PhoneAuthScreenRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.PhoneAuthScreen());
    },
    OTPScreenRouter.name: (routeData) {
      final args = routeData.argsAs<OTPScreenRouterArgs>();
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.OTPScreen(
              key: args.key,
              phoneNo: args.phoneNo,
              verificationId: args.verificationId));
    },
    ConsultantsScreenRouter.name: (routeData) {
      final args = routeData.argsAs<ConsultantsScreenRouterArgs>(
          orElse: () => ConsultantsScreenRouterArgs(slug: ''));
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.ConsultantsScreen(
            key: args.key,
            page: args.page,
            count: args.count,
            slug: args.slug,
            type: args.type,
          ));
    },
    SOSScreenRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: _i7.SOSDialog());
    },
    SetupSOSScreenRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: _i8.SetupSOSScreen());
    },
    HomeScreenRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.HomeScreen());
    },
    JournalingScreenRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.EmptyRouterPage());
    },
    GetHelpScreenRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.GetHelpScreen());
    },
    MyGoalsScreenRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: _i13.MyGoalsScreen());
    },
    MyProfileScreenRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.EmptyRouterPage());
    },
    JournalingScreen.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i14.JournalingScreen());
    },
    CreatePostScreenRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: _i15.CreatePostScreen());
    },
    CommentScreenRouter.name: (routeData) {
      final args = routeData.argsAs<CommentScreenRouterArgs>();
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i17.CommentScreen(
            key: args.key,
            journalModel: args.journalModel,
            index: args.index,
          ));
    },
    MyProfileScreen.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i18.MyProfileScreen());
    },
    PostScreenRouter.name: (routeData) {
      final args = routeData.argsAs<PostScreenRouterArgs>();
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i19.PostScreen(
            sId: args.sId,
          ));
    },
    SettingsScreenRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i20.SettingsScreen());
    },
    AccountPrivacyScreenRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i21.AccountPrivacyScreen());
    },
    EditMyProfileScreenRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i22.EditMyProfileScreen());
    }
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(MasterScreenRouter.name,
            path: 'MasterScreen',
            children: [
              _i11.RouteConfig(HomeScreenRouter.name,
                  path: 'HomeScreen', parent: MasterScreenRouter.name),
              _i11.RouteConfig(JournalingScreenRouter.name,
                  path: 'JournalingScreen',
                  parent: MasterScreenRouter.name,
                  children: [
                    _i11.RouteConfig(JournalingScreen.name,
                        path: '', parent: JournalingScreenRouter.name),
                    _i11.RouteConfig(CreatePostScreenRouter.name,
                        path: 'CreatePostScreen',
                        parent: JournalingScreenRouter.name),
                    _i11.RouteConfig(ConnectScreenRouter.name,
                        path: 'ConnectScreen',
                        parent: JournalingScreenRouter.name),
                    _i11.RouteConfig(CommentScreenRouter.name,
                        path: 'CommentScreen',
                        parent: JournalingScreenRouter.name)
                  ]),
              _i11.RouteConfig(GetHelpScreenRouter.name,
                  path: 'GetHelpScreen', parent: MasterScreenRouter.name),
              _i11.RouteConfig(MyGoalsScreenRouter.name,
                  path: 'MyGoalsScreen', parent: MasterScreenRouter.name),
              _i11.RouteConfig(MyProfileScreenRouter.name,
                  path: 'MyProfileScreen',
                  parent: MasterScreenRouter.name,
                  children: [
                    _i11.RouteConfig(MyProfileScreen.name,
                        path: '', parent: MyProfileScreenRouter.name),
                    _i11.RouteConfig(PostScreenRouter.name,
                        path: 'PostScreen', parent: MyProfileScreenRouter.name),
                    _i11.RouteConfig(SettingsScreenRouter.name,
                        path: 'SettingsScreen',
                        parent: MyProfileScreenRouter.name),
                    _i11.RouteConfig(AccountPrivacyScreenRouter.name,
                        path: 'AccountPrivacyScreen',
                        parent: MyProfileScreenRouter.name),
                    _i11.RouteConfig(EditMyProfileScreenRouter.name,
                        path: 'EditMyProfileScreen',
                        parent: MyProfileScreenRouter.name)
                  ])
            ]),
        _i11.RouteConfig(IntroCarouselScreenRouter.name,
            path: 'IntroCarouselScreen'),
        _i11.RouteConfig(CreateProfileScreenRouter.name,
            path: 'CreateProfileScreen'),
        _i11.RouteConfig(PhoneAuthScreenRouter.name, path: 'PhoneAuthScreen'),
        _i11.RouteConfig(OTPScreenRouter.name, path: 'OTPScreen'),
        _i11.RouteConfig(ConsultantsScreenRouter.name,
            path: 'ConsultantsScreen'),
        _i11.RouteConfig(SOSScreenRouter.name, path: 'SOSScreen'),
        _i11.RouteConfig(SetupSOSScreenRouter.name, path: 'SetupSOS'),
        _i11.RouteConfig(VideoCallCounsellorRouter.name,
            path: 'VideoCallCounsellor')
      ];
}

/// generated route for
/// [_i1.MasterScreen]
class MasterScreenRouter extends _i11.PageRouteInfo<MasterScreenRouterArgs> {
  MasterScreenRouter({int? index, List<_i11.PageRouteInfo>? children})
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
class IntroCarouselScreenRouter extends _i11.PageRouteInfo<void> {
  const IntroCarouselScreenRouter()
      : super(IntroCarouselScreenRouter.name, path: 'IntroCarouselScreen');

  static const String name = 'IntroCarouselScreenRouter';
}

/// generated route for
/// [_i3.CreateProfileScreen]
class CreateProfileScreenRouter extends _i11.PageRouteInfo<void> {
  const CreateProfileScreenRouter()
      : super(CreateProfileScreenRouter.name, path: 'CreateProfileScreen');

  static const String name = 'CreateProfileScreenRouter';
}

/// generated route for
/// [_i4.PhoneAuthScreen]
class PhoneAuthScreenRouter extends _i11.PageRouteInfo<void> {
  const PhoneAuthScreenRouter()
      : super(PhoneAuthScreenRouter.name, path: 'PhoneAuthScreen');

  static const String name = 'PhoneAuthScreenRouter';
}

/// generated route for
/// [_i5.OTPScreen]
class OTPScreenRouter extends _i11.PageRouteInfo<OTPScreenRouterArgs> {
  OTPScreenRouter(
      {_i23.Key? key, required String phoneNo, required String verificationId})
      : super(OTPScreenRouter.name,
            path: 'OTPScreen',
            args: OTPScreenRouterArgs(
                key: key, phoneNo: phoneNo, verificationId: verificationId));

  static const String name = 'OTPScreenRouter';
}

class OTPScreenRouterArgs {
  const OTPScreenRouterArgs(
      {this.key, required this.phoneNo, required this.verificationId});

  final _i23.Key? key;

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
    extends _i11.PageRouteInfo<ConsultantsScreenRouterArgs> {
  ConsultantsScreenRouter(
      {_i23.Key? key,
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
      {required this.slug, this.key, this.page, this.count, this.type});

  final _i23.Key? key;

  final int? page;

  final int? count;
  final String slug;
  final String? type;

  @override
  String toString() {
    return 'ConsultantsScreenRouterArgs{key: $key, page: $page, count: $count}';
  }
}

/// generated route for
/// [_i7.SOSDialog]
class SOSScreenRouter extends _i11.PageRouteInfo<void> {
  const SOSScreenRouter() : super(SOSScreenRouter.name, path: 'SOSScreen');

  static const String name = 'SOSScreenRouter';
}

/// generated route for
/// [_i8.SetupSOSScreen]
class SetupSOSScreenRouter extends _i11.PageRouteInfo<void> {
  const SetupSOSScreenRouter()
      : super(SetupSOSScreenRouter.name, path: 'SetupSOS');

  static const String name = 'SetupSOSScreenRouter';
}

/// generated route for
/// [_i9.VideoCallCounsellor]
class VideoCallCounsellorRouter extends _i11.PageRouteInfo<void> {
  const VideoCallCounsellorRouter()
      : super(VideoCallCounsellorRouter.name, path: 'VideoCallCounsellor');

  static const String name = 'VideoCallCounsellorRouter';
}

/// generated route for
/// [_i10.HomeScreen]
class HomeScreenRouter extends _i11.PageRouteInfo<void> {
  const HomeScreenRouter() : super(HomeScreenRouter.name, path: 'HomeScreen');

  static const String name = 'HomeScreenRouter';
}

/// generated route for
/// [_i11.EmptyRouterPage]
class JournalingScreenRouter extends _i11.PageRouteInfo<void> {
  const JournalingScreenRouter({List<_i11.PageRouteInfo>? children})
      : super(JournalingScreenRouter.name,
            path: 'JournalingScreen', initialChildren: children);

  static const String name = 'JournalingScreenRouter';
}

/// generated route for
/// [_i12.GetHelpScreen]
class GetHelpScreenRouter extends _i11.PageRouteInfo<void> {
  const GetHelpScreenRouter()
      : super(GetHelpScreenRouter.name, path: 'GetHelpScreen');

  static const String name = 'GetHelpScreenRouter';
}

/// generated route for
/// [_i13.MyGoalsScreen]
class MyGoalsScreenRouter extends _i11.PageRouteInfo<void> {
  const MyGoalsScreenRouter()
      : super(MyGoalsScreenRouter.name, path: 'MyGoalsScreen');

  static const String name = 'MyGoalsScreenRouter';
}

/// generated route for
/// [_i11.EmptyRouterPage]
class MyProfileScreenRouter extends _i11.PageRouteInfo<void> {
  const MyProfileScreenRouter({List<_i11.PageRouteInfo>? children})
      : super(MyProfileScreenRouter.name,
            path: 'MyProfileScreen', initialChildren: children);

  static const String name = 'MyProfileScreenRouter';
}

/// generated route for
/// [_i14.JournalingScreen]
class JournalingScreen extends _i11.PageRouteInfo<void> {
  const JournalingScreen() : super(JournalingScreen.name, path: '');

  static const String name = 'JournalingScreen';
}

/// generated route for
/// [_i15.CreatePostScreen]
class CreatePostScreenRouter extends _i11.PageRouteInfo<void> {
  const CreatePostScreenRouter()
      : super(CreatePostScreenRouter.name, path: 'CreatePostScreen');

  static const String name = 'CreatePostScreenRouter';
}

/// generated route for
/// [_i16.ConnectProfileScreen]
class ConnectScreenRouter extends _i11.PageRouteInfo<ConnectScreenRouterArgs> {
  ConnectScreenRouter({_i23.Key? key, required String uid, required String sId})
      : super(ConnectScreenRouter.name,
            path: 'ConnectScreen',
            args: ConnectScreenRouterArgs(key: key, uid: uid, sId: sId));

  static const String name = 'ConnectScreenRouter';
}

class ConnectScreenRouterArgs {
  const ConnectScreenRouterArgs(
      {this.key, required this.uid, required this.sId});

  final _i23.Key? key;

  final String uid;
  final String sId;

  @override
  String toString() {
    return 'ConnectScreenRouterArgs{key: $key, uid: $uid}';
  }
}

/// generated route for
/// [_i17.CommentScreen]
class CommentScreenRouter extends _i11.PageRouteInfo<CommentScreenRouterArgs> {
  CommentScreenRouter(
      {_i23.Key? key, required Journals? journalModel, required int index})
      : super(CommentScreenRouter.name,
            path: 'CommentScreen',
            args: CommentScreenRouterArgs(
                key: key, journalModel: journalModel, index: index));

  static const String name = 'CommentScreenRouter';
}

class CommentScreenRouterArgs {
  const CommentScreenRouterArgs({
    this.key,
    required this.journalModel,
    required this.index,
  });

  final _i23.Key? key;

  final Journals? journalModel;
  final int index;

  @override
  String toString() {
    return 'CommentScreenRouterArgs{key: $key, journalModel: $journalModel}';
  }
}

/// generated route for
/// [_i18.MyProfileScreen]
class MyProfileScreen extends _i11.PageRouteInfo<void> {
  const MyProfileScreen() : super(MyProfileScreen.name, path: '');

  static const String name = 'MyProfileScreen';
}

/// generated route for
/// [_i19.PostScreen]
class PostScreenRouter extends _i11.PageRouteInfo<void> {
  PostScreenRouter({required String? sId})
      : super(PostScreenRouter.name,
            path: 'PostScreen', args: PostScreenRouterArgs(sId: sId));

  static const String name = 'PostScreenRouter';
}

class PostScreenRouterArgs {
  const PostScreenRouterArgs({
    this.key,
    required this.sId,
  });

  final _i23.Key? key;
  final String? sId;
  @override
  String toString() {
    return 'PostScreenRouterArgs{key: $key, sId: $sId}';
  }
}

/// generated route for
/// [_i20.SettingsScreen]
class SettingsScreenRouter extends _i11.PageRouteInfo<void> {
  const SettingsScreenRouter()
      : super(SettingsScreenRouter.name, path: 'SettingsScreen');

  static const String name = 'SettingsScreenRouter';
}

/// generated route for
/// [_i21.AccountPrivacyScreen]
class AccountPrivacyScreenRouter extends _i11.PageRouteInfo<void> {
  const AccountPrivacyScreenRouter()
      : super(AccountPrivacyScreenRouter.name, path: 'AccountPrivacyScreen');

  static const String name = 'AccountPrivacyScreenRouter';
}

/// generated route for
/// [_i22.EditMyProfileScreen]
class EditMyProfileScreenRouter extends _i11.PageRouteInfo<void> {
  const EditMyProfileScreenRouter()
      : super(EditMyProfileScreenRouter.name, path: 'EditMyProfileScreen');

  static const String name = 'EditMyProfileScreenRouter';
}
