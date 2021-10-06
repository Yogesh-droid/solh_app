// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../bottom-navigation/bottom-navigation.dart' as _i3;
import '../ui/screens/home/homescreen.dart' as _i4;

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
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(MasterScreenRouter.name,
            path: 'MasterScreen',
            children: [
              _i1.RouteConfig(HomeScreenRouter.name, path: 'homeScreen')
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
  const HomeScreenRouter() : super(name, path: 'homeScreen');

  static const String name = 'HomeScreenRouter';
}
