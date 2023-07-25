import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/getHelp/search_market_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/image_container.dart';
import 'package:solh/widgets_constants/solh_video_player.dart';
import '../../../../widgets_constants/appbars/app-bar.dart';
import '../../comment/comment-screen.dart';

class AlliedConsultant extends StatefulWidget {
  AlliedConsultant({Key? key, Map<dynamic, dynamic>? args})
      : type = args!['type'],
        slug = args['slug'],
        name = args['name'],
        enableAppbar = args['enableAppbar'] ?? true,
        super(key: key);

  final String? slug;
  final String? type;
  final String? name;
  final bool enableAppbar;

  @override
  State<AlliedConsultant> createState() => _AlliedConsultantState();
}

class _AlliedConsultantState extends State<AlliedConsultant> {
  String? defaultCountry;
  SearchMarketController searchMarketController = Get.find();
  int pageNo = 1;
  late ScrollController _alliedScrollController;
  @override
  void initState() {
    _alliedScrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getResultByCountry();
    });

    fetchMoreAlliedConsultant();
    super.initState();
  }

  void fetchMoreAlliedConsultant() {
    _alliedScrollController.addListener(() {
      if (_alliedScrollController.position.pixels >
              _alliedScrollController.position.maxScrollExtent - 100 &&
          searchMarketController.issueModel.value.pagesForAllied!.next !=
              null &&
          searchMarketController.isLoading.value == false) {
        pageNo++;
        searchMarketController.getIssueList(widget.slug!,
            c: searchMarketController.defaultCountry, page: pageNo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F8),
      appBar: widget.enableAppbar
          ? SolhAppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name == null
                        ? "Consultants"
                        : widget.name!.isEmpty
                            ? "Consultants"
                            : widget.name!,
                    style: SolhTextStyles.QS_body_1_bold,
                  ),
                  Obx(() => searchMarketController.issueModel.value.doctors !=
                              null &&
                          searchMarketController.issueModel.value.provider !=
                              null
                      ? searchMarketController
                                  .issueModel.value.alliedProviders !=
                              null
                          ? Text(
                              "${searchMarketController.issueModel.value.totalAllied} ${widget.name}",
                              style: SolhTextStyles.QS_cap_2_semi.copyWith(
                                  color: SolhColors.Grey_1),
                            )
                          : const SizedBox()
                      : SizedBox())
                ],
              ),
              isLandingScreen: false,
            )
          : null,
      body: Obx(() => searchMarketController.isSearchingDoctors.value
          ? getShimmer(context)
          : searchMarketController.issueModel.value.alliedProviders != null
              ? CustomScrollView(
                  controller: _alliedScrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    if (searchMarketController
                        .issueModel.value.alliedProviders!.isEmpty)
                      SliverToBoxAdapter(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('No results found'),
                        ),
                      ),
                    // searchMarketController.issueModel.value.doctors != null
                    //     ? SliverList(
                    //         delegate: SliverChildBuilderDelegate(
                    //           (context, index) => AlliedConsultantTile(provider: ),
                    //           childCount: searchMarketController
                    //               .issueModel.value.doctors!.length,
                    //         ),
                    //       )
                    //     : SizedBox(),
                    searchMarketController.issueModel.value.provider != null
                        ? SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => AlliedConsultantTile(
                                feeCurrency: searchMarketController
                                        .issueModel
                                        .value
                                        .alliedProviders![index]
                                        .feeCurrency ??
                                    '',
                                afterDiscoutedPrice: searchMarketController
                                    .issueModel
                                    .value
                                    .alliedProviders![index]
                                    .afterDiscountPrice,
                                experience: searchMarketController.issueModel
                                    .value.alliedProviders![index].experience
                                    .toString(),
                                feeAmount: searchMarketController
                                        .issueModel
                                        .value
                                        .alliedProviders![index]
                                        .fee_amount ??
                                    0,
                                id: searchMarketController.issueModel.value
                                        .alliedProviders![index].sId ??
                                    '',
                                name: searchMarketController.issueModel.value
                                    .alliedProviders![index].name,
                                prefix: searchMarketController.issueModel.value
                                    .alliedProviders![index].prefix,
                                profession: searchMarketController.issueModel
                                    .value.alliedProviders![index].profession,
                                profilePic: searchMarketController
                                    .issueModel
                                    .value
                                    .alliedProviders![index]
                                    .profilePicture,
                                preview: searchMarketController.issueModel.value
                                    .alliedProviders![index].preview,
                              ),
                              childCount: searchMarketController
                                  .issueModel.value.alliedProviders!.length,
                            ),
                          )
                        : SliverToBoxAdapter(),
                  ],
                )
              : Container(
                  child: Center(child: Text('No Result Found')),
                )),
    );
  }

  Future<void> getResultByCountry() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    defaultCountry = sharedPreferences.getString('userCountry');
    widget.type == 'specialization'
        ? searchMarketController.getSpecializationList(widget.slug ?? '',
            c: defaultCountry, page: pageNo)
        : widget.type == 'topconsultant'
            ? searchMarketController.getTopConsultants(c: defaultCountry)
            : searchMarketController.getIssueList(widget.slug ?? '',
                page: 1, c: defaultCountry);
  }
}

class AlliedConsultantTile extends StatelessWidget {
  AlliedConsultantTile(
      {super.key,
      required this.profilePic,
      required this.prefix,
      required this.name,
      required this.profession,
      required this.experience,
      required this.feeAmount,
      required this.id,
      required this.preview,
      required this.feeCurrency,
      this.afterDiscoutedPrice});

  final String? profilePic;
  final String id;
  final String? prefix;
  final String? name;
  final String? profession;
  final String experience;
  final int feeAmount;
  final int? afterDiscoutedPrice;
  final String? preview;
  final String feeCurrency;

  final SearchMarketController _searchMarketController = Get.find();
  final ProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, AppRoutes.alliedConsultantScreen,
                      arguments: {"id": id}),
                  child: Container(
                    height: 24.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Color.fromRGBO(217, 217, 217, 1)
                                .withOpacity(0.4))),
                    child: getProfileDetails(context: context),
                  ),
                ),
                // SvgPicture.asset('assets/images/demo.svg')
              ],
            ),
            GetHelpDivider(),
          ],
        ),
        Obx(() {
          return _searchMarketController.isLoadingMoreClinician.value &&
                  name ==
                      _searchMarketController
                          .issueModel.value.alliedProviders!.last.name
              ? ButtonLoadingAnimation()
              : Container();
        })
      ],
    );
  }

  getProfileDetails({
    context,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 4),
      child: Column(
        children: [
          SizedBox(
            height: 1.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getProfileImg(profilePic ?? '', preview, context),
              SizedBox(width: 3.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: prefix != null ? "$prefix " : '',
                        style: Theme.of(context).textTheme.displaySmall),
                    TextSpan(
                        text: "$name",
                        style: Theme.of(context).textTheme.displaySmall)
                  ])),
                  Row(
                    children: [
                      Text(
                        profession ?? '',
                        style: SolhTextStyles.QS_cap_semi,
                      ),
                      Row(
                        children: [
                          SolhDot(),
                          Text(
                            ' ${experience} years ',
                            style: SolhTextStyles.QS_cap_semi,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  getInteractionDetailsAllied()
                ],
              ),
              Spacer(),
              if (afterDiscoutedPrice != null && afterDiscoutedPrice! > 0)
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset("assets/images/get_help/offer_bg.png",
                        height: 50, width: 50, fit: BoxFit.fill),
                    Text(
                      "${(((feeAmount - afterDiscoutedPrice!) / feeAmount) * 100).toInt()} % \noff",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                      textAlign: TextAlign.center,
                    )
                  ],
                )
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 13.w,
              width: 30.w,
              decoration: BoxDecoration(
                color: SolhColors.blue_light,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'Starting @'.tr,
                        style: SolhTextStyles.QS_cap_semi,
                      ),
                      // Text(feeCurrency + " " + feeAmount.toString(),
                      //     style: SolhTextStyles.QS_cap_semi),
                      Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              profileController.myProfileModel.value.body!
                                          .userOrganisations!.isNotEmpty &&
                                      profileController
                                              .myProfileModel
                                              .value
                                              .body!
                                              .userOrganisations!
                                              .first
                                              .status ==
                                          'Approved' &&
                                      afterDiscoutedPrice != null &&
                                      afterDiscoutedPrice! > 0
                                  ? Row(
                                      children: [
                                        Text(
                                            '${feeCurrency} ${afterDiscoutedPrice}',
                                            style: SolhTextStyles.QS_cap_semi),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                            feeCurrency +
                                                " " +
                                                feeAmount.toString(),
                                            style: SolhTextStyles.QS_cap_semi
                                                .copyWith(
                                                    decoration: TextDecoration
                                                        .lineThrough)),
                                      ],
                                    )
                                  : Text(
                                      feeCurrency + " " + feeAmount.toString(),
                                      style: SolhTextStyles.QS_cap_semi),
                            ],
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getProfileImg(String? profilePicture, previewUrl, context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SimpleImageContainer(
              zoomEnabled: true,
              enableborder: true,
              enableGradientBorder: true,
              boxFit: BoxFit.cover,
              radius: 100,
              imageUrl: profilePicture!.isNotEmpty
                  ? profilePicture
                  : "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y"),
        ),
        preview != null
            ? preview!.isNotEmpty
                ? Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: ((context) {
                                  return PreViewVideo(
                                    videoUrl: previewUrl,
                                  );
                                }));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                                color: SolhColors.light_Bg_2,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    color: Colors.black26,
                                  )
                                ]),
                            child: Center(
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.play_rectangle,
                                    size: 12,
                                    color: SolhColors.primaryRed,
                                  ),
                                  Text(
                                    ' Preview',
                                    style: SolhTextStyles.QS_cap_2_semi,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox()
            : const SizedBox()
      ],
    );
  }

  Widget getInteractionDetailsAllied() {
    return Row(
      children: [
        Row(
          children: [
            Icon(
              Icons.star_half,
              color: SolhColors.primary_green,
              size: 15,
            ),
            SizedBox(
              width: 5,
            ),
            Text('0',
                style: SolhTextStyles.QS_cap_semi.copyWith(
                    color: SolhColors.dark_grey))
          ],
        ),
        SizedBox(width: 3.w),
        Row(
          children: [
            Icon(
              CupertinoIcons.rectangle_stack_person_crop,
              size: 12,
              color: SolhColors.primary_green,
            ),
            SizedBox(
              width: 5,
            ),
            Text('0',
                style: SolhTextStyles.QS_cap_semi.copyWith(
                  color: SolhColors.dark_grey,
                )),
          ],
        ),
      ],
    );
  }
}

class SolhDot extends StatelessWidget {
  const SolhDot({super.key, this.color, this.size = 5});
  final Color? color;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: color ?? SolhColors.primary_green),
    );
  }
}

class PreViewVideo extends StatelessWidget {
  const PreViewVideo({super.key, required this.videoUrl});

  final videoUrl;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        insetPadding: EdgeInsets.all(0),
        content: SolhVideoPlayer(
          videoUrl: videoUrl,
        ));
  }
}
