// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i19;

import '../bottom-navigation/bottom-navigation.dart' as _i1;
import '../phone-auth/otp-screen.dart' as _i4;
import '../phone-auth/phone-auth.dart' as _i3;
import '../screens/connect/connect-screen.dart' as _i13;
import '../ui/screens/comment/comment-screen.dart' as _i14;
import '../ui/screens/get-help/get-help.dart' as _i9;
import '../ui/screens/home/homescreen.dart' as _i7;
import '../ui/screens/intro/intro-crousel.dart' as _i2;
import '../ui/screens/journaling/create-post.dart' as _i12;
import '../ui/screens/journaling/journaling.dart' as _i11;
import '../ui/screens/my-goals/my-goals-screen.dart' as _i10;
import '../ui/screens/my-profile/my-profile-screen.dart' as _i15;
import '../ui/screens/my-profile/posts/post.dart' as _i16;
import '../ui/screens/my-profile/settings/account-privacy.dart' as _i18;
import '../ui/screens/my-profile/settings/settings.dart' as _i17;
import '../ui/screens/sos/setup-sos.dart' as _i6;
import '../ui/screens/sos/sos.dart' as _i5;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i19.GlobalKey<_i19.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    MasterScreenRouter.name: (routeData) {
      final args = routeData.argsAs<MasterScreenRouterArgs>(
          orElse: () => const MasterScreenRouterArgs());
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.MasterScreen(index: args.index));
    },
    IntroCarouselScreenRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.IntroCrousel());
    },
    PhoneAuthScreenRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.PhoneAuthScreen());
    },
    OTPScreenRouter.name: (routeData) {
      final args = routeData.argsAs<OTPScreenRouterArgs>();
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.OTPScreen(
              key: args.key,
              phoneNo: args.phoneNo,
              verificationId: args.verificationId));
    },
    SOSScreenRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.SOSDialog());
    },
    SetupSOSScreenRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.SetupSOSScreen());
    },
    HomeScreenRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.HomeScreen());
    },
    JournalingScreenRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.EmptyRouterPage());
    },
    GetHelpScreenRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.GetHelpScreen());
    },
    MyGoalsScreenRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.MyGoalsScreen());
    },
    MyProfileScreenRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.EmptyRouterPage());
    },
    JournalingScreen.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.JournalingScreen());
    },
    CreatePostScreenRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.CreatePostScreen());
    },
    ConnectScreenRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i13.ConnectProfileScreen());
    },
    CommentScreenRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i14.CommentScreen());
    },
    MyProfileScreen.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i15.MyProfileScreen());
    },
    PostScreenRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i16.PostScreen());
    },
    SettingsScreenRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i17.SettingsScreen());
    },
    AccountPrivacyScreenRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i18.AccountPrivacyScreen());
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(MasterScreenRouter.name,
            path: 'MasterScreen',
            children: [
              _i8.RouteConfig(HomeScreenRouter.name,
                  path: 'HomeScreen', parent: MasterScreenRouter.name),
              _i8.RouteConfig(JournalingScreenRouter.name,
                  path: 'JournalingScreen',
                  parent: MasterScreenRouter.name,
                  children: [
                    _i8.RouteConfig(JournalingScreen.name,
                        path: '', parent: JournalingScreenRouter.name),
                    _i8.RouteConfig(CreatePostScreenRouter.name,
                        path: 'CreatePostScreen',
                        parent: JournalingScreenRouter.name),
                    _i8.RouteConfig(ConnectScreenRouter.name,
                        path: 'ConnectScreen',
                        parent: JournalingScreenRouter.name),
                    _i8.RouteConfig(CommentScreenRouter.name,
                        path: 'CommentScreen',
                        parent: JournalingScreenRouter.name)
                  ]),
              _i8.RouteConfig(GetHelpScreenRouter.name,
                  path: 'GetHelpScreen', parent: MasterScreenRouter.name),
              _i8.RouteConfig(MyGoalsScreenRouter.name,
                  path: 'MyGoalsScreen', parent: MasterScreenRouter.name),
              _i8.RouteConfig(MyProfileScreenRouter.name,
                  path: 'MyProfileScreen',
                  parent: MasterScreenRouter.name,
                  children: [
                    _i8.RouteConfig(MyProfileScreen.name,
                        path: '', parent: MyProfileScreenRouter.name),
                    _i8.RouteConfig(PostScreenRouter.name,
                        path: 'PostScreen', parent: MyProfileScreenRouter.name),
                    _i8.RouteConfig(SettingsScreenRouter.name,
                        path: 'SettingsScreen',
                        parent: MyProfileScreenRouter.name),
                    _i8.RouteConfig(AccountPrivacyScreenRouter.name,
                        path: 'AccountPrivacyScreen',
                        parent: MyProfileScreenRouter.name)
                  ])
            ]),
        _i8.RouteConfig(IntroCarouselScreenRouter.name,
            path: 'IntroCarouselScreen'),
        _i8.RouteConfig(PhoneAuthScreenRouter.name, path: 'PhoneAuthScreen'),
        _i8.RouteConfig(OTPScreenRouter.name, path: 'OTPScreen'),
        _i8.RouteConfig(SOSScreenRouter.name, path: 'SOSScreen'),
        _i8.RouteConfig(SetupSOSScreenRouter.name, path: 'SetupSOS')
      ];
}

/// generated route for [_i1.MasterScreen]
class MasterScreenRouter extends _i8.PageRouteInfo<MasterScreenRouterArgs> {
  MasterScreenRouter({int? index, List<_i8.PageRouteInfo>? children})
      : super(name,
            path: 'MasterScreen',
            args: MasterScreenRouterArgs(index: index),
            initialChildren: children);

  static const String name = 'MasterScreenRouter';
}

class MasterScreenRouterArgs {
  const MasterScreenRouterArgs({this.index});

  final int? index;
}

/// generated route for [_i2.IntroCrousel]
class IntroCarouselScreenRouter extends _i8.PageRouteInfo<void> {
  const IntroCarouselScreenRouter() : super(name, path: 'IntroCarouselScreen');

  static const String name = 'IntroCarouselScreenRouter';
}

/// generated route for [_i3.PhoneAuthScreen]
class PhoneAuthScreenRouter extends _i8.PageRouteInfo<void> {
  const PhoneAuthScreenRouter() : super(name, path: 'PhoneAuthScreen');

  static const String name = 'PhoneAuthScreenRouter';
}

/// generated route for [_i4.OTPScreen]
class OTPScreenRouter extends _i8.PageRouteInfo<OTPScreenRouterArgs> {
  OTPScreenRouter(
      {_i19.Key? key, required String phoneNo, required String verificationId})
      : super(name,
            path: 'OTPScreen',
            args: OTPScreenRouterArgs(
                key: key, phoneNo: phoneNo, verificationId: verificationId));

  static const String name = 'OTPScreenRouter';
}

class OTPScreenRouterArgs {
  const OTPScreenRouterArgs(
      {this.key, required this.phoneNo, required this.verificationId});

  final _i19.Key? key;

  final String phoneNo;

  final String verificationId;
}

/// generated route for [_i5.SOSDialog]
class SOSScreenRouter extends _i8.PageRouteInfo<void> {
  const SOSScreenRouter() : super(name, path: 'SOSScreen');

  static const String name = 'SOSScreenRouter';
}

/// generated route for [_i6.SetupSOSScreen]
class SetupSOSScreenRouter extends _i8.PageRouteInfo<void> {
  const SetupSOSScreenRouter() : super(name, path: 'SetupSOS');

  static const String name = 'SetupSOSScreenRouter';
}

/// generated route for [_i7.HomeScreen]
class HomeScreenRouter extends _i8.PageRouteInfo<void> {
  const HomeScreenRouter() : super(name, path: 'HomeScreen');

  static const String name = 'HomeScreenRouter';
}

/// generated route for [_i8.EmptyRouterPage]
class JournalingScreenRouter extends _i8.PageRouteInfo<void> {
  const JournalingScreenRouter({List<_i8.PageRouteInfo>? children})
      : super(name, path: 'JournalingScreen', initialChildren: children);

  static const String name = 'JournalingScreenRouter';
}

/// generated route for [_i9.GetHelpScreen]
class GetHelpScreenRouter extends _i8.PageRouteInfo<void> {
  const GetHelpScreenRouter() : super(name, path: 'GetHelpScreen');

  static const String name = 'GetHelpScreenRouter';
}

/// generated route for [_i10.MyGoalsScreen]
class MyGoalsScreenRouter extends _i8.PageRouteInfo<void> {
  const MyGoalsScreenRouter() : super(name, path: 'MyGoalsScreen');

  static const String name = 'MyGoalsScreenRouter';
}

/// generated route for [_i8.EmptyRouterPage]
class MyProfileScreenRouter extends _i8.PageRouteInfo<void> {
  const MyProfileScreenRouter({List<_i8.PageRouteInfo>? children})
      : super(name, path: 'MyProfileScreen', initialChildren: children);

  static const String name = 'MyProfileScreenRouter';
}

/// generated route for [_i11.JournalingScreen]
class JournalingScreen extends _i8.PageRouteInfo<void> {
  const JournalingScreen() : super(name, path: '');

  static const String name = 'JournalingScreen';
}

/// generated route for [_i12.CreatePostScreen]
class CreatePostScreenRouter extends _i8.PageRouteInfo<void> {
  const CreatePostScreenRouter() : super(name, path: 'CreatePostScreen');

  static const String name = 'CreatePostScreenRouter';
}

/// generated route for [_i13.ConnectProfileScreen]
class ConnectScreenRouter extends _i8.PageRouteInfo<void> {
  const ConnectScreenRouter() : super(name, path: 'ConnectScreen');

  static const String name = 'ConnectScreenRouter';
}

/// generated route for [_i14.CommentScreen]
class CommentScreenRouter extends _i8.PageRouteInfo<void> {
  const CommentScreenRouter() : super(name, path: 'CommentScreen');

  static const String name = 'CommentScreenRouter';
}

/// generated route for [_i15.MyProfileScreen]
class MyProfileScreen extends _i8.PageRouteInfo<void> {
  const MyProfileScreen() : super(name, path: '');

  static const String name = 'MyProfileScreen';
}

/// generated route for [_i16.PostScreen]
class PostScreenRouter extends _i8.PageRouteInfo<void> {
  const PostScreenRouter() : super(name, path: 'PostScreen');

  static const String name = 'PostScreenRouter';
}

/// generated route for [_i17.SettingsScreen]
class SettingsScreenRouter extends _i8.PageRouteInfo<void> {
  const SettingsScreenRouter() : super(name, path: 'SettingsScreen');

  static const String name = 'SettingsScreenRouter';
}

/// generated route for [_i18.AccountPrivacyScreen]
class AccountPrivacyScreenRouter extends _i8.PageRouteInfo<void> {
  const AccountPrivacyScreenRouter()
      : super(name, path: 'AccountPrivacyScreen');

  static const String name = 'AccountPrivacyScreenRouter';
}
