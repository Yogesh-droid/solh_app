import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/sos/sos.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class SolhAppBar extends StatelessWidget implements PreferredSizeWidget {
  SolhAppBar({Widget? title, required bool isLandingScreen, double? height})
      : _title = title,
        _isLandingScreen = isLandingScreen,
        _height = height;
  final bool _isLandingScreen;
  final Widget? _title;
  final double? _height;

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
      elevation: 0.5,
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
              SOSButton()
            ]
          : [SOSButton()],
    );
  }

  @override
  Size get preferredSize => Size(0, _height ?? 50);
}

class SOSButton extends StatelessWidget {
  const SOSButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        print("sos");
        showDialog(context: context, builder: (_) => SOSDialog());
        // AutoRouter.of(context).push(SOSScreenRouter());
      },
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
    );
  }
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

class ProfileSetupAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProfileSetupAppBar({
    Key? key,
    required String title,
    // required String subHeading
  })  : _title = title,
        // _subHeading = subHeading,
        super(key: key);

  final String _title;
  // final String _subHeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.black,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      title: Column(
        children: [
          Text(_title),
          // Text(
          //   _subHeading,
          //   style: TextStyle(color: Color(0xFFA6A6A6), fontSize: 16),
          // ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(0, 50);
}
