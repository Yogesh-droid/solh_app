// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i12;

import '../bottom-navigation/bottom-navigation.dart' as _i1;
import '../phone-auth/otp-screen.dart' as _i4;
import '../phone-auth/phone-auth.dart' as _i3;
import '../ui/screens/connect/connect-screen.dart' as _i7;
import '../ui/screens/home/homescreen.dart' as _i5;
import '../ui/screens/intro/intro-crousel.dart' as _i2;
import '../ui/screens/my-goals/my-goals-screen.dart' as _i8;
import '../ui/screens/my-profile/my-profile-screen.dart' as _i9;
import '../ui/screens/share/create-post.dart' as _i11;
import '../ui/screens/share/share-screen.dart' as _i10;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i12.GlobalKey<_i12.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    MasterScreenRouter.name: (routeData) {
      final args = routeData.argsAs<MasterScreenRouterArgs>(
          orElse: () => const MasterScreenRouterArgs());
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.MasterScreen(index: args.index));
    },
    IntroCarouselScreenRouter.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.IntroCrousel());
    },
    PhoneAuthScreenRouter.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.PhoneAuthScreen());
    },
    OTPScreenRouter.name: (routeData) {
      final args = routeData.argsAs<OTPScreenRouterArgs>();
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.OTPScreen(
              key: args.key,
              phoneNo: args.phoneNo,
              verificationId: args.verificationId));
    },
    HomeScreenRouter.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.HomeScreen());
    },
    ShareScreenRouter.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.EmptyRouterPage());
    },
    ConnectScreenRouter.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.ConnectScreen());
    },
    MyGoalsScreenRouter.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.MyGoalsScreen());
    },
    MyProfileScreenRouter.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.MyProfileScreen());
    },
    ShareScreen.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.ShareScreen());
    },
    CreatePostScreenRouter.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.CreatePostScreen());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(MasterScreenRouter.name,
            path: 'MasterScreen',
            children: [
              _i6.RouteConfig(HomeScreenRouter.name,
                  path: 'HomeScreen', parent: MasterScreenRouter.name),
              _i6.RouteConfig(ShareScreenRouter.name,
                  path: 'ShareScreen',
                  parent: MasterScreenRouter.name,
                  children: [
                    _i6.RouteConfig(ShareScreen.name,
                        path: '', parent: ShareScreenRouter.name),
                    _i6.RouteConfig(CreatePostScreenRouter.name,
                        path: 'CreatePostScreen',
                        parent: ShareScreenRouter.name)
                  ]),
              _i6.RouteConfig(ConnectScreenRouter.name,
                  path: 'ConnectScreen', parent: MasterScreenRouter.name),
              _i6.RouteConfig(MyGoalsScreenRouter.name,
                  path: 'MyGoalsScreen', parent: MasterScreenRouter.name),
              _i6.RouteConfig(MyProfileScreenRouter.name,
                  path: 'MyProfileScreen', parent: MasterScreenRouter.name)
            ]),
        _i6.RouteConfig(IntroCarouselScreenRouter.name,
            path: 'IntroCarouselScreen'),
        _i6.RouteConfig(PhoneAuthScreenRouter.name, path: 'PhoneAuthScreen'),
        _i6.RouteConfig(OTPScreenRouter.name, path: 'OTPScreen')
      ];
}

/// generated route for [_i1.MasterScreen]
class MasterScreenRouter extends _i6.PageRouteInfo<MasterScreenRouterArgs> {
  MasterScreenRouter({int? index, List<_i6.PageRouteInfo>? children})
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
class IntroCarouselScreenRouter extends _i6.PageRouteInfo<void> {
  const IntroCarouselScreenRouter() : super(name, path: 'IntroCarouselScreen');

  static const String name = 'IntroCarouselScreenRouter';
}

/// generated route for [_i3.PhoneAuthScreen]
class PhoneAuthScreenRouter extends _i6.PageRouteInfo<void> {
  const PhoneAuthScreenRouter() : super(name, path: 'PhoneAuthScreen');

  static const String name = 'PhoneAuthScreenRouter';
}

/// generated route for [_i4.OTPScreen]
class OTPScreenRouter extends _i6.PageRouteInfo<OTPScreenRouterArgs> {
  OTPScreenRouter(
      {_i12.Key? key, required String phoneNo, required String verificationId})
      : super(name,
            path: 'OTPScreen',
            args: OTPScreenRouterArgs(
                key: key, phoneNo: phoneNo, verificationId: verificationId));

  static const String name = 'OTPScreenRouter';
}

class OTPScreenRouterArgs {
  const OTPScreenRouterArgs(
      {this.key, required this.phoneNo, required this.verificationId});

  final _i12.Key? key;

  final String phoneNo;

  final String verificationId;
}

/// generated route for [_i5.HomeScreen]
class HomeScreenRouter extends _i6.PageRouteInfo<void> {
  const HomeScreenRouter() : super(name, path: 'HomeScreen');

  static const String name = 'HomeScreenRouter';
}

/// generated route for [_i6.EmptyRouterPage]
class ShareScreenRouter extends _i6.PageRouteInfo<void> {
  const ShareScreenRouter({List<_i6.PageRouteInfo>? children})
      : super(name, path: 'ShareScreen', initialChildren: children);

  static const String name = 'ShareScreenRouter';
}

/// generated route for [_i7.ConnectScreen]
class ConnectScreenRouter extends _i6.PageRouteInfo<void> {
  const ConnectScreenRouter() : super(name, path: 'ConnectScreen');

  static const String name = 'ConnectScreenRouter';
}

/// generated route for [_i8.MyGoalsScreen]
class MyGoalsScreenRouter extends _i6.PageRouteInfo<void> {
  const MyGoalsScreenRouter() : super(name, path: 'MyGoalsScreen');

  static const String name = 'MyGoalsScreenRouter';
}

/// generated route for [_i9.MyProfileScreen]
class MyProfileScreenRouter extends _i6.PageRouteInfo<void> {
  const MyProfileScreenRouter() : super(name, path: 'MyProfileScreen');

  static const String name = 'MyProfileScreenRouter';
}

/// generated route for [_i10.ShareScreen]
class ShareScreen extends _i6.PageRouteInfo<void> {
  const ShareScreen() : super(name, path: '');

  static const String name = 'ShareScreen';
}

/// generated route for [_i11.CreatePostScreen]
class CreatePostScreenRouter extends _i6.PageRouteInfo<void> {
  const CreatePostScreenRouter() : super(name, path: 'CreatePostScreen');

  static const String name = 'CreatePostScreenRouter';
}
