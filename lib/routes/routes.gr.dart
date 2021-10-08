// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../bottom-navigation/bottom-navigation.dart' as _i1;
import '../ui/screens/connect/connect-screen.dart' as _i5;
import '../ui/screens/home/homescreen.dart' as _i3;
import '../ui/screens/intro/intro-crousel.dart' as _i2;
import '../ui/screens/my-goals/my-goals-screen.dart' as _i6;
import '../ui/screens/my-profile/my-profile-screen.dart' as _i7;
import '../ui/screens/share/share-screen.dart' as _i4;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    MasterScreenRouter.name: (routeData) {
      final args = routeData.argsAs<MasterScreenRouterArgs>(
          orElse: () => const MasterScreenRouterArgs());
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.MasterScreen(index: args.index));
    },
    IntroCrouselScreenRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.IntroCrousel());
    },
    HomeScreenRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.HomeScreen());
    },
    ShareScreenRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.ShareScreen());
    },
    ConnectScreenRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.ConnectScreen());
    },
    MyGoalsScreenRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.MyGoalsScreen());
    },
    MyProfileScreenRouter.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.MyProfileScreen());
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(MasterScreenRouter.name,
            path: 'MasterScreen',
            children: [
              _i8.RouteConfig(HomeScreenRouter.name, path: 'HomeScreen'),
              _i8.RouteConfig(ShareScreenRouter.name, path: 'ShareScreen'),
              _i8.RouteConfig(ConnectScreenRouter.name, path: 'ConnectScreen'),
              _i8.RouteConfig(MyGoalsScreenRouter.name, path: 'MyGoalsScreen'),
              _i8.RouteConfig(MyProfileScreenRouter.name,
                  path: 'MyProfileScreen')
            ]),
        _i8.RouteConfig(IntroCrouselScreenRouter.name,
            path: 'IntroCrouselScreen')
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
class IntroCrouselScreenRouter extends _i8.PageRouteInfo<void> {
  const IntroCrouselScreenRouter() : super(name, path: 'IntroCrouselScreen');

  static const String name = 'IntroCrouselScreenRouter';
}

/// generated route for [_i3.HomeScreen]
class HomeScreenRouter extends _i8.PageRouteInfo<void> {
  const HomeScreenRouter() : super(name, path: 'HomeScreen');

  static const String name = 'HomeScreenRouter';
}

/// generated route for [_i4.ShareScreen]
class ShareScreenRouter extends _i8.PageRouteInfo<void> {
  const ShareScreenRouter() : super(name, path: 'ShareScreen');

  static const String name = 'ShareScreenRouter';
}

/// generated route for [_i5.ConnectScreen]
class ConnectScreenRouter extends _i8.PageRouteInfo<void> {
  const ConnectScreenRouter() : super(name, path: 'ConnectScreen');

  static const String name = 'ConnectScreenRouter';
}

/// generated route for [_i6.MyGoalsScreen]
class MyGoalsScreenRouter extends _i8.PageRouteInfo<void> {
  const MyGoalsScreenRouter() : super(name, path: 'MyGoalsScreen');

  static const String name = 'MyGoalsScreenRouter';
}

/// generated route for [_i7.MyProfileScreen]
class MyProfileScreenRouter extends _i8.PageRouteInfo<void> {
  const MyProfileScreenRouter() : super(name, path: 'MyProfileScreen');

  static const String name = 'MyProfileScreenRouter';
}
