import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/journals/journal_page_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/intro/intro-crousel.dart';
import 'package:solh/ui/screens/notification/notifications_screen.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import '../../ui/my_diary/my_diary_list_page.dart';
import '../../ui/screens/global-search/global_search_page.dart';

class SolhAppBar extends StatelessWidget implements PreferredSizeWidget {
  SolhAppBar(
      {required Widget title,
      required bool isLandingScreen,
      double? height,
      bool isVideoCallScreen = false,
      bool? isDiaryBtnShown,
      bool? isNotificationPage,
      PreferredSize? bottom,
      Widget? menuButton,
      Callback? callback})
      : _title = title,
        _isLandingScreen = isLandingScreen,
        _isVideoCallScreen = isVideoCallScreen,
        _height = height,
        _isDiaryBtnShown = isDiaryBtnShown,
        _bottom = bottom,
        _menuButton = menuButton,
        _onbackPressed = callback,
        _isNotificationPage = isNotificationPage;

  Callback? _onbackPressed;

  final bool _isVideoCallScreen;
  final bool _isLandingScreen;
  final Widget _title;
  final double? _height;
  final bool? _isNotificationPage;
  final bool? _isDiaryBtnShown;
  final PreferredSize? _bottom;
  final Widget? _menuButton;
  final JournalPageController _journalPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            _title,
            _isLandingScreen
                ? Obx(() {
                    return Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.black)),
                      height: 45,
                      width: 160,
                      child: _journalPageController.announcementData.value != ''
                          ? CachedNetworkImage(
                              imageUrl:
                                  _journalPageController.announcementData.value,
                            )
                          : Container(),
                    );
                  })
                : Container(),
          ],
        ),
        bottom: _bottom,
        leadingWidth: _isLandingScreen ? 0 : 60,
        leading: !_isLandingScreen
            ? InkWell(
                onTap: _onbackPressed != null
                    ? _onbackPressed
                    : (() => Navigator.pop(context)),
                child: Container(
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: SolhColors.black,
                    size: 24,
                  ),
                ),
              )
            : null,
        elevation: 0.5,
        backgroundColor: SolhColors.white,
        actions: [
          _isDiaryBtnShown != null
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyDiaryListPage(
                                  isPickFromDiary: null,
                                )));
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/journaling/pick_from_diary.svg',
                    height: 36,
                  ),
                )
              : Container(),
          _isLandingScreen
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => NotificationScreen())));
                  },
                  icon: Icon(
                    Icons.notifications_none,
                    color: SolhColors.primary_green,
                  ))
              : Container(),
          _isLandingScreen
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GlobalSearchPage()));
                    FirebaseAnalytics.instance.logEvent(
                        name: 'SearchTapped', parameters: {'Page': 'AppBar'});
                  },
                  icon: Icon(
                    Icons.search,
                    color: SolhColors.primary_green,
                  ))
              : Container(),

          /// SOS Button
          if (!_isVideoCallScreen) AssistanceButton(),

          ////
          if (_menuButton != null) _menuButton!,
        ]);
  }

  @override
  Size get preferredSize => Size(0, _height ?? 50);
}

class AssistanceButton extends StatelessWidget {
  const AssistanceButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SOSButton();
  }
}

class SOSButton extends StatelessWidget {
  const SOSButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.chatAnonIssues);
        FirebaseAnalytics.instance
            .logEvent(name: 'SOSTapped', parameters: {'Page': 'AppBar'});
      },
      icon: CircleAvatar(
        radius: 28,
        backgroundColor: SolhColors.pink224,
        child: Text(
          "Now",
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
    VoidCallback? onBackButton,
    VoidCallback? onSkip,
    bool? enableSkip,
    // required String subHeading
  })  : _title = title,
        _enableSkip = enableSkip,
        _onSkip = onSkip,
        _onBackButton = onBackButton,

        // _subHeading = subHeading,
        super(key: key);

  final String _title;
  final bool? _enableSkip;
  final VoidCallback? _onBackButton;
  final VoidCallback? _onSkip;
  // final String _subHeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(CupertinoIcons.back),
        onPressed: _onBackButton,
      ),
      actions: [
        _enableSkip != null && _enableSkip!
            ? Padding(
                padding: EdgeInsets.only(right: 10.w, top: 1.h),
                child: SkipButton(
                  onPressed: _onSkip,
                ))
            : Container()
      ],
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

class SolhAppBarTanasparentOnlyBackButton extends StatelessWidget
    implements PreferredSizeWidget {
  SolhAppBarTanasparentOnlyBackButton({
    Key? key,
    this.onBackButton,
    this.onSkip,
    this.skipButtonStyle = SolhTextStyles.GreenBorderButtonText,
    this.backButtonColor = Colors.black,
  }) : super(key: key);

  final VoidCallback? onBackButton;
  final VoidCallback? onSkip;
  final TextStyle skipButtonStyle;

  Color backButtonColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      actions: [
        onSkip != null
            ? SkipButton(
                buttonstyle: skipButtonStyle,
                onPressed: onSkip,
              )
            : Container()
      ],
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.back,
          color: backButtonColor,
        ),
        onPressed: onBackButton,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(0, 50);
}
