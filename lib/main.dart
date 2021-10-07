import 'package:flutter/material.dart';
import 'package:solh/routes/routes.gr.dart';

void main() {
  runApp(SolhApp());
}

class SolhApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _appRouter.delegate(initialDeepLink: "MasterScreen"),
      routeInformationParser: _appRouter.defaultRouteParser(),
      title: 'Anah Ecommerce',
      theme: ThemeData(
        primarySwatch: Colors.green,
        inputDecorationTheme: InputDecorationTheme(),
      ),
    );
  }
}
