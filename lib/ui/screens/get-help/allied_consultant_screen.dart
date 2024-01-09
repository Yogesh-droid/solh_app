import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/getHelp/allied_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/model/get-help/packages_list_response_model.dart';
import 'package:solh/services/dynamic_link_sevice/dynamic_link_provider.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/comment/comment-screen.dart';
import 'package:solh/ui/screens/profile-setup/email.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/share_button.dart';
import 'package:solh/widgets_constants/text_field_styles.dart';

import '../../../routes/routes.dart';
import '../../../widgets_constants/appbars/app-bar.dart';
import '../../../widgets_constants/constants/default_org.dart';
import '../../../widgets_constants/loader/my-loader.dart';
import '../my-profile/appointments/controller/appointment_controller.dart';

class AlliedConsultantScreen extends StatefulWidget {
  AlliedConsultantScreen({super.key, required this.args});
  final Map<String, dynamic> args;

  @override
  State<AlliedConsultantScreen> createState() => _AlliedConsultantScreenState();
}

class _AlliedConsultantScreenState extends State<AlliedConsultantScreen> {
  late final ScrollController _scrollController;
  final AlliedController _alliedController = Get.find();
  final TextEditingController _emailTextcontroller = TextEditingController();
  FocusNode _emailFocusNode = FocusNode();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _emailTextcontroller.text = Get.find<ProfileController>()
              .myProfileModel
              .value
              .body!
              .user!
              .email ??
          "";
      _alliedController.userEmail.value = Get.find<ProfileController>()
              .myProfileModel
              .value
              .body!
              .user!
              .email ??
          "";
      _alliedController.selectedPackage.value = '';
      _alliedController.selectedPackagePrice.value = -1;
      _alliedController.selectedPackageDiscountedPrice.value = -1;
      _scrollController = ScrollController();
      _alliedController.getPackages(widget.args["id"]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGreenWithBackgroundArt(
        appBar: SolhAppBar(
          isLandingScreen: false,
          backgroundColor: Colors.transparent,
          title: Text(''),
        ),
        body: Obx(() => _alliedController.isPackageListFetching.value
            ? getShimmer(context)
            : CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    elevation: 0.0,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.all(0),
                      background: ProfileDetails(
                          profile: _alliedController
                              .packagesListModel.value.finalResult),
                      collapseMode: CollapseMode.parallax,
                    ),
                    snap: false,
                    pinned: true,
                    floating: false,
                    expandedHeight: 180,
                  ),
                  SliverToBoxAdapter(
                    child: AboutAndPlans(
                        user: _alliedController
                            .packagesListModel.value.finalResult,
                        id: widget.args["id"]),
                  )
                ],
              )),
        bottomNavBar: getPriceDetails());
  }

  Widget getPriceDetails() {
    return Obx(() {
      return _alliedController.selectedPackagePrice.value > 0
          ? BottomAppBar(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(color: SolhColors.Grey_1, blurRadius: 5)
                ]),
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _alliedController.selectedPackagePrice.value > 0
                              ? "${_alliedController.selectedCurrency} ${_alliedController.selectedPackageDiscountedPrice > 0 ? _alliedController.selectedPackageDiscountedPrice : _alliedController.selectedPackagePrice}"
                              : "No Package",
                          style: SolhTextStyles.QS_body_2_semi.copyWith(
                              color: Colors.black),
                        ),
                        Text(
                          "Total Payable".tr,
                          style: SolhTextStyles.QS_cap_semi,
                        )
                      ],
                    ),
                    Spacer(),
                    SizedBox(
                      width: 10,
                    ),
                    SolhGreenMiniButton(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Buy Plan".tr,
                              style: SolhTextStyles.CTA
                                  .copyWith(color: Colors.white),
                            )
                          ]),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Container(
                                  height: 400,
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(20),
                                        height: 10,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: SolhColors.grey_3,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      Container(height: 20, child: Divider()),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Email-id".tr,
                                                style: SolhTextStyles
                                                    .QS_caption_bold),
                                            SizedBox(height: 5),
                                            TextFormField(
                                              controller: _emailTextcontroller,
                                              focusNode: _emailFocusNode,
                                              decoration: TextFieldStyles
                                                      .greenF_greenBroadUF_4R(
                                                          hintText:
                                                              "John@Email.com")
                                                  .copyWith(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  borderSide: BorderSide(
                                                      color: SolhColors
                                                          .primary_green),
                                                ),
                                              ),
                                              onChanged: (value) {
                                                _alliedController
                                                    .userEmail.value = value;
                                              },
                                              onFieldSubmitted: (value) {
                                                _emailFocusNode.unfocus();
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Obx(() => SolhGreenButton(
                                              height: 48,
                                              width: double.infinity,
                                              backgroundColor: _alliedController
                                                          .userEmail
                                                          .value
                                                          .isEmpty ||
                                                      (!emailVarification(
                                                          _alliedController
                                                              .userEmail.value))
                                                  ? SolhColors.dark_grey
                                                  : SolhColors.primary_green,
                                              child: _alliedController
                                                      .isAlliedBooking.value
                                                  ? MyLoader(
                                                      radius: 8,
                                                      strokeWidth: 2,
                                                    )
                                                  : Text(
                                                      "Continue".tr,
                                                      style: SolhTextStyles.CTA
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                              onPressed: () async {
                                                if (_alliedController.userEmail
                                                    .value.isNotEmpty) {
                                                  if (!emailVarification(
                                                      _alliedController
                                                          .userEmail.value)) {
                                                    Utility.showToast(
                                                        'Enter a correct email-id'
                                                            .tr);
                                                    return;
                                                  } else {
                                                    _emailFocusNode.unfocus();
                                                    try {
                                                      Map<String, dynamic> map =
                                                          await _alliedController
                                                              .createPackageOrder(_alliedController
                                                                      .packagesListModel
                                                                      .value
                                                                      .finalResult!
                                                                      .packages![
                                                                  _alliedController
                                                                      .selectedPackageIndex]);
                                                      if (map['success']) {
                                                        Navigator.pushNamed(
                                                            context,
                                                            AppRoutes
                                                                .paymentscreen,
                                                            arguments: {
                                                              "amount": _alliedController
                                                                          .packagesListModel
                                                                          .value
                                                                          .finalResult!
                                                                          .packages![_alliedController
                                                                              .selectedPackageIndex]
                                                                          .afterDiscountPrice! >
                                                                      0
                                                                  ? _alliedController
                                                                      .packagesListModel
                                                                      .value
                                                                      .finalResult!
                                                                      .packages![
                                                                          _alliedController
                                                                              .selectedPackageIndex]
                                                                      .afterDiscountPrice
                                                                      .toString()
                                                                  : _alliedController
                                                                      .packagesListModel
                                                                      .value
                                                                      .finalResult!
                                                                      .packages![
                                                                          _alliedController
                                                                              .selectedPackageIndex]
                                                                      .amount
                                                                      .toString(),
                                                              "feeCurrency": _alliedController
                                                                  .packagesListModel
                                                                  .value
                                                                  .finalResult!
                                                                  .packages![
                                                                      _alliedController
                                                                          .selectedPackageIndex]
                                                                  .currency,
                                                              "alliedOrderId": map[
                                                                      'data'][
                                                                  "alliedOrderId"],
                                                              "appointmentId":
                                                                  null,
                                                              "inhouseOrderId":
                                                                  null,
                                                              "marketplaceType":
                                                                  "Allied",
                                                              'original_price': _alliedController
                                                                  .packagesListModel
                                                                  .value
                                                                  .finalResult!
                                                                  .packages![
                                                                      _alliedController
                                                                          .selectedPackageIndex]
                                                                  .amount,
                                                              'organisation':
                                                                  DefaultOrg
                                                                          .defaultOrg ??
                                                                      '',
                                                              "paymentGateway":
                                                                  "Stripe",
                                                              "paymentSource":
                                                                  "App",
                                                              "feeCode": _alliedController
                                                                  .packagesListModel
                                                                  .value
                                                                  .finalResult!
                                                                  .packages![
                                                                      _alliedController
                                                                          .selectedPackageIndex]
                                                                  .feeCode
                                                            });
                                                        _alliedController
                                                            .isAlliedBooking(
                                                                false);
                                                        Future.delayed(
                                                            Duration(
                                                                seconds: 2),
                                                            () {
                                                          Get.find<
                                                                  AppointmentController>()
                                                              .getUserAppointments();
                                                        });
                                                      } else {
                                                        Utility.showToast(
                                                            map['message']);
                                                      }
                                                    } on Exception catch (e) {
                                                      print(e.toString());
                                                    }
                                                    /* Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return AlliedBookingContinueDetail(
                                                          finalResult:
                                                              _alliedController
                                                                  .packagesListModel
                                                                  .value
                                                                  .finalResult!,
                                                          packages: _alliedController
                                                                  .packagesListModel
                                                                  .value
                                                                  .finalResult!
                                                                  .packages![
                                                              _alliedController
                                                                  .selectedPackageIndex]);
                                                    })); */
                                                  }
                                                } else {
                                                  Utility.showToast(
                                                      'Please Enter Your Email-id');
                                                }
                                              },
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                    )
                  ],
                ),
              ),
            )
          : SizedBox();
    });
  }
}

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({Key? key, this.profile}) : super(key: key);
  final FinalResult? profile;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        getProfileImage(profile),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 180,
              child: Row(
                children: [
                  Text(
                    profile!.prefix ?? '',
                  ),
                  Text(
                    profile!.name ?? '',
                    style: SolhTextStyles.QS_body_1_bold.copyWith(
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Text(profile!.profession ?? '',
                style: SolhTextStyles.QS_caption.copyWith(color: Colors.white)),
            profile!.experience != null
                ? profile!.experience! > 0
                    ? Text("${profile!.experience ?? 0} Years",
                        style: SolhTextStyles.QS_caption.copyWith(
                            color: Colors.white))
                    : SizedBox()
                : SizedBox(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                getAnalyticsBox(
                    icon: Icon(
                      CupertinoIcons.person_crop_rectangle,
                      color: Colors.white,
                      size: 20,
                    ),
                    no: profile!.numberOfConsultations,
                    title: 'Consultations'),
                getAnalyticsBox(
                    icon: Icon(
                      CupertinoIcons.star,
                      color: Colors.white,
                      size: 20,
                    ),
                    no: profile!.rating,
                    title: 'Rating'),
                getAnalyticsBox(
                    icon: Icon(
                      CupertinoIcons.person_crop_rectangle,
                      color: Colors.white,
                      size: 20,
                    ),
                    no: profile!.posts,
                    title: 'Posts')
              ],
            )
          ],
        )
      ],
    );
  }

  Widget getAnalyticsBox(
      {required Widget icon, required no, required String title}) {
    return Container(
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: SolhColors.greenShade1),
      child: Column(
        children: [
          Row(
            children: [
              icon,
              SizedBox(
                width: 5,
              ),
              Text(
                no.toString(),
                style: SolhTextStyles.SmallTextWhiteS12W7,
              )
            ],
          ),
          Text(
            title,
            style:
                SolhTextStyles.QS_cap_2_semi.copyWith(color: SolhColors.white),
          )
        ],
      ),
    );
  }

  Widget getProfileImage(FinalResult? profile) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 150,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: SolhColors.white),
                borderRadius: BorderRadius.circular(8)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: profile!.profilePicture ?? '',
                fit: BoxFit.cover,
                height: 150,
              ),
            ),
          ),
        ),
        if (profile.isVerified == "Active")
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 6.w,
                  width: 12.w,
                  decoration: BoxDecoration(
                      color: SolhColors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: Colors.black26,
                        )
                      ]),
                  child: Center(
                      child: SvgPicture.asset(
                    'assets/images/verified_consultant.svg',
                    color: SolhColors.primary_green,
                    height: 15,
                  )),
                ),
              ],
            ),
          )
      ],
    );
  }
}

class AboutAndPlans extends StatelessWidget {
  AboutAndPlans({
    super.key,
    this.user,
    required this.id,
  });
  final FinalResult? user;
  final String id;

  final AlliedController _alliedController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SolhColors.bg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'About',
                      style: SolhTextStyles.QS_body_1_bold,
                    ),
                    Obx(() {
                      return _alliedController.isShareingProviderLink.value
                          ? MyLoader(
                              strokeWidth: 2,
                              radius: 10,
                            )
                          : ShareButton(onTap: () async {
                              _alliedController.isShareingProviderLink.value =
                                  true;
                              String link = await DynamicLinkProvider.instance
                                  .createLink(
                                      createFor: 'alliedProvider',
                                      data: {
                                    "alliedProviderId": id,
                                    "creatorUserId":
                                        Get.find<ProfileController>()
                                            .myProfileModel
                                            .value
                                            .body!
                                            .user!
                                            .sId,
                                  });
                              _alliedController.isShareingProviderLink.value =
                                  false;
                              Share.share(
                                  "Hey! Check out this ${user?.name ?? ''}'s package I found on the Solh App $link");
                            });
                    }),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  user!.bio ?? '',
                  style: SolhTextStyles.QS_body_2,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Select Pack".tr,
                  style: SolhTextStyles.QS_body_1_bold,
                ),
              ],
            ),
          ),
          Column(
              children: user!.packages!
                  .map((e) => PackageCard(
                        package: e,
                        onPackageSelect: (String id, int price,
                            int discountedPrice, String currency) {
                          if (!(_alliedController.selectedPackage.value ==
                              id)) {
                            _alliedController.selectedPackage.value = id;
                            _alliedController.selectedPackagePrice.value =
                                price;
                            _alliedController.selectedPackageDiscountedPrice
                                .value = discountedPrice;
                            _alliedController.selectedPackageIndex =
                                user!.packages!.indexOf(e);
                            _alliedController.selectedCurrency.value = currency;
                          } else {
                            _alliedController.selectedPackage.value = "";
                            _alliedController.selectedPackagePrice.value = -1;
                            _alliedController
                                .selectedPackageDiscountedPrice.value = -1;
                          }
                        },
                      ))
                  .toList())
        ],
      ),
    );
  }
}

class PackageCard extends StatelessWidget {
  PackageCard({Key? key, this.package, required this.onPackageSelect})
      : super(key: key);
  final Packages? package;
  final Function(String, int, int, String) onPackageSelect;
  final AlliedController _alliedController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPackageSelect(package!.sId ?? '', package!.amount ?? 0,
          package!.afterDiscountPrice!, package!.currency ?? ''),
      child: Obx(() => AnimatedSize(
            duration: Duration(milliseconds: 500),
            curve: Curves.linear,
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: _alliedController.selectedPackage.value ==
                                package!.sId
                            ? SolhColors.primary_green
                            : Colors.white,
                        width: _alliedController.selectedPackage.value ==
                                package!.sId
                            ? 3
                            : 0),
                  ),
                  child: Column(children: [
                    const SizedBox(height: 20),
                    packageNameAndPrice(),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          packageDetails(),
                          SizedBox(
                            height: 20,
                          ),
                          expandedPanle(package),
                          if (_alliedController.selectedPackage.value !=
                              package!.sId)
                            Align(
                              alignment: Alignment.topRight,
                              child: SolhGreenButton(
                                height: 40,
                                child: AnimatedSwitcher(
                                  duration: Duration(seconds: 5),
                                  child: Text(
                                    'Select'.tr,
                                    style: SolhTextStyles.CTA
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  ]),
                ),
                if (_alliedController.selectedPackage.value == package!.sId)
                  Positioned(
                      right: 0,
                      top: 0,
                      height: 40,
                      width: 40,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: SolhColors.Grey_1,
                                blurRadius: 4,
                              ),
                            ],
                            shape: BoxShape.circle),
                        child: SvgPicture.asset("assets/images/check.svg"),
                      )),
              ],
            ),
          )),
    );
  }

  Widget packageNameAndPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: 65.w,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: SolhColors.tertiary_green,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    topRight: Radius.circular(8))),
            child: Center(
              child: Text(package!.name ?? '',
                  style: SolhTextStyles.QS_body_2_semi.copyWith(
                    color: SolhColors.black,
                  )),
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  "${package!.currency ?? ''} ${package!.afterDiscountPrice != null && package!.afterDiscountPrice! > 0 ? package!.afterDiscountPrice : package!.amount ?? 0}",
                  style: SolhTextStyles.QS_body_1_bold.copyWith(
                      color: SolhColors.primary_green),
                ),
                SizedBox(width: 5),
                if (package!.afterDiscountPrice != null &&
                    package!.afterDiscountPrice! > 0)
                  Text(
                    "${package!.currency ?? ''} ${package!.amount ?? 0}",
                    style: SolhTextStyles.QS_body_1_bold.copyWith(
                        color: SolhColors.grey,
                        decoration: TextDecoration.lineThrough),
                  ),
              ],
            ),
            // Text(
            //   "${package!.currency ?? ''} ${package!.amount ?? 0}",
            //   style: SolhTextStyles.QS_body_1_bold.copyWith(
            //       color: SolhColors.primary_green),
            // ),
            Text(
              'Tax Incl.',
              style: SolhTextStyles.QS_cap_2_semi.copyWith(
                  color: SolhColors.Grey_1),
            )
          ],
        )
      ],
    );
  }

  Widget packageDetails() {
    return Column(children: [
      aboutPackage(package!.aboutPackage ?? '', true),
      // aboutPackage(
      //     "Duration: ${package!.duration} ${package!.unitDuration}", false)
    ]);
  }

  Widget aboutPackage(String s, bool isHtml) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        isHtml ? const SizedBox() : SvgPicture.asset("assets/images/check.svg"),
        SizedBox(
          width: 10,
        ),
        Container(
          width: 75.w,
          child: isHtml
              ? Html(data: s)
              : Text(
                  s,
                  style: SolhTextStyles.QS_cap_semi,
                ),
        )
      ]),
    );
  }

  Widget expandedPanle(Packages? package) {
    return AnimatedSize(
        duration: Duration(milliseconds: 500),
        curve: Curves.linear,
        child: _alliedController.selectedPackage.value == package!.sId
            ? Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      package.benefits!.isNotEmpty
                          ? Text(
                              "Benefits ",
                              style: SolhTextStyles.QS_body_2_bold,
                            )
                          : SizedBox(),
                      SizedBox(height: 15),
                      Container(
                        child: Html(data: package.benefits ?? ''),
                      ),
                      SizedBox(height: 30),
                      package.videoSessions!.isNotEmpty
                          ? Text('Video Package Includes',
                              style: SolhTextStyles.QS_body_2_bold)
                          : const SizedBox(),
                      SizedBox(height: 20),
                      package.videoSessions!.isNotEmpty
                          ? Column(
                              children: package.videoSessions!
                                  .map((e) => videoPackageTile(e))
                                  .toList())
                          : const SizedBox()
                    ]),
              )
            : SizedBox(
                width: double.infinity,
              ));
  }

  Widget videoPackageTile(VideoSessions e) {
    return ExpansionTile(
      title: Row(
        children: [
          Text(
            "Session",
            style:
                SolhTextStyles.QS_cap_2_semi.copyWith(color: SolhColors.Grey_1),
          ),
          SizedBox(
            width: 10.w,
          ),
          Container(
            width: 50.w,
            child: Text(
              e.vName ?? '',
              style: SolhTextStyles.QS_cap_semi,
            ),
          )
        ],
      ),
      children: [
        Row(
          children: [
            SizedBox(
              width: 20.w,
            ),
            Container(
              width: 60.w,
              child: Text(
                e.vDescription ?? '',
                style: SolhTextStyles.QS_caption,
              ),
            ),
          ],
        )
      ],
      childrenPadding: EdgeInsets.all(10),
      iconColor: SolhColors.primary_green,
    );
  }
}
