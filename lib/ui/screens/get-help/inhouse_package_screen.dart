import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/getHelp/allied_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/model/get-help/inhouse_package_model.dart';
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
import '../../../widgets_constants/loader/my-loader.dart';
import '../my-profile/appointments/controller/appointment_controller.dart';
import 'package_card.dart';

class InhousePackageScreen extends StatefulWidget {
  InhousePackageScreen({super.key, required this.args});
  final Map<String, dynamic> args;

  @override
  State<InhousePackageScreen> createState() => _InhousePackageScreenState();
}

class _InhousePackageScreenState extends State<InhousePackageScreen> {
  late final ScrollController _scrollController;
  final AlliedController _alliedController = Get.find();
  final TextEditingController _emailTextcontroller = TextEditingController();
  FocusNode _emailFocusNode = FocusNode();
  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
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
        _alliedController.getInhousePackage(widget.args["id"]);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGreenWithBackgroundArt(
        appBar: SolhAppBar(
          isLandingScreen: false,
          title: Text(''),
        ),
        body: Obx(() => _alliedController.inhousePackageFetching.value
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
                              .inhousePackageModel.value.carousel),
                      collapseMode: CollapseMode.parallax,
                    ),
                    snap: false,
                    pinned: true,
                    floating: false,
                    expandedHeight: 180,
                  ),
                  SliverToBoxAdapter(
                    child: AboutAndPlans(
                      packageList: _alliedController
                          .inhousePackageModel.value.packageList,
                      user:
                          _alliedController.inhousePackageModel.value.carousel,
                      id: widget.args['id'],
                    ),
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
                          "Total Payable",
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
                                                      .isInHouseBooking.value
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
                                                        'Enter a correct email-id');
                                                    return;
                                                  } else {
                                                    _emailFocusNode.unfocus();
                                                    try {
                                                      Map<String, dynamic> map =
                                                          await _alliedController
                                                              .createInhousePackageOrder(_alliedController
                                                                      .inhousePackageModel
                                                                      .value
                                                                      .packageList![
                                                                  _alliedController
                                                                      .selectedPackageIndex]);
                                                      print("inhouse $map");
                                                      if (map['success']) {
                                                        Future.delayed(
                                                            Duration(
                                                                seconds: 0),
                                                            () {
                                                          Get.find<
                                                                  AppointmentController>()
                                                              .getUserAppointments();

                                                          Navigator.pushNamed(
                                                              context,
                                                              AppRoutes
                                                                  .paymentscreen,
                                                              arguments: {
                                                                "amount": _alliedController.inhousePackageModel.value.packageList![_alliedController.selectedPackageIndex].discountedPrice !=
                                                                            null &&
                                                                        _alliedController.inhousePackageModel.value.packageList![_alliedController.selectedPackageIndex].discountedPrice! >
                                                                            0
                                                                    ? _alliedController
                                                                        .inhousePackageModel
                                                                        .value
                                                                        .packageList![_alliedController
                                                                            .selectedPackageIndex]
                                                                        .discountedPrice
                                                                        .toString()
                                                                    : _alliedController
                                                                        .inhousePackageModel
                                                                        .value
                                                                        .packageList![
                                                                            _alliedController.selectedPackageIndex]
                                                                        .amount
                                                                        .toString(),
                                                                "feeCurrency": _alliedController
                                                                    .inhousePackageModel
                                                                    .value
                                                                    .packageList![
                                                                        _alliedController
                                                                            .selectedPackageIndex]
                                                                    .currency,
                                                                "alliedOrderId":
                                                                    null,
                                                                "appointmentId":
                                                                    null,
                                                                "inhouseOrderId":
                                                                    map["data"][
                                                                        "inhouseOrderId"],
                                                                "marketplaceType":
                                                                    "Inhouse",
                                                                "paymentGateway":
                                                                    "Stripe",
                                                                "paymentSource":
                                                                    "App",
                                                                "feeCode": _alliedController
                                                                    .inhousePackageModel
                                                                    .value
                                                                    .packageList![
                                                                        _alliedController
                                                                            .selectedPackageIndex]
                                                                    .feeCode
                                                              });
                                                          _alliedController
                                                              .isInHouseBooking(
                                                                  false);
                                                        });
                                                      } else {
                                                        Utility.showToast(
                                                            map['message']);
                                                      }
                                                    } on Exception catch (e) {
                                                      print(e.toString());
                                                    }
                                                    /* Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return InhouseContinueDetail(
                                                              carousel:
                                                                  _alliedController
                                                                      .inhousePackageModel
                                                                      .value
                                                                      .carousel!,
                                                              packages: _alliedController
                                                                      .inhousePackageModel
                                                                      .value
                                                                      .packageList![
                                                                  _alliedController
                                                                      .selectedPackageIndex]);
                                                        },
                                                      ),
                                                    ); */
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
  final Carousel? profile;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
          fit: BoxFit.fill, child: Image(image: NetworkImage(profile!.image!))),
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

class AboutAndPlans extends StatefulWidget {
  AboutAndPlans({super.key, this.user, this.packageList, required this.id});
  final Carousel? user;
  final List<PackageList>? packageList;
  final String id;

  @override
  State<AboutAndPlans> createState() => _AboutAndPlansState();
}

class _AboutAndPlansState extends State<AboutAndPlans> {
  final AlliedController _alliedController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _alliedController.selectedPackage.value = widget.packageList!.first.sId!;
      _alliedController.selectedPackagePrice.value =
          widget.packageList!.first.amount!;
      _alliedController.selectedPackageDiscountedPrice.value =
          widget.packageList!.first.discountedPrice ?? -1;
      _alliedController.selectedCurrency.value =
          widget.packageList!.first.currency!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SolhColors.white,
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(8),
        //   topRight: Radius.circular(8),
        // ),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.user!.name ?? '',
                      style: SolhTextStyles.QS_big_body,
                    ),
                    Obx(() {
                      return _alliedController.isShareingLink.value
                          ? MyLoader(
                              radius: 13,
                              strokeWidth: 2,
                            )
                          : ShareButton(
                              onTap: () async {
                                _alliedController.isShareingLink(true);
                                String link = await DynamicLinkProvider.instance
                                    .createLink(
                                        createFor: 'inHousePackage',
                                        data: {
                                      'inHousePackageId': widget.id,
                                      "creatorUserId":
                                          Get.find<ProfileController>()
                                              .myProfileModel
                                              .value
                                              .body!
                                              .user!
                                              .id!,
                                    });

                                Share.share(
                                    "Hey! Check out this ${widget.user!.name} package I found on the Solh App $link");
                                _alliedController.isShareingLink(false);
                              },
                            );
                    })
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Html(
                  data: widget.user!.description ?? '',
                  style: {
                    'p': Style(
                      fontSize: FontSize(14),
                      color: SolhColors.dark_grey,
                      fontWeight: FontWeight.w600,
                    ),
                    'li': Style(
                      fontSize: FontSize(14),
                      color: SolhColors.dark_grey,
                      fontWeight: FontWeight.w600,
                    ),
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          Column(
              children: widget.packageList!
                  .map((e) => PackageCard(
                        package: e,
                        onPackageSelect:
                            (String id, int price, String currency) {
                          if (!(_alliedController.selectedPackage.value ==
                              id)) {
                            _alliedController.selectedPackage.value = id;
                            _alliedController.selectedPackagePrice.value =
                                price;
                            _alliedController.selectedPackageDiscountedPrice
                                .value = e.discountedPrice ?? -1;
                            _alliedController.selectedPackageIndex =
                                widget.packageList!.indexOf(e);
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
