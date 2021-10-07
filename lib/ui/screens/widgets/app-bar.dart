import 'package:flutter/material.dart';

class SolhAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SolhAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Solh App"),
    );
  }

  @override
  Size get preferredSize => Size(0, 50);
}
