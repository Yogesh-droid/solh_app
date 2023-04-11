import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/getHelp/issue_and_specialization_filter_controller.dart';
import 'package:solh/controllers/getHelp/search_market_controller.dart';
import 'package:solh/model/doctor.dart';
import 'package:solh/model/get-help/counsellors_country_model..dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/gender-page/gender_field.dart';
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

  void initState() {
    print('Running init state of Consultant');
    super.initState();
    getResultByCountry();
    print(
        "defaultCountry2 " + searchMarketController.defaultCountry.toString());
    _doctorsScrollController = ScrollController();
    issueAndSpecializationFilterController
        .getIssueAndSpecializationFilter(widget.slug);
    issueAndSpecializationFilterController.selectedSpeciality(widget.slug);

    _doctorsScrollController.addListener(() async {
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
    });
  }

  late ScrollController _doctorsScrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF6F6F8),
        appBar: widget.enableAppbar && widget.enableAppbar != null
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
                            "${searchMarketController.issueModel.value.doctors!.length + searchMarketController.issueModel.value.provider!.length} ${widget.name == null ? "Consultants" : widget.name!.isEmpty ? "Consultants" : widget.name!}",
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
                                (context, index) => ConsultantsTile(
                                  id: searchMarketController.issueModel.value
                                          .doctors![index].sId ??
                                      '',
                                  name: searchMarketController.issueModel.value
                                          .doctors![index].name ??
                                      '',
                                  currency: searchMarketController.issueModel
                                          .value.doctors![index].feeCurrency ??
                                      '',
                                  feeAmount: searchMarketController.issueModel
                                          .value.doctors![index].fee_amount ??
                                      0,
                                  fee: searchMarketController
                                      .issueModel.value.doctors![index].fee,
                                  prefix: searchMarketController
                                      .issueModel.value.doctors![index].prefix,
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
                                  /* doctorModel: DoctorModel(
                                      specialization: searchMarketController
                                              .issueModel
                                              .value
                                              .doctors![index]
                                              .specialization ??
                                          '',
                                      organisation: searchMarketController
                                              .issueModel
                                              .value
                                              .doctors![index]
                                              .organisation ??
                                          '',
                                      name: searchMarketController.issueModel
                                              .value.doctors![index].name ??
                                          '',
                                      mobile: searchMarketController
                                              .issueModel
                                              .value
                                              .doctors![index]
                                              .contactNumber ??
                                          '',
                                      email:
                                          searchMarketController.issueModel.value.doctors![index].email ?? '',
                                      clinic: '',
                                      fee: searchMarketController.issueModel.value.doctors![index].fee ?? '',
                                      prefix: searchMarketController.issueModel.value.doctors![index].prefix,
                                      feeCurrency: searchMarketController.issueModel.value.doctors![index].feeCurrency ?? '',
                                      fee_amount: searchMarketController.issueModel.value.doctors![index].fee_amount ?? 0,
                                      id: searchMarketController.issueModel.value.doctors![index].sId ?? '',
                                      locality: searchMarketController.issueModel.value.doctors![index].addressLineOne ?? '',
                                      pincode: '',
                                      city: searchMarketController.issueModel.value.doctors![index].addressLineFour ?? '',
                                      bio: searchMarketController.issueModel.value.doctors![index].bio ?? '',
                                      abbrevations: '',
                                      profilePicture: searchMarketController.issueModel.value.doctors![index].profilePicture ?? ''), */
                                  onTap: () {
                                    //                     connectionController
                                    //       .getUserAnalytics(searchMarketController.issueModel.value.doctors![index]. ),
                                    //   print(widget._journalModel!.postedBy!.sId),
                                    //   AutoRouter.of(context).push(ConnectScreenRouter(
                                    //       uid: widget._journalModel!.postedBy!.uid ?? '',
                                    //       sId: widget._journalModel!.postedBy!.sId ?? '')),
                                    // },
                                  },
                                ),
                                childCount: searchMarketController
                                    .issueModel.value.doctors!.length,
                              ),
                            )
                          : SizedBox(),
                      searchMarketController.issueModel.value.provider != null
                          ? SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) => ConsultantsTile(
                                  currency: searchMarketController.issueModel
                                          .value.provider![index].feeCurrency ??
                                      '',
                                  feeAmount: searchMarketController.issueModel
                                      .value.provider![index].fee_amount,
                                  id: searchMarketController.issueModel.value
                                          .provider![index].sId ??
                                      '',
                                  name: searchMarketController.issueModel.value
                                          .provider![index].name ??
                                      '',
                                  prefix: searchMarketController
                                      .issueModel.value.provider![index].prefix,
                                  profilePic: searchMarketController
                                          .issueModel
                                          .value
                                          .provider![index]
                                          .profilePicture ??
                                      '',
                                  specialization: '',
                                  bio: searchMarketController.issueModel.value
                                          .provider![index].bio ??
                                      '',
                                  fee: searchMarketController
                                      .issueModel.value.provider![index].fee,

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
                    ? LinearProgressIndicator()
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
                                      'Filter counsellors'.tr,
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
                                    /*  DropdownButton<String>(
                                        underline: Container(),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: SolhColors.primary_green,
                                        ),
                                        items: getHelpController
                                            .counsellorsCountryModel
                                            .value
                                            .providerCountry!
                                            .map(
                                                (e) => DropdownMenuItem<String>(
                                                      child: Text(e.name!),
                                                      value: e.code,
                                                    ))
                                            .toList(),
                                        onChanged: (value) {
                                          issueAndSpecializationFilterController
                                              .selectedCountry.value = value!;
                                        }), */
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
                                                                .selectedIssue
                                                                .value ==
                                                            e.name!,
                                                    onSelected: (value) {
                                                      issueAndSpecializationFilterController
                                                          .selectedIssue
                                                          .value = e.name!;
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
                                                                          .selectedIssue
                                                                          .value ==
                                                                      e.name!
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
                                      onTap: () =>
                                          issueAndSpecializationFilterController
                                                  .selectedSpeciality.value =
                                              issueAndSpecializationFilterController
                                                  .issueAndSpecializationFilterModel
                                                  .value
                                                  .splList![index]
                                                  .name!,
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
                                                          .selectedSpeciality
                                                          .value ==
                                                      issueAndSpecializationFilterController
                                                          .issueAndSpecializationFilterModel
                                                          .value
                                                          .splList![index]
                                                          .name
                                                  ? Icon(
                                                      CupertinoIcons
                                                          .check_mark_circled_solid,
                                                      color: SolhColors
                                                          .primary_green,
                                                    )
                                                  : Container(),
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

                              // ListView.builder(
                              //     physics: NeverScrollableScrollPhysics(),
                              //     shrinkWrap: true,
                              //     itemCount: getHelpController
                              //         .counsellorsCountryModel
                              //         .value
                              //         .providerCountry!
                              //         .length,
                              //     itemBuilder: (context, index) => Obx(() {
                              //           return ListTile(
                              //             title: Row(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceBetween,
                              //               children: [
                              //                 Expanded(
                              //                   child: Text(
                              //                     getHelpController
                              //                             .counsellorsCountryModel
                              //                             .value
                              //                             .providerCountry![
                              //                                 index]
                              //                             .name ??
                              //                         '',
                              //                     style: SolhTextStyles
                              //                         .QS_cap_semi,
                              //                     overflow:
                              //                         TextOverflow.ellipsis,
                              //                   ),
                              //                 ),
                              //                 getHelpController
                              //                             .counsellorsCountryModel
                              //                             .value
                              //                             .providerCountry![
                              //                                 index]
                              //                             .code !=
                              //                         issueAndSpecializationFilterController
                              //                             .selectedCountry.value
                              //                     ? Container()
                              //                     : Icon(
                              //                         CupertinoIcons
                              //                             .check_mark_circled_solid,
                              //                         color: SolhColors
                              //                             .primary_green,
                              //                       ),
                              //               ],
                              //             ),
                              //             onTap: () {
                              //               // searchMarketController
                              //               //         .defaultCountry =
                              //               //     getHelpController
                              //               //             .counsellorsCountryModel
                              //               //             .value
                              //               //             .providerCountry![index]
                              //               //             .code ??
                              //               //         '';

                              //               issueAndSpecializationFilterController
                              //                   .selectedCountry
                              //                   .value = getHelpController
                              //                       .counsellorsCountryModel
                              //                       .value
                              //                       .providerCountry![index]
                              //                       .code ??
                              //                   '';
                              //               // setState(() {});
                              //             },
                              //           );
                              //         }))
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
                                  .selectedIssue.value = '';
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
                                          .selectedSpeciality.value,
                                      c: issueAndSpecializationFilterController
                                          .selectedCountry.value,
                                      issue:
                                          issueAndSpecializationFilterController
                                              .selectedIssue.value)
                                  : widget.type == 'topconsultant'
                                      ? searchMarketController.getTopConsultants(
                                          issue:
                                              issueAndSpecializationFilterController
                                                  .selectedIssue.value,
                                          c: searchMarketController
                                              .defaultCountry)
                                      : searchMarketController.getIssueList(
                                          issueAndSpecializationFilterController
                                              .selectedSpeciality.value,
                                          issue:
                                              issueAndSpecializationFilterController
                                                  .selectedIssue.value,
                                          c: issueAndSpecializationFilterController
                                              .selectedCountry.value,
                                        );
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
    print("defaultCountry " + searchMarketController.defaultCountry.toString());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    issueAndSpecializationFilterController.selectedCountry.value =
        await sharedPreferences.getString('userCountry')!;
    searchMarketController.defaultCountry =
        searchMarketController.defaultCountry == null ||
                searchMarketController.defaultCountry == ''
            ? sharedPreferences.getString('userCountry')
            : searchMarketController.defaultCountry;
    print('@' * 30 +
        'default country is ${searchMarketController.defaultCountry}' +
        ' &' * 30);
    widget.type == 'specialization'
        ? searchMarketController.getSpecializationList(widget.slug,
            c: searchMarketController.defaultCountry)
        : widget.type == 'topconsultant'
            ? searchMarketController.getTopConsultants(
                c: searchMarketController.defaultCountry)
            : searchMarketController.getIssueList(widget.slug,
                c: searchMarketController.defaultCountry);
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
