import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/instance_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/journals/journal_page_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/home/home_controller.dart';
import 'package:solh/ui/screens/intro/intro-crousel.dart';
import 'package:solh/ui/screens/notification/notifications_screen.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/cart_controller.dart';
import 'package:solh/ui/screens/products/features/home/ui/views/widgets/app_bar_cart_icon.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

import '../../ui/my_diary/my_diary_list_page.dart';
import '../../ui/screens/global-search/global_search_page.dart';
import '../../ui/screens/home/homescreen.dart';

// ignore: must_be_immutable
class SolhAppBar extends StatelessWidget implements PreferredSizeWidget {
  SolhAppBar(
      {required Widget title,
      required bool isLandingScreen,
      double? height,
      bool isVideoCallScreen = false,
      bool? isDiaryBtnShown,
      bool? isCartShown,
      bool? isNotificationPage,
      bool? isProductsPage,
      Color this.backgroundColor = Colors.white,
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
        isNotificationPage = isNotificationPage;

  Callback? _onbackPressed;

  final bool _isVideoCallScreen;
  final bool _isLandingScreen;
  final Widget _title;
  final double? _height;
  final bool? isNotificationPage;
  final bool? _isDiaryBtnShown;
  final Color backgroundColor;
  final PreferredSize? _bottom;
  final Widget? _menuButton;
  final JournalPageController _journalPageController = Get.find();
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        shadowColor: backgroundColor == Colors.transparent
            ? Colors.transparent
            : Colors.black,
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
                    color: backgroundColor == Colors.transparent
                        ? Colors.white
                        : SolhColors.black,
                    size: 24,
                  ),
                ),
              )
            : null,
        elevation: 0.5,
        backgroundColor: backgroundColor,
        actions: [
          // if (_isCartShown == null)
          //   _isProductsPage != null || _isProductsPage != false
          //       ? CartButton(itemsInCart: 2)
          //       : SizedBox.shrink(),
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
                    Get.find<HomeController>().noOfNotifications.value = 0;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => NotificationScreen())));
                  },
                  icon: Obx(() => Stack(
                        children: [
                          Icon(
                            Icons.notifications_none,
                            color: profileController.orgColor1.value.isNotEmpty
                                ? Color(int.parse(
                                    "0xFF${profileController.orgColor1}"))
                                : SolhColors.primary_green,
                          ),
                          Get.find<HomeController>().noOfNotifications.value ==
                                  0
                              ? SizedBox.shrink()
                              : Positioned(
                                  right: -4,
                                  top: -8,
                                  child: Container(
                                    margin: EdgeInsets.all(4),
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: SolhColors.primaryRed,
                                        shape: BoxShape.circle),
                                    child: Obx(() {
                                      return Text(
                                        Get.find<HomeController>()
                                            .noOfNotifications
                                            .value
                                            .toString(),
                                        style: SolhTextStyles.QS_caption_2_bold
                                            .copyWith(
                                          color: SolhColors.white,
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                        ],
                      )))
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

// ignore: must_be_immutable
class SOSButton extends StatelessWidget {
  SOSButton({Key? key}) : super(key: key);
  ProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(context: context, builder: (context) => AnonymousDialog());
        //   profileController.myProfileModel.value.body!.user!.anonymous == null
        //     ? Navigator.pushNamed(context, AppRoutes.anonymousProfile,
        //         arguments: {
        //             "formAnonChat": true,
        //             "indexOfpage": 0,
        //           })
        //     : Navigator.pushNamed(context, AppRoutes.waitingScreen, arguments: {
        //         "formAnonChat": true,
        //         "indexOfpage": 0,
        //       });
        // FirebaseAnalytics.instance.logEvent(
        //     name: 'AnonymousChatCardTapped', parameters: {'Page': 'HomePage'});
        FirebaseAnalytics.instance
            .logEvent(name: 'SOSTapped', parameters: {'Page': 'AppBar'});
      },
      icon: CircleAvatar(
        radius: 28,
        backgroundColor: SolhColors.pink224,
        child: Text(
          "Now".tr,
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

// ignore: must_be_immutable
class SolhAppBarTanasparentOnlyBackButton extends StatelessWidget
    implements PreferredSizeWidget {
  SolhAppBarTanasparentOnlyBackButton({
    Key? key,
    this.onBackButton,
    this.onSkip,
    this.skipButtonStyle,
    this.backButtonColor = Colors.black,
  }) : super(key: key);

  final VoidCallback? onBackButton;
  final VoidCallback? onSkip;
  final TextStyle? skipButtonStyle;

  Color backButtonColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      actions: [
        onSkip != null
            ? SkipButton(
                buttonstyle:
                    skipButtonStyle ?? SolhTextStyles.GreenBorderButtonText,
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
  Size get preferredSize => Size(0, 50);
}

class ProductsAppBar extends StatelessWidget implements PreferredSizeWidget {
  ProductsAppBar({Key? key, this.enableWishlist = true})
      : super(
          key: key,
        );
  final bool enableWishlist;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          icon: Icon(
            Icons.local_mall,
            color: SolhColors.primary_green,
          ),
          onPressed: () =>
              Navigator.of(context).pushNamed(AppRoutes.orderListScreen),
        ),
        Obx(() => CartButton(
            itemsInCart: Get.find<CartController>()
                .cartEntity
                .value
                .cartList!
                .items!
                .length)),
        SizedBox(
          width: 10,
        ),
        enableWishlist
            ? InkWell(
                onTap: () => Navigator.of(context)
                    .pushNamed(AppRoutes.productWishlistScreen),
                child: Icon(
                  CupertinoIcons.heart_fill,
                  color: SolhColors.primaryRed,
                ),
              )
            : Container(),
        SizedBox(
          width: 10,
        ),
        SOSButton()
      ],
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.back,
          color: SolhColors.black,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Size get preferredSize => Size(0, 50);
}
