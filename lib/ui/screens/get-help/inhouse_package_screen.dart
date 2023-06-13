import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/getHelp/allied_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/model/get-help/inhouse_package_model.dart';
import 'package:solh/model/get-help/packages_list_response_model.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/comment/comment-screen.dart';
import 'package:solh/ui/screens/get-help/inhouse_package_continue_details.dart';
import 'package:solh/ui/screens/profile-setup/email.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/text_field_styles.dart';
import '../../../widgets_constants/appbars/app-bar.dart';

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
        print('id ${widget.args["id"]}');
        _alliedController.selectedPackage.value = '';
        _alliedController.selectedPackagePrice.value = -1;
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
                        user: _alliedController
                            .inhousePackageModel.value.carousel),
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
                              ? "₹ ${_alliedController.selectedPackagePrice.toString()}"
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
                    // SolhGreenBorderButton(
                    //     width: 80,
                    //     height: 40,
                    //     child: SvgPicture.asset("assets/images/query.svg")),
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
                        print(_emailFocusNode.hasFocus);
                        if (!_emailFocusNode.hasFocus) {
                          _emailFocusNode.requestFocus();
                        }
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
                                              controller: _emailTextcontroller
                                                ..text = Get.find<
                                                            ProfileController>()
                                                        .myProfileModel
                                                        .value
                                                        .body!
                                                        .user!
                                                        .email ??
                                                    "",
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
                                              child: Text(
                                                "Continue".tr,
                                                style: SolhTextStyles.CTA
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                              onPressed: () {
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
                                                    Navigator.push(
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
                                                    );
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
  AboutAndPlans({super.key, this.user, this.packageList});
  final Carousel? user;
  final List<PackageList>? packageList;

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
    });
    // TODO: implement initState
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
                Text(
                  widget.user!.name ?? '',
                  style: SolhTextStyles.QS_big_body,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.user!.description ?? '',
                  style: SolhTextStyles.QS_body_2,
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
                        onPackageSelect: (String id, int price) {
                          if (!(_alliedController.selectedPackage.value ==
                              id)) {
                            _alliedController.selectedPackage.value = id;
                            _alliedController.selectedPackagePrice.value =
                                price;
                            _alliedController.selectedPackageIndex =
                                widget.packageList!.indexOf(e);
                          } else {
                            _alliedController.selectedPackage.value = "";
                            _alliedController.selectedPackagePrice.value = -1;
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
  final PackageList? package;
  final Function(String, int) onPackageSelect;
  final AlliedController _alliedController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPackageSelect(package!.sId ?? '', package!.amount ?? 0),
      child: Obx(() => AnimatedSize(
            duration: Duration(milliseconds: 500),
            curve: Curves.linear,
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: SolhColors.light_Bg_2,
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
                          Align(
                            alignment: Alignment.topRight,
                            child: SolhGreenButton(
                              height: 40,
                              width: 70,
                              child: AnimatedSwitcher(
                                duration: Duration(seconds: 5),
                                child:
                                    _alliedController.selectedPackage.value ==
                                            package!.sId
                                        ? Text(
                                            'Hide'.tr,
                                            style: SolhTextStyles.CTA
                                                .copyWith(color: Colors.white),
                                          )
                                        : Text(
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
      children: [
        Container(
            width: 70.w,
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "₹ ${package!.amount ?? 0}",
                style: SolhTextStyles.QS_body_1_bold.copyWith(
                    color: SolhColors.primary_green),
              ),
              Text(
                'Tax Incl.',
                style: SolhTextStyles.QS_cap_2_semi.copyWith(
                    color: SolhColors.Grey_1),
              )
            ],
          ),
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

  Widget expandedPanle(PackageList? package) {
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
                      // package.videoSessions!.isNotEmpty
                      //     ? Text('Video Package Includes',
                      //         style: SolhTextStyles.QS_body_2_bold)
                      //     : const SizedBox(),
                      // SizedBox(height: 20),
                      // package.videoSessions!.isNotEmpty
                      //     ? Column(
                      //         children: package.videoSessions!
                      //             .map((e) => videoPackageTile(e))
                      //             .toList())
                      //     : const SizedBox()
                    ]),
              )
            : SizedBox(
                width: double.infinity,
              ));
  }

  // Widget videoPackageTile(VideoSessions e) {
  //   return ExpansionTile(
  //     title: Row(
  //       children: [
  //         Text(
  //           "Session",
  //           style:
  //               SolhTextStyles.QS_cap_2_semi.copyWith(color: SolhColors.Grey_1),
  //         ),
  //         SizedBox(
  //           width: 10.w,
  //         ),
  //         Container(
  //           width: 50.w,
  //           child: Text(
  //             e.vName ?? '',
  //             style: SolhTextStyles.QS_cap_semi,
  //           ),
  //         )
  //       ],
  //     ),
  //     children: [
  //       Row(
  //         children: [
  //           SizedBox(
  //             width: 20.w,
  //           ),
  //           Container(
  //             width: 60.w,
  //             child: Text(
  //               e.vDescription ?? '',
  //               style: SolhTextStyles.QS_caption,
  //             ),
  //           ),
  //         ],
  //       )
  //     ],
  //     childrenPadding: EdgeInsets.all(10),
  //     iconColor: SolhColors.primary_green,
  //   );
  // }
}
