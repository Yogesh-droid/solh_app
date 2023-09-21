import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/getHelp/issue_and_specialization_filter_controller.dart';
import 'package:solh/controllers/getHelp/search_market_controller.dart';
import 'package:solh/model/get-help/counsellors_country_model..dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

import '../../../../controllers/connections/connection_controller.dart';
import '../../../../controllers/getHelp/get_help_controller.dart';
import '../consultant_tile.dart';

class ConsultantsScreen extends StatefulWidget {
  ConsultantsScreen({Key? key, Map<dynamic, dynamic>? args})
      : type = args!['type'],
        slug = args['slug'],
        name = args['name'],
        enableAppbar = args['enableAppbar'] ?? true,
        super(key: key);

  final String slug;
  final String? type;
  final String? name;
  final bool enableAppbar;
  @override
  State<ConsultantsScreen> createState() => _ConsultantsScreenState();
}

class _ConsultantsScreenState extends State<ConsultantsScreen>
    with KeepAliveParentDataMixin {
  bool _fetchingMore = false;
  SearchMarketController searchMarketController = Get.find();
  ConnectionController connectionController = Get.find();
  GetHelpController getHelpController = Get.find();
  IssueAndSpecializationFilterController
      issueAndSpecializationFilterController =
      Get.put(IssueAndSpecializationFilterController());

  int pageNo = 1;
  late ScrollController _doctorsScrollController;
  void initState() {
    _doctorsScrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        print('Running init state of Consultant');

        getResultByCountry();
        print("defaultCountry2 " +
            searchMarketController.defaultCountry.toString());

        issueAndSpecializationFilterController
            .getIssueAndSpecializationFilter(widget.slug);
        issueAndSpecializationFilterController.selectedSpeciality(widget.slug);
        fetchMoreClinician();
        _doctorsScrollController.addListener(
          () async {
            if (_doctorsScrollController.position.pixels ==
                    _doctorsScrollController.position.maxScrollExtent &&
                !_fetchingMore) {
              setState(() {
                _fetchingMore = true;
              });
              setState(() {
                _fetchingMore = false;
              });
            }
          },
        );
      },
    );
    super.initState();
  }

  void fetchMoreClinician() {
    _doctorsScrollController.addListener(() {
      if (_doctorsScrollController.position.pixels >
              _doctorsScrollController.position.maxScrollExtent - 100 &&
          searchMarketController.issueModel.value.pagesForProvider!.next !=
              null &&
          searchMarketController.isLoading.value == false) {
        pageNo++;
        searchMarketController.getIssueList(widget.slug,
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
                        ? Text(
                            "${searchMarketController.issueModel.value.totalProvider.toString()} Consultants ",
                            style: SolhTextStyles.QS_cap_2_semi.copyWith(
                                color: SolhColors.Grey_1),
                          )
                        : SizedBox())
                  ],
                ),
                isLandingScreen: false,
              )
            : null,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.filter_alt_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            openBottomSheet(context);
          },
          backgroundColor: SolhColors.pink224,
        ),
        body: Obx(() => searchMarketController.isSearchingDoctors.value
            ? getShimmer(context)
            : searchMarketController.issueModel.value.doctors != null ||
                    searchMarketController.issueModel.value.provider != null
                ? CustomScrollView(
                    controller: _doctorsScrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 10,
                        ),
                      ),
                      if (searchMarketController
                              .issueModel.value.doctors!.isEmpty &&
                          searchMarketController
                              .issueModel.value.provider!.isEmpty)
                        SliverToBoxAdapter(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('No results found'),
                          ),
                        ),
                      searchMarketController.issueModel.value.doctors != null
                          ? SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ConsultantsTile(
                                      id: searchMarketController.issueModel
                                              .value.doctors![index].sId ??
                                          '',
                                      name: searchMarketController.issueModel
                                              .value.doctors![index].name ??
                                          '',
                                      currency: searchMarketController
                                              .issueModel
                                              .value
                                              .doctors![index]
                                              .feeCurrency ??
                                          '',
                                      discountedPrice: searchMarketController
                                          .issueModel
                                          .value
                                          .doctors![index]
                                          .afterDiscountPrice,
                                      feeAmount: searchMarketController
                                              .issueModel
                                              .value
                                              .doctors![index]
                                              .fee_amount ??
                                          0,
                                      fee: searchMarketController
                                          .issueModel.value.doctors![index].fee,
                                      prefix: searchMarketController.issueModel
                                          .value.doctors![index].prefix,
                                      profilePic: searchMarketController
                                              .issueModel
                                              .value
                                              .doctors![index]
                                              .profilePicture ??
                                          '',
                                      specialization: searchMarketController
                                              .issueModel
                                              .value
                                              .doctors![index]
                                              .specialization ??
                                          '',
                                      bio: searchMarketController
                                          .issueModel.value.doctors![index].bio,
                                      onTap: () {},
                                    ),
                                    Obx(
                                      () {
                                        return searchMarketController
                                                .isLoadingMoreClinician.value
                                            ? ButtonLoadingAnimation()
                                            : Container();
                                      },
                                    )
                                  ],
                                ),
                                childCount: searchMarketController
                                    .issueModel.value.doctors!.length,
                              ),
                            )
                          : SizedBox(),
                      searchMarketController.issueModel.value.provider != null
                          ? SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) => Column(
                                  children: [
                                    ConsultantsTile(
                                      currency: searchMarketController
                                              .issueModel
                                              .value
                                              .provider![index]
                                              .feeCurrency ??
                                          '',
                                      feeAmount: searchMarketController
                                          .issueModel
                                          .value
                                          .provider![index]
                                          .fee_amount,
                                      id: searchMarketController.issueModel
                                              .value.provider![index].sId ??
                                          '',
                                      name: searchMarketController.issueModel
                                              .value.provider![index].name ??
                                          '',
                                      prefix: searchMarketController.issueModel
                                          .value.provider![index].prefix,
                                      profilePic: searchMarketController
                                              .issueModel
                                              .value
                                              .provider![index]
                                              .profilePicture ??
                                          '',
                                      specialization: '',
                                      bio: searchMarketController.issueModel
                                              .value.provider![index].bio ??
                                          '',
                                      fee: searchMarketController.issueModel
                                          .value.provider![index].fee,
                                      discountedPrice: searchMarketController
                                          .issueModel
                                          .value
                                          .provider![index]
                                          .afterDiscountPrice,

                                      /*  doctorModel: DoctorModel(
                                          specialization: '',
                                          organisation: '',
                                          name: searchMarketController.issueModel
                                                  .value.provider![index].name ??
                                              '',
                                          mobile: searchMarketController
                                                  .issueModel
                                                  .value
                                                  .provider![index]
                                                  .contactNumber ??
                                              '',
                                          id: searchMarketController.issueModel
                                                  .value.provider![index].sId ??
                                              '',
                                          email: searchMarketController.issueModel
                                                  .value.provider![index].email ??
                                              '',
                                          clinic: '',
                                          fee: searchMarketController.issueModel.value.provider![index].fee,
                                          prefix: searchMarketController.issueModel.value.provider![index].prefix,
                                          feeCurrency: searchMarketController.issueModel.value.provider![index].feeCurrency,
                                          fee_amount: searchMarketController.issueModel.value.provider![index].fee_amount,
                                          locality: searchMarketController.issueModel.value.provider![index].addressLineOne ?? '',
                                          pincode: '',
                                          city: searchMarketController.issueModel.value.provider![index].addressLineFour ?? '',
                                          bio: searchMarketController.issueModel.value.provider![index].bio ?? '',
                                          abbrevations: '',
                                          profilePicture: searchMarketController.issueModel.value.provider![index].profilePicture ?? ''), */
                                      onTap: () {},
                                    ),
                                    Obx(
                                      () {
                                        return searchMarketController
                                                    .isLoadingMoreClinician
                                                    .value &&
                                                index ==
                                                    searchMarketController
                                                            .issueModel
                                                            .value
                                                            .provider!
                                                            .length -
                                                        1
                                            ? ButtonLoadingAnimation()
                                            : Container();
                                      },
                                    )
                                  ],
                                ),
                                childCount: searchMarketController
                                    .issueModel.value.provider!.length,
                              ),
                            )
                          : SliverToBoxAdapter(),
                    ],
                  )
                : Center(
                    child: MyLoader(),
                  )));
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: 85.h),
      context: context,
      builder: ((context) => Stack(
            children: [
              Obx(
                () => getHelpController.isCountryLoading.value
                    ? LinearProgressIndicator(
                        color: SolhColors.primary_green,
                        backgroundColor:
                            SolhColors.primary_green.withOpacity(0.3),
                      )
                    : Container(
                        height: 100.h,
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Filter counselor'.tr,
                                      style:
                                          SolhTextStyles.JournalingUsernameText,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    icon: Icon(
                                      CupertinoIcons.clear_thick_circled,
                                      color: SolhColors.dark_grey,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Country'.tr,
                                      style:
                                          SolhTextStyles.JournalingUsernameText,
                                    ),
                                    Container(
                                      width: 180,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: SolhColors.primary_green),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Stack(
                                        children: [
                                          Obx(() {
                                            return Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: Text(
                                                  getCountryFromCode(
                                                      getHelpController
                                                          .counsellorsCountryModel
                                                          .value,
                                                      issueAndSpecializationFilterController
                                                          .selectedCountry
                                                          .value),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: SolhTextStyles
                                                      .QS_body_2_bold,
                                                ),
                                              ),
                                            );
                                          }),
                                          Positioned(
                                              right: 10,
                                              top: 0,
                                              bottom: 0,
                                              child: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color: SolhColors.primary_green,
                                              )),
                                          Container(
                                            child: DropdownButton<String>(
                                                underline: Container(),
                                                icon: Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color:
                                                      SolhColors.primary_green,
                                                ),
                                                items: getHelpController
                                                    .counsellorsCountryModel
                                                    .value
                                                    .providerCountry!
                                                    .map((e) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          child: Text(e.name!),
                                                          value: e.code,
                                                        ))
                                                    .toList(),
                                                onChanged: (value) {
                                                  issueAndSpecializationFilterController
                                                      .selectedCountry
                                                      .value = value!;
                                                }),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Issues'.tr,
                                  style: SolhTextStyles.JournalingUsernameText,
                                ),
                              ),
                              Obx(() {
                                return issueAndSpecializationFilterController
                                        .isFiltersLoading.value
                                    ? CircularProgressIndicator()
                                    : Obx(() {
                                        return Wrap(
                                            spacing: 5,
                                            children: issueAndSpecializationFilterController
                                                .issueAndSpecializationFilterModel
                                                .value
                                                .issueList!
                                                .map((e) => FilterChip(
                                                    checkmarkColor:
                                                        SolhColors.white,
                                                    selected:
                                                        issueAndSpecializationFilterController
                                                            .selectedIssueList
                                                            .contains(e.name),
                                                    onSelected: (value) {
                                                      issueAndSpecializationFilterController
                                                              .selectedIssueList
                                                              .contains(e.name)
                                                          ? issueAndSpecializationFilterController
                                                              .selectedIssueList
                                                              .remove(e.name)
                                                          : issueAndSpecializationFilterController
                                                              .selectedIssueList
                                                              .add(e.name);
                                                    },
                                                    selectedColor: SolhColors
                                                        .primary_green,
                                                    backgroundColor:
                                                        SolhColors.grey239,
                                                    label: Text(
                                                      e.name!,
                                                      style: SolhTextStyles
                                                              .QS_cap_semi
                                                          .copyWith(
                                                              color: issueAndSpecializationFilterController
                                                                      .selectedIssueList
                                                                      .contains(e
                                                                          .name)
                                                                  ? SolhColors
                                                                      .white
                                                                  : SolhColors
                                                                      .dark_grey),
                                                    )))
                                                .toList());
                                      });
                              }),
                              SizedBox(
                                height: 28,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Speciality'.tr,
                                  style: SolhTextStyles.JournalingUsernameText,
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    issueAndSpecializationFilterController
                                        .issueAndSpecializationFilterModel
                                        .value
                                        .splList!
                                        .length,
                                itemBuilder: (context, index) {
                                  return Obx(() {
                                    return InkWell(
                                      onTap: () {
                                        issueAndSpecializationFilterController
                                                .selectedSpecialityList
                                                .contains(
                                                    issueAndSpecializationFilterController
                                                        .issueAndSpecializationFilterModel
                                                        .value
                                                        .splList![index]
                                                        .name!)
                                            ? issueAndSpecializationFilterController
                                                .selectedSpecialityList
                                                .remove(issueAndSpecializationFilterController
                                                    .issueAndSpecializationFilterModel
                                                    .value
                                                    .splList![index]
                                                    .name!)
                                            : issueAndSpecializationFilterController
                                                .selectedSpecialityList
                                                .add(issueAndSpecializationFilterController
                                                    .issueAndSpecializationFilterModel
                                                    .value
                                                    .splList![index]
                                                    .name!);
                                      },
                                      child: ListTile(
                                        title: InkWell(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                issueAndSpecializationFilterController
                                                    .issueAndSpecializationFilterModel
                                                    .value
                                                    .splList![index]
                                                    .name
                                                    .toString(),
                                                style:
                                                    SolhTextStyles.QS_cap_semi,
                                              ),
                                              issueAndSpecializationFilterController
                                                      .selectedSpecialityList
                                                      .contains(
                                                          issueAndSpecializationFilterController
                                                              .issueAndSpecializationFilterModel
                                                              .value
                                                              .splList![index]
                                                              .name)
                                                  ? Icon(
                                                      CupertinoIcons
                                                          .check_mark_circled_solid,
                                                      color: SolhColors
                                                          .primary_green,
                                                    )
                                                  : const SizedBox.shrink(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                },
                              ),
                              SizedBox(
                                height: 28,
                              ),
                              SizedBox(
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                    decoration:
                        BoxDecoration(color: SolhColors.white, boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 2,
                          color: Colors.black12),
                    ]),
                    width: 100.w,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SolhGreenBorderMiniButton(
                            onPressed: () {
                              issueAndSpecializationFilterController
                                  .selectedIssueList
                                  .clear();
                              issueAndSpecializationFilterController
                                  .selectedSpeciality.value = widget.slug;
                              getResultByCountry();
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Clear all',
                              style: SolhTextStyles.CTA
                                  .copyWith(color: SolhColors.primary_green),
                            ),
                          ),
                          SolhGreenMiniButton(
                            onPressed: () {
                              widget.type == 'specialization'
                                  ? searchMarketController.getSpecializationList(
                                      issueAndSpecializationFilterController
                                          .selectedSpecialityList
                                          .join("|"),
                                      c: issueAndSpecializationFilterController
                                          .selectedCountry.value,
                                      issue: issueAndSpecializationFilterController
                                          .selectedIssueList
                                          .join("|"))
                                  : widget.type == 'topconsultant'
                                      ? searchMarketController.getTopConsultants(
                                          issue: issueAndSpecializationFilterController
                                              .selectedIssueList
                                              .join("|"),
                                          c: searchMarketController
                                              .defaultCountry)
                                      : searchMarketController.getIssueList(
                                          issueAndSpecializationFilterController.selectedSpecialityList.join("|"),
                                          issue: issueAndSpecializationFilterController.selectedIssueList.join("|"),
                                          c: issueAndSpecializationFilterController.selectedCountry.value,
                                          page: 1);
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Apply',
                              style: SolhTextStyles.CTA
                                  .copyWith(color: SolhColors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ],
          )),
    );
  }

  String getCountryFromCode(
      CounsellorsCountryModel counsellorsCountryModel, selectedCountryCode) {
    String selectedCountry = '';
    counsellorsCountryModel.providerCountry!.forEach((element) {
      if (element.code == selectedCountryCode) {
        selectedCountry = element.name!;
      }
    });
    return selectedCountry;
  }

  Future<void> getResultByCountry() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    issueAndSpecializationFilterController.selectedCountry.value =
        await sharedPreferences.getString('userCountry') ?? '';
    searchMarketController.defaultCountry =
        searchMarketController.defaultCountry == null ||
                searchMarketController.defaultCountry == ''
            ? sharedPreferences.getString('userCountry')
            : searchMarketController.defaultCountry;
    widget.type == 'specialization'
        ? searchMarketController.getSpecializationList(
            widget.slug,
            c: searchMarketController.defaultCountry,
          )
        : widget.type == 'topconsultant'
            ? searchMarketController.getTopConsultants(
                c: searchMarketController.defaultCountry)
            : searchMarketController.getIssueList(widget.slug,
                c: searchMarketController.defaultCountry, page: 1);
  }

  @override
  void detach() {
    // TODO: implement detach
  }

  @override
  // TODO: implement keptAlive
  bool get keptAlive => true;
}

getShimmer(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
