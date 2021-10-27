import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class SolhAppBar extends StatelessWidget implements PreferredSizeWidget {
  SolhAppBar({Widget? title, required bool isLandingScreen})
      : _title = title,
        _isLandingScreen = isLandingScreen;
  final bool _isLandingScreen;
  final Widget? _title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _title,
      centerTitle: false,
      leadingWidth: _isLandingScreen ? 0 : 30,
      leading: !_isLandingScreen
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: SolhColors.black,
                size: 24,
              ),
            )
          : null,
      elevation: 2,
      backgroundColor: SolhColors.white,
      actions: _isLandingScreen
          ? [
              IconButton(
                onPressed: () => {},
                icon: Icon(
                  Icons.notifications_outlined,
                ),
                color: SolhColors.pink224,
              ),
              IconButton(
                onPressed: () => {},
                icon: CircleAvatar(
                  radius: 28,
                  backgroundColor: SolhColors.pink224,
                  child: Text(
                    "SOS",
                    style: TextStyle(
                      color: SolhColors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                color: SolhColors.pink224,
              ),
            ]
          : [
              IconButton(
                onPressed: () => {},
                icon: CircleAvatar(
                  radius: 28,
                  backgroundColor: SolhColors.pink224,
                  child: Text(
                    "SOS",
                    style: TextStyle(
                      color: SolhColors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                color: SolhColors.pink224,
              ),
            ],
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
