import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class SolhAppBar extends StatelessWidget implements PreferredSizeWidget {
  SolhAppBar(this.title, this.isLandingScreen);
  final bool isLandingScreen;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      leadingWidth: MediaQuery.of(context).size.width / 15,
      leading: !isLandingScreen
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 24,
              ),
            )
          : null,
      elevation: 2,
      backgroundColor: SolhColors.white,
      actions: isLandingScreen ? [
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
