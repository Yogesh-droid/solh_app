import 'package:flutter/material.dart';

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget? child;

  static void restartApp(BuildContext context) {
    if (context.findAncestorStateOfType<_RestartWidgetState>() != null) {
      print("Restarting app ");
      context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
    } else {
      print("Not Restarting app ");
    }
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Build Restart widget");
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}
