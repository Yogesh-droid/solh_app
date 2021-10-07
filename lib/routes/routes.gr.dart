// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../bottom-navigation/bottom-navigation.dart' as _i3;
import '../ui/screens/connect/connect-screen.dart' as _i6;
import '../ui/screens/home/homescreen.dart' as _i4;
import '../ui/screens/my-goals/my-goals-screen.dart' as _i7;
import '../ui/screens/my-profile/my-profile-screen.dart' as _i8;
import '../ui/screens/share/share-screen.dart' as _i5;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    MasterScreenRouter.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<MasterScreenRouterArgs>(
              orElse: () => const MasterScreenRouterArgs());
          return _i3.MasterScreen(index: args.index);
        }),
    HomeScreenRouter.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i4.HomeScreen();
        }),
    ShareScreenRouter.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i5.ShareScreen();
        }),
    ConnectScreenRouter.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i6.ConnectScreen();
        }),
    MyGoalsScreenRouter.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i7.MyGoalsScreen();
        }),
    MyProfileScreenRouter.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i8.MyProfileScreen();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(MasterScreenRouter.name,
            path: 'MasterScreen',
            children: [
              _i1.RouteConfig(HomeScreenRouter.name, path: 'HomeScreen'),
              _i1.RouteConfig(ShareScreenRouter.name, path: 'ShareScreen'),
              _i1.RouteConfig(ConnectScreenRouter.name, path: 'ConnectScreen'),
              _i1.RouteConfig(MyGoalsScreenRouter.name, path: 'MyGoalsScreen'),
              _i1.RouteConfig(MyProfileScreenRouter.name,
                  path: 'MyProfileScreen')
            ])
      ];
}

class MasterScreenRouter extends _i1.PageRouteInfo<MasterScreenRouterArgs> {
  MasterScreenRouter({int? index, List<_i1.PageRouteInfo>? children})
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

class HomeScreenRouter extends _i1.PageRouteInfo {
  const HomeScreenRouter() : super(name, path: 'HomeScreen');

  static const String name = 'HomeScreenRouter';
}

class ShareScreenRouter extends _i1.PageRouteInfo {
  const ShareScreenRouter() : super(name, path: 'ShareScreen');

  static const String name = 'ShareScreenRouter';
}

class ConnectScreenRouter extends _i1.PageRouteInfo {
  const ConnectScreenRouter() : super(name, path: 'ConnectScreen');

  static const String name = 'ConnectScreenRouter';
}

class MyGoalsScreenRouter extends _i1.PageRouteInfo {
  const MyGoalsScreenRouter() : super(name, path: 'MyGoalsScreen');

  static const String name = 'MyGoalsScreenRouter';
}

class MyProfileScreenRouter extends _i1.PageRouteInfo {
  const MyProfileScreenRouter() : super(name, path: 'MyProfileScreen');

  static const String name = 'MyProfileScreenRouter';
}
