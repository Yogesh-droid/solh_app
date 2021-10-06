import 'package:flutter/material.dart';
import 'package:solh/routes/routes.gr.dart';

void main() {
  runApp(SolhApp());
}

class SolhApp extends StatefulWidget {
  @override
  State<SolhApp> createState() => _SolhAppState();
}

class _SolhAppState extends State<SolhApp> {
  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter();

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
