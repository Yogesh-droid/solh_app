import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class SolhAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SolhAppBar({Key? key, String? title})
      : _title = title,
        super(key: key);
  final String? _title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(_title ?? "Solh App"),
    );
  }

  @override
  Size get preferredSize => Size(0, 50);
}

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppBar({
    Key? key,
    required String primaryTitle,
    required String secondaryTitle,
  })  : _primaryTitle = primaryTitle,
        _secondaryTitle = secondaryTitle,
        super(key: key);
  final String _primaryTitle;
  final String _secondaryTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 2.h),
          Text(
            _primaryTitle,
            style: TextStyle(fontSize: 20, color: SolhColors.black34),
          ),
          Text(
            _secondaryTitle,
            style: TextStyle(fontSize: 16, color: SolhColors.grey),
          ),
        ],
      ),
      centerTitle: true,
      elevation: 0,
      foregroundColor: SolhColors.black53,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  @override
  Size get preferredSize => Size(0, 60);
}
