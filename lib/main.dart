import 'package:flutter/material.dart';
import 'package:solh/routes/routes.gr.dart';

void main() {
  runApp(SolhApp());
}

class SolhApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _appRouter.delegate(initialDeepLink: "/"),
      routeInformationParser: _appRouter.defaultRouteParser(),
      title: 'Anah Ecommerce',
      theme: ThemeData(
        primarySwatch: Colors.green,
        inputDecorationTheme: InputDecorationTheme(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Solh App"),
      ),
      body: Center(
          child: Container(
        child: Text("Root of the Application", style: TextStyle(fontSize: 24)),
      )),
    );
  }
}
