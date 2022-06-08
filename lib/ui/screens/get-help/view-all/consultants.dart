import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/doctors-bloc.dart';
import 'package:solh/controllers/getHelp/search_market_controller.dart';
import 'package:solh/model/doctor.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import '../../../../controllers/connections/connection_controller.dart';
import '../consultant_tile.dart';

class ConsultantsScreen extends StatefulWidget {
  ConsultantsScreen(
      {Key? key, int? page, int? count, required this.slug, this.type})
      : _page = page,
        _count = count,
        super(key: key);

  int? _page;
  int? _count;
  final String slug;
  final String? type;
  @override
  State<ConsultantsScreen> createState() => _ConsultantsScreenState();
}

class _ConsultantsScreenState extends State<ConsultantsScreen> {
  bool _fetchingMore = false;
  SearchMarketController searchMarketController = Get.find();
  ConnectionController connectionController = Get.find();

  void initState() {
    super.initState();
    _doctorsScrollController = ScrollController();
    _refreshController = RefreshController();
    //doctorsBlocNetwork.getDoctorsSnapshot(widget._page);
    widget.type == 'specialization'
        ? searchMarketController.getSpecializationList(widget.slug)
        : widget.type == 'topconsultant'
            ? searchMarketController.getTopConsultants()
            : searchMarketController.getIssueList(widget.slug);
    _doctorsScrollController.addListener(() async {
      if (_doctorsScrollController.position.pixels ==
              _doctorsScrollController.position.maxScrollExtent &&
          !_fetchingMore) {
        setState(() {
          _fetchingMore = true;
        });
        //await doctorsBlocNetwork.getNextPageDoctorsSnapshot();
        setState(() {
          _fetchingMore = false;
        });
      }
    });
  }

  void _onRefresh() async {
    await doctorsBlocNetwork.getDoctorsSnapshot(widget._page);
    _refreshController.refreshCompleted();
  }

  late ScrollController _doctorsScrollController;
  late RefreshController _refreshController;

  @override
  Widget build(BuildContext context) {
/*     return StreamBuilder<List<DoctorModel?>>(
        stream: doctorsBlocNetwork.doctorsStateStream,
        builder: (context, doctorsSnapshot) {
          if (doctorsSnapshot.hasData)
            return Scaffold(
                backgroundColor: Color(0xFFF6F6F8),
                appBar: SolhAppBar(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Consultants",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Text(
                        "${widget._count} Consultants",
                        style:
                            TextStyle(fontSize: 15, color: Color(0xFFA6A6A6)),
                      )
                    ],
                  ),
                  isLandingScreen: false,
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: Obx(() => ListView.separated(
                          separatorBuilder: ((context, index) => SizedBox(
                                height: 10,
                              )),
                          controller: _doctorsScrollController,
                          itemCount: searchMarketController
                              .issueModel.value.doctors!.length,
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          itemBuilder: (_, index) => ConsultantsTile(
                                doctorModel: DoctorModel(
                                    organisation: searchMarketController
                                            .issueModel
                                            .value
                                            .doctors![index]
                                            .organisation ??
                                        '',
                                    name: searchMarketController.issueModel.value.doctors![index].name ??
                                        '',
                                    mobile: searchMarketController
                                            .issueModel
                                            .value
                                            .doctors![index]
                                            .contactNumber ??
                                        '',
                                    email: searchMarketController.issueModel
                                            .value.doctors![index].email ??
                                        '',
                                    clinic: '',
                                    locality: searchMarketController
                                            .issueModel
                                            .value
                                            .doctors![index]
                                            .addressLineOne ??
                                        '',
                                    pincode: '',
                                    city: searchMarketController.issueModel.value.doctors![index].addressLineFour ?? '',
                                    bio: searchMarketController.issueModel.value.doctors![index].bio ?? '',
                                    abbrevations: ''),
                              ))),
                    ),
                    if (_fetchingMore)
                      Center(
                        child: MyLoader(),
                      )
                  ],
                ));
          return Scaffold(
            body: Center(child: MyLoader()),
          );
        }); */

    return Scaffold(
        backgroundColor: Color(0xFFF6F6F8),
        appBar: SolhAppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Consultants",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              Obx(() => searchMarketController.issueModel.value.doctors !=
                          null &&
                      searchMarketController.issueModel.value.provider != null
                  ? Text(
                      "${searchMarketController.issueModel.value.doctors!.length + searchMarketController.issueModel.value.provider!.length} Consultants",
                      style: TextStyle(fontSize: 15, color: Color(0xFFA6A6A6)),
                    )
                  : SizedBox())
            ],
          ),
          isLandingScreen: false,
        ),
        // body: CustomScrollView(
        // slivers: [
        //     Obx(() => ListView.separated(
        //         separatorBuilder: ((context, index) => SizedBox(
        //               height: 10,
        //             )),
        //         controller: _doctorsScrollController,
        //         shrinkWrap: true,
        //         itemCount:
        //             searchMarketController.issueModel.value.doctors!.length,
        //         padding: EdgeInsets.symmetric(vertical: 1.h),
        //         itemBuilder: (_, index) => ConsultantsTile(
        //               doctorModel: DoctorModel(
        //                   organisation: searchMarketController.issueModel.value
        //                           .doctors![index].organisation ??
        //                       '',
        //                   name:
        //                       searchMarketController.issueModel.value.doctors![index].name ??
        //                           '',
        //                   mobile: searchMarketController.issueModel.value
        //                           .doctors![index].contactNumber ??
        //                       '',
        //                   email: searchMarketController
        //                           .issueModel.value.doctors![index].email ??
        //                       '',
        //                   clinic: '',
        //                   locality: searchMarketController.issueModel.value
        //                           .doctors![index].addressLineOne ??
        //                       '',
        //                   pincode: '',
        //                   city: searchMarketController.issueModel.value.doctors![index].addressLineFour ?? '',
        //                   bio: searchMarketController.issueModel.value.doctors![index].bio ?? '',
        //                   abbrevations: ''),
        //             ))),
        //     Obx(() => ListView.separated(
        //         shrinkWrap: true,
        //         separatorBuilder: ((context, index) => SizedBox(
        //               height: 10,
        //             )),
        //         itemCount:
        //             searchMarketController.issueModel.value.provider!.length,
        //         padding: EdgeInsets.symmetric(vertical: 1.h),
        //         itemBuilder: (_, index) => ConsultantsTile(
        //               doctorModel: DoctorModel(
        //                   organisation: '',
        //                   name: searchMarketController
        //                           .issueModel.value.provider![index].name ??
        //                       '',
        //                   mobile: searchMarketController.issueModel.value
        //                           .provider![index].contactNumber ??
        //                       '',
        //                   email: searchMarketController
        //                           .issueModel.value.provider![index].email ??
        //                       '',
        //                   clinic: '',
        //                   locality: searchMarketController.issueModel.value
        //                           .provider![index].addressLineOne ??
        //                       '',
        //                   pincode: '',
        //                   city: searchMarketController.issueModel.value
        //                           .provider![index].addressLineFour ??
        //                       '',
        //                   bio: searchMarketController.issueModel.value.provider![index].bio ?? '',
        //                   abbrevations: ''),
        //             ))),
        //     if (_fetchingMore)
        //       Center(
        //         child: MyLoader(),
        //       )
        //   ],
        // )
        body: Obx(() => searchMarketController.issueModel.value.doctors !=
                    null ||
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
                      searchMarketController.issueModel.value.provider!.isEmpty)
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
                              doctorModel: DoctorModel(
                                  organisation: searchMarketController
                                          .issueModel
                                          .value
                                          .doctors![index]
                                          .organisation ??
                                      '',
                                  name: searchMarketController.issueModel.value
                                          .doctors![index].name ??
                                      '',
                                  mobile: searchMarketController
                                          .issueModel
                                          .value
                                          .doctors![index]
                                          .contactNumber ??
                                      '',
                                  email: searchMarketController.issueModel.value
                                          .doctors![index].email ??
                                      '',
                                  clinic: '',
                                  locality:
                                      searchMarketController.issueModel.value.doctors![index].addressLineOne ?? '',
                                  pincode: '',
                                  city: searchMarketController.issueModel.value.doctors![index].addressLineFour ?? '',
                                  bio: searchMarketController.issueModel.value.doctors![index].bio ?? '',
                                  abbrevations: '',
                                  profilePicture: searchMarketController.issueModel.value.doctors![index].profilePicture ?? ''),
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
                              doctorModel: DoctorModel(
                                  organisation: '',
                                  name: searchMarketController.issueModel.value.provider![index].name ??
                                      '',
                                  mobile: searchMarketController
                                          .issueModel
                                          .value
                                          .provider![index]
                                          .contactNumber ??
                                      '',
                                  email: searchMarketController.issueModel.value
                                          .provider![index].email ??
                                      '',
                                  clinic: '',
                                  locality: searchMarketController
                                          .issueModel
                                          .value
                                          .provider![index]
                                          .addressLineOne ??
                                      '',
                                  pincode: '',
                                  city: searchMarketController.issueModel.value
                                          .provider![index].addressLineFour ??
                                      '',
                                  bio: searchMarketController.issueModel.value.provider![index].bio ?? '',
                                  abbrevations: '',
                                  profilePicture: searchMarketController.issueModel.value.provider![index].profilePicture ?? ''),
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
}
