// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../bottom-navigation/bottom-navigation.dart' as _i1;
import '../ui/screens/connect/connect-screen.dart' as _i4;
import '../ui/screens/home/homescreen.dart' as _i2;
import '../ui/screens/my-goals/my-goals-screen.dart' as _i5;
import '../ui/screens/my-profile/my-profile-screen.dart' as _i6;
import '../ui/screens/share/share-screen.dart' as _i3;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    MasterScreenRouter.name: (routeData) {
      final args = routeData.argsAs<MasterScreenRouterArgs>(
          orElse: () => const MasterScreenRouterArgs());
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.MasterScreen(index: args.index));
    },
    HomeScreenRouter.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.HomeScreen());
    },
    ShareScreenRouter.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.ShareScreen());
    },
    ConnectScreenRouter.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.ConnectScreen());
    },
    MyGoalsScreenRouter.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.MyGoalsScreen());
    },
    MyProfileScreenRouter.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.MyProfileScreen());
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(MasterScreenRouter.name,
            path: 'MasterScreen',
            children: [
              _i7.RouteConfig(HomeScreenRouter.name, path: 'HomeScreen'),
              _i7.RouteConfig(ShareScreenRouter.name, path: 'ShareScreen'),
              _i7.RouteConfig(ConnectScreenRouter.name, path: 'ConnectScreen'),
              _i7.RouteConfig(MyGoalsScreenRouter.name, path: 'MyGoalsScreen'),
              _i7.RouteConfig(MyProfileScreenRouter.name,
                  path: 'MyProfileScreen')
            ])
      ];
}

/// generated route for [_i1.MasterScreen]
class MasterScreenRouter extends _i7.PageRouteInfo<MasterScreenRouterArgs> {
  MasterScreenRouter({int? index, List<_i7.PageRouteInfo>? children})
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

/// generated route for [_i2.HomeScreen]
class HomeScreenRouter extends _i7.PageRouteInfo<void> {
  const HomeScreenRouter() : super(name, path: 'HomeScreen');

  static const String name = 'HomeScreenRouter';
}

/// generated route for [_i3.ShareScreen]
class ShareScreenRouter extends _i7.PageRouteInfo<void> {
  const ShareScreenRouter() : super(name, path: 'ShareScreen');

  static const String name = 'ShareScreenRouter';
}

/// generated route for [_i4.ConnectScreen]
class ConnectScreenRouter extends _i7.PageRouteInfo<void> {
  const ConnectScreenRouter() : super(name, path: 'ConnectScreen');

  static const String name = 'ConnectScreenRouter';
}

/// generated route for [_i5.MyGoalsScreen]
class MyGoalsScreenRouter extends _i7.PageRouteInfo<void> {
  const MyGoalsScreenRouter() : super(name, path: 'MyGoalsScreen');

  static const String name = 'MyGoalsScreenRouter';
}

/// generated route for [_i6.MyProfileScreen]
class MyProfileScreenRouter extends _i7.PageRouteInfo<void> {
  const MyProfileScreenRouter() : super(name, path: 'MyProfileScreen');

  static const String name = 'MyProfileScreenRouter';
}
