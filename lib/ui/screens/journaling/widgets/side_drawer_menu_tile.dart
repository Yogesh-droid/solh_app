import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:sizer/sizer.dart';
import 'coming_soon_badge.dart';

class SideDrawerMenuTile extends StatelessWidget {
  const SideDrawerMenuTile({
    Key? key,
    required String title,
    bool isBottomMenu = false,
    VoidCallback? onPressed,
    bool comingSoon = false,
  })  : _title = title,
        _isBottomMenu = isBottomMenu,
        _onPressed = onPressed,
        _comingSoon = comingSoon,
        super(key: key);

  final String _title;
  final bool _comingSoon;
  final bool _isBottomMenu;
  final VoidCallback? _onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onPressed,
      child: Container(
        padding: EdgeInsets.only(left: 4.w, right: 2.3.w),
        height: 6.5.h,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 0.25, color: Color(0xFFD9D9D9)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                getIcon(_title),
                SizedBox(
                  width: 10,
                ),
                Text(
                  _title,
                  style: TextStyle(
                      fontSize: 16,
                      color: _isBottomMenu
                          ? Color(0xFFA6A6A6)
                          : Color(0xFF222222)),
                ),
                if (_comingSoon)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                    child: ComingSoonBadge(),
                  )
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: Color(0xFFA6A6A6),
            )
          ],
        ),
      ),
    );
  }
}

getIcon(title) {
  if (title == "My Diary") {
    return SvgPicture.asset('assets/images/myDiary.svg');
  }
  if (title == "Groups") {
    return SvgPicture.asset('assets/images/groups.svg');
  }
  if (title == "Wheel of Emotions") {
    return SvgPicture.asset('assets/images/wheelOfEmotions.svg');
  }
  if (title == "Appointments") {
    return SvgPicture.asset('assets/images/appointment.svg');
  } else {
    return Container();
  }
}
