import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/controllers/getHelp/consultant_controller.dart';
import 'package:solh/controllers/getHelp/get_help_controller.dart';
import 'package:solh/controllers/getHelp/search_market_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/model/get-help/search_market_model.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/connect/connect_screen_controller/connect_screen_controller.dart';
import 'package:solh/ui/screens/get-help/consultant_profile_page.dart';
import 'package:solh/ui/screens/get-help/search_screen.dart';
import 'package:solh/ui/screens/home/home_controller.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/solh_search_field.dart';
import '../../../widgets_constants/buttons/custom_buttons.dart';
import '../../../widgets_constants/loader/my-loader.dart';
import '../doctor/appointment_page.dart';
import '../home/homescreen.dart';

class GetHelpScreen extends StatefulWidget {
  @override
  State<GetHelpScreen> createState() => _GetHelpScreenState();
}

class _GetHelpScreenState extends State<GetHelpScreen> {
  GetHelpController getHelpController = Get.find();

  SearchMarketController searchMarketController = Get.find();

  BookAppointmentController bookAppointmentController = Get.find();

  ConnectionController connectionController = Get.find();

  ProfileController profileController = Get.find();
  HomeController homeController = Get.find();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //getProfile();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return profileController.isProfileLoading.value
          ? Center(
              child: MyLoader(),
            )
          : profileController.myProfileModel.value.body == null
              ? getHelpPage(context)
              : profileController.myProfileModel.value.body!.user!.userType ==
                      'SolhProvider'
                  ? DoctorsAppointmentPage()
                  : getHelpPage(context);
    });
  }

  Widget getHelpPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SolhSearchField(
                hintText: 'Anxiety, Corporate Stress, Family Issues',
                icon: 'assets/icons/app-bar/search.svg',
                onTap: () {
                  searchMarketController.searchMarketModel.value =
                      SearchMarketModel();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(),
                    ),
                  );
                }),
          ),
          GetHelpDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GetHelpCategory(
              title: 'Search for support',
              trailing: InkWell(
                onTap: () {
                  getHelpController.isAllIssueShown.value
                      ? getHelpController.showLessIssues()
                      : getHelpController.showAllIssues();
                  getHelpController.isAllIssueShown.value =
                      !getHelpController.isAllIssueShown.value;
                },
                child: Padding(
                    padding: const EdgeInsets.only(
                        right: 11.0, bottom: 11, top: 11, left: 11),
                    child: Obx(() {
                      return Text(
                        !getHelpController.isAllIssueShown.value
                            ? "Show More"
                            : "Show less",
                        style: TextStyle(
                          fontSize: 16,
                          color: SolhColors.primary_green,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    })),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 1.5.h),
              child: Obx(() {
                return Wrap(
                  runSpacing: 5,
                  children: getHelpController.issueList.value.map((issue) {
                    return IssuesTile(
                      title: issue.name ?? '',
                      onPressed: () {
                        bookAppointmentController.query = issue.name;
                        Navigator.pushNamed(
                            context, AppRoutes.consultantAlliedParent,
                            arguments: {
                              "slug": issue.slug ?? '',
                              "type": 'issue',
                              "enableAppbar": false
                            });
                        FirebaseAnalytics.instance.logEvent(
                            name: 'IssueSearchTapped',
                            parameters: {'Page': 'GetHelp'});
                      },
                    );
                  }).toList(),
                );
              })),
          GetHelpDivider(),
          GetHelpCategory(
            title: "Search by Profession",
          ),
          Obx(() {
            return getHelpController
                        .getSpecializationModel.value.specializationList !=
                    null
                ? Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 2.5.w,
                          crossAxisSpacing: 2.5.w,
                          crossAxisCount: 2,
                          childAspectRatio: 2),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: getHelpController.getSpecializationModel.value
                          .specializationList!.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                          bookAppointmentController.query = getHelpController
                              .getSpecializationModel
                              .value
                              .specializationList![index]
                              .name;
                          Navigator.pushNamed(
                              context, AppRoutes.viewAllConsultant,
                              arguments: {
                                "slug": getHelpController
                                        .getSpecializationModel
                                        .value
                                        .specializationList![index]
                                        .slug ??
                                    '',
                                "type": 'specialization',
                                "name": getHelpController
                                        .getSpecializationModel
                                        .value
                                        .specializationList![index]
                                        .name ??
                                    ''
                              });
                          FirebaseAnalytics.instance.logEvent(
                              name: 'SearhSpecialityTapped',
                              parameters: {'Page': 'GetHelp'});
                        },
                        child: Container(
                          height: 1.h,
                          width: 10.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFEFEFEF)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                                child: CircleAvatar(
                                  radius: 8.w,
                                  child: CircleAvatar(
                                    radius: 7.8.w,
                                    backgroundColor: Colors.white,
                                    backgroundImage: CachedNetworkImageProvider(
                                        getHelpController
                                                .getSpecializationModel
                                                .value
                                                .specializationList![index]
                                                .displayImage ??
                                            ''),
                                    /* child: CachedNetworkImage(
                                      imageUrl: getHelpController
                                              .getSpecializationModel
                                              .value
                                              .specializationList![index]
                                              .displayImage ??
                                          '',
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                              child: Container(
                                                height: 1.h,
                                                width: 1.w,
                                                color: Colors.grey,
                                              ),
                                              baseColor: Colors.grey,
                                              highlightColor: Colors.white),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                        Icons.person,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                                    ), */
                                  ),
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Container(
                                width: 25.w,
                                child: Text(
                                  getHelpController.getSpecializationModel.value
                                          .specializationList![index].name ??
                                      '',
                                  style: SolhTextStyles.QS_cap_semi,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Container();
          }),
          GetHelpDivider(),
          Obx((() => getHelpController.isAlliedShown.value
              ? AlliedExperts(onTap: (value, name) {
                  Navigator.pushNamed(context, AppRoutes.viewAllAlliedExpert,
                      arguments: {
                        "slug": value,
                        "name": name,
                        "type": 'specialization',
                        "enableAppbar": true
                      });
                })
              : const SizedBox())),
          Obx(() => getHelpController.isAlliedShown.value
              ? GetHelpDivider()
              : const SizedBox()),
          Obx((() => homeController.isCorouselShown.value
              ? AlliedCarousel()
              : const SizedBox())),
          GetHelpDivider(),
          GetHelpCategory(
              title: "Leading Solh Experts",
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.consultantAlliedParent,
                    arguments: {
                      "slug": '',
                      "type": 'topconsultant',
                      "enableAppbar": false
                    });
                FirebaseAnalytics.instance.logEvent(
                    name: 'viewAllConsultanttapped',
                    parameters: {'Page': 'GetHelp'});
              }),
          Container(
            height: 35.h,
            margin: EdgeInsets.only(bottom: 2.h),
            child: Container(child: Obx(() {
              return getHelpController.topConsultantList.value.doctors != null
                  ? getHelpController.topConsultantList.value.doctors!.isEmpty
                      ? Center(
                          child:
                              Text('No Consultant available for your country'),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: getHelpController
                              .topConsultantList.value.doctors!.length,
                          itemBuilder: (_, index) {
                            debugPrint(getHelpController.topConsultantList.value
                                .doctors![index].profilePicture);
                            return TopConsultantsTile(
                              doctors: getHelpController
                                  .topConsultantList.value.doctors![index],
                              //   bio: getHelpController.topConsultantList.value
                              //           .doctors![index].bio ??
                              //       '',
                              //   name: getHelpController.topConsultantList.value
                              //           .doctors![index].name ??
                              //       '',
                              //   mobile: getHelpController.topConsultantList.value
                              //           .doctors![index].contactNumber ??
                              //       '',
                              //   imgUrl: getHelpController.topConsultantList.value
                              //       .doctors![index].profilePicture,
                              //   sId: getHelpController
                              //       .topConsultantList.value.doctors![index].sId,
                            );
                          })
                  : Container(
                      child: Center(
                      child: Text('No Doctors Found'),
                    ));
            })),
          ),
          /*  GetHelpDivider(),
          GetHelpCategory(
            title: "Solh Volunteer",
            // onPressed: () =>
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (_) => ConsultantsScreen(
            //               slug: '',
            //               type: 'topconsultant',
            //             ))),
          ),
          Container(
            height: 290,
            margin: EdgeInsets.only(bottom: 2.h),
            child: Container(child: Obx(() {
              return getHelpController.solhVolunteerList.value.provider != null
                  ? ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 2.h),
                      separatorBuilder: (_, __) => SizedBox(width: 2.w),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: getHelpController
                          .solhVolunteerList.value.provider!.length,
                      itemBuilder: (context, index) => SolhVolunteers(
                        bio: getHelpController
                                .solhVolunteerList.value.provider![index].bio ??
                            '',
                        post: getHelpController.solhVolunteerList.value
                                .provider![index].postCount ??
                            0,
                        isInSendRequest: checkIfAlreadyInSendConnection(
                          getHelpController.solhVolunteerList.value
                                  .provider![index].sId ??
                              '',
                        ),
                        name: getHelpController.solhVolunteerList.value
                                .provider![index].name ??
                            '',
                        mobile: getHelpController.solhVolunteerList.value
                                .provider![index].contactNumber ??
                            '',
                        imgUrl: getHelpController.solhVolunteerList.value
                            .provider![index].profilePicture,
                        sId: getHelpController
                            .solhVolunteerList.value.provider![index].sId,
                        uid: getHelpController
                            .solhVolunteerList.value.provider![index].uid,
                        comments: getHelpController.solhVolunteerList.value
                            .provider![index].commentCount
                            .toString(),
                        connections: getHelpController.solhVolunteerList.value
                            .provider![index].connectionsCount
                            .toString(),
                        likes: getHelpController
                            .solhVolunteerList.value.provider![index].likesCount
                            .toString(),
                        userType: getHelpController
                            .solhVolunteerList.value.provider![index].userType,
                      ),
                    )
                  : Container(
                      child: Center(
                        child: Text('No Volunteers Found'),
                      ),
                    );
            })),
          ), */
        ],
      ),
    );
  }

  bool checkIfAlreadyInSendConnection(String sId) {
    var isInConnection = false;
    connectionController.sentConnections.value.forEach((element) {
      if (sId == element.sId) {
        isInConnection = true;
      }
    });
    debugPrint('++++' + sId + isInConnection.toString());
    return isInConnection;
  }

  void getProfile() {
    if (profileController.myProfileModel.value.body == null) {
      profileController.getMyProfile();
    }
  }
}

class IssuesTile extends StatefulWidget {
  const IssuesTile({
    Key? key,
    required String title,
    required VoidCallback onPressed,
  })  : _title = title,
        _onPressed = onPressed,
        super(key: key);

  final String _title;
  final VoidCallback _onPressed;

  @override
  State<IssuesTile> createState() => _IssuesTileState();
}

class _IssuesTileState extends State<IssuesTile>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> animation;
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: Random().nextInt(3) + 2))
      ..forward();

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });

    animation = Tween<Offset>(
            begin: Offset(Random().nextDouble() * -0.3, 0),
            end: Offset(0, Random().nextDouble() * -0.3))
        .animate(animationController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /* return SlideTransition(
      position: animation,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: SolhColors.tertiary_green,
        ),
        height: 80,
        width: 80,
        child: Center(
          child: Text(
            widget._title,
            style: SolhTextStyles.QS_cap_2_semi,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ); */
    return GestureDetector(
      onTap: widget._onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFEFEFEF),
          ),
          borderRadius: BorderRadius.circular(18),
          color: Color(0xFFFBFBFB),
        ),
        child: Text(
          widget._title,
          style: SolhTextStyles.QS_cap_semi,
        ),
      ),
    );
  }
}

class TopConsultantsTile extends StatelessWidget {
  TopConsultantsTile({
    required Doctors doctors,
    Key? key,
  })  : _doctors = doctors,
        super(key: key);
  final Doctors _doctors;
  ConsultantController consultantController = Get.put(ConsultantController());
  @override
  Widget build(BuildContext context) {
    debugPrint(_doctors.profilePicture ??
        '' + 'sjfiodksmlsd,clsdiofjksdomflfmfdsmdsmm');
    return InkWell(
      onTap: () {
        consultantController.getConsultantDataController(_doctors.sId ?? '');
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ConsultantProfilePage()));
        FirebaseAnalytics.instance.logEvent(
            name: 'OpenConsultantProfileTaped',
            parameters: {'Page': 'GetHelp'});
      },
      child: Container(
        width: 40.w,
        // height: 25.h,
        margin: EdgeInsets.symmetric(horizontal: 2.5.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            // borderRadius: BorderRadius.circular(8),
            border: Border.all(color: SolhColors.grey_2.withOpacity(0.4))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              child: CachedNetworkImage(
                imageUrl: _doctors.profilePicture ??
                    'https://solh.s3.amazonaws.com/user/profile/1651493729337',
                width: 40.w,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            Spacer(),
            Text(
              _doctors.name ?? '',
              style: SolhTextStyles.QS_caption_bold.copyWith(height: 2),
            ),
            SizedBox(
              width: 30.w,
              child: Text(
                _doctors.specialization ?? '',
                style: SolhTextStyles.QS_cap_2_semi,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            // Container(
            //   margin: EdgeInsets.only(bottom: 10),
            //   padding: EdgeInsets.all(8.0),
            //   decoration: BoxDecoration(
            //       color: SolhColors.greenShade5,
            //       borderRadius: BorderRadius.circular(12)),
            //   child: Text(
            //     "${_doctors.feeCurrency ?? 'Rs'}  ${_doctors.fee_amount ?? 0}",
            //     style: SolhTextStyles.QS_caption_bold,
            //   ),
            // ),

            // Text(
            //   _doctors.bio ?? '',
            //   maxLines: 3,
            //   overflow: TextOverflow.ellipsis,
            //   style: TextStyle(
            //       fontSize: 12,
            //       color: Color(0xFF666666),
            //       fontWeight: FontWeight.w300),
            // ),
            // Container(
            //     width: 42.w,
            //     // height: 15.h,
            //     padding: EdgeInsets.symmetric(vertical: 1.h),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
            //         Text(_doctors.name ?? ''),
            //         // Text(_qualification),
            //         Text(
            //           _doctors.bio ?? '',
            //           maxLines: 3,
            //           overflow: TextOverflow.ellipsis,
            //           style: TextStyle(
            //               fontSize: 12,
            //               color: Color(0xFF666666),
            //               fontWeight: FontWeight.w300),
            //         ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: SolhGreenButton(
                  height: 28,
                  child: Text(
                    "Book Appointment",
                    style: SolhTextStyles.QS_cap_semi.copyWith(
                        fontSize: 10, color: SolhColors.white),
                  ),
                  onPressed: () {
                    //launch("tel://$_mobile");
                    consultantController
                        .getConsultantDataController(_doctors.sId ?? '');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ConsultantProfilePage()));
                  },
                ),
              ),
            )
            //       ],
            //     )),
          ],
        ),
      ),
    );
  }
}

class GetHelpCategory extends StatelessWidget {
  GetHelpCategory({
    Key? key,
    required String title,
    VoidCallback? onPressed,
    this.trailing,
  })  : _title = title,
        _onPressed = onPressed,
        super(key: key);

  final String _title;
  final VoidCallback? _onPressed;
  final Widget? trailing;
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          homeController.line.value.isNotEmpty
              ? Container(
                  padding: EdgeInsets.only(top: 8.0),
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: homeController.line.value,
                    fit: BoxFit.fill,
                  ),
                )
              : SizedBox(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _title,
                  style: TextStyle(fontSize: 20, color: Color(0xFF666666)),
                ),
                trailing == null
                    ? _onPressed != null
                        ? InkWell(
                            onTap: _onPressed,
                            child: Text(
                              "View All",
                              style: SolhTextStyles.CTA
                                  .copyWith(color: SolhColors.primary_green),
                            ),
                          )
                        : Container()
                    : trailing!
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GetHelpDivider extends StatelessWidget {
  const GetHelpDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0x30D9D9D9),
      height: 1.8.h,
    );
  }
}

class SolhVolunteers extends StatelessWidget {
  SolhVolunteers(
      {Key? key,
      required this.mobile,
      required this.name,
      required this.bio,
      this.imgUrl,
      this.isInSendRequest,
      this.sId,
      this.comments,
      this.connections,
      this.likes,
      this.uid,
      this.userType,
      required this.post})
      : super(key: key);
  final String? mobile;
  final String? name;
  final String? bio;
  final String? imgUrl;
  final String? sId;
  final String? likes;
  final String? connections;
  final bool? isInSendRequest;
  final String? comments;
  final String? uid;
  final String? userType;
  final int post;

  ConnectionController connectionController = Get.find();
  ConnectScreenController connectScreenController =
      Get.put(ConnectScreenController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.pushNamed(context, AppRoutes.connectScreen,
            arguments: {'sId': sId ?? '', 'userName': null});
      }),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color(0xFFEFEFEF),
            width: 1,
          ),
        ),
        width: 164,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 121,
                  decoration: BoxDecoration(
                      color: SolhColors.grey,
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(imgUrl ?? ""))),
                ),
                Container(
                  height: 121,
                  width: 164,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(9, 62, 49, 0.45),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(name ?? '',
                          style: SolhTextStyles.QS_body_2_bold.copyWith(
                              color: SolhColors.white)),
                      SizedBox(
                        height: 5,
                      ),
                      userType != null
                          ? Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(color: SolhColors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(userType ?? '',
                                      style: SolhTextStyles.QS_caption.copyWith(
                                          color: SolhColors.white)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  userType != null
                                      ? Image(
                                          color: Colors.white,
                                          image: AssetImage(
                                            'assets/images/verifiedTick.png',
                                          ))
                                      : Container(),
                                ],
                              ),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 30,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(bio ?? ''.trim(),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: SolhTextStyles.QS_cap_2_semi),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/get_help/post.svg',
                        color: SolhColors.primary_green,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(post.toString(),
                          style: SolhTextStyles.QS_caption_bold),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/get_help/thumbs up.svg',
                        color: SolhColors.primary_green,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(likes ?? '', style: SolhTextStyles.QS_caption_bold)
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/connection.svg',
                        color: SolhColors.primary_green,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        connections ?? '',
                        style: SolhTextStyles.QS_caption_bold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() {
              return getConnectionIdBySId(sId ?? '') != ''
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Request Sent',
                            style: GoogleFonts.signika(
                              fontSize: 12,
                              color: Color(0xffA6A6A6),
                            )),
                        Icon(
                          Icons.done,
                          color: Color(0xffA6A6A6),
                          size: 15,
                        )
                      ],
                    )
                  : Container(
                      height: 15,
                    );
            }),
            SizedBox(
              height: 5,
            ),
            Obx(() {
              return InkWell(
                onTap: () {
                  getConnectionIdBySId(sId ?? '') != ''
                      ? connectionController.deleteConnectionRequest(
                          getConnectionIdBySId(sId ?? ''))
                      : connectionController.addConnection(sId ?? '');
                },
                child: Container(
                  height: 32,
                  width: 148,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: SolhColors.primary_green),
                      borderRadius: BorderRadius.circular(16)),
                  child:
                      connectionController.isSendingConnectionRequest.value &&
                              connectionController.currentSendingRequest == sId
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    color: SolhColors.primary_green,
                                    strokeWidth: 1,
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  getConnectionIdBySId(sId ?? '') != ''
                                      ? Container()
                                      : SvgPicture.asset(
                                          'assets/images/connect.svg',
                                          height: 14,
                                          color: SolhColors.primary_green,
                                        ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  getConnectionIdBySId(sId ?? '') != ''
                                      ? Text('Cancel',
                                          style: GoogleFonts.signika(
                                            fontSize: 14,
                                            color: SolhColors.primary_green,
                                          ))
                                      : Text(
                                          'Connect',
                                          style: GoogleFonts.signika(
                                            fontSize: 14,
                                            color: SolhColors.primary_green,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  String getConnectionIdBySId(String sId) {
    String connectionId = '';
    connectionController.allConnectionModel.value.connections!
        .forEach((element) {
      if (element.sId == sId && element.flag == 'sent') {
        connectionId = element.connectionId!;
      }
    });
    return connectionId;
  }
}

/* import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/controllers/getHelp/get_help_controller.dart';
import 'package:solh/controllers/getHelp/search_market_controller.dart';
import 'package:solh/model/get-help/search_market_model.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/connect/connect_screen_controller/connect_screen_controller.dart';
import 'package:solh/ui/screens/get-help/search_screen.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/image_container.dart';
import 'package:solh/widgets_constants/solh_search_field.dart';
import 'consultant_profile.dart';

class GetHelpScreen extends StatefulWidget {
  const GetHelpScreen({Key? key}) : super(key: key);

  @override
  State<GetHelpScreen> createState() => _GetHelpScreenState();
}

class _GetHelpScreenState extends State<GetHelpScreen> {
  GetHelpController getHelpController = Get.find();
  SearchMarketController searchMarketController = Get.find();
  BookAppointmentController bookAppointmentController = Get.find();
  ConnectionController connectionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SolhSearchField(
                hintText: 'Anxiety, Corporate Stress, Family Issues',
                icon: 'assets/icons/app-bar/search.svg',
                onTap: () {
                  searchMarketController.searchMarketModel.value =
                      SearchMarketModel();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(),
                    ),
                  );
                }),
          ),
          GetHelpDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetHelpCategory(title: 'Search for support'),
                InkWell(
                  onTap: () {
                    getHelpController.isAllIssueShown.value
                        ? getHelpController.showLessIssues()
                        : getHelpController.showAllIssues();
                    getHelpController.isAllIssueShown.value =
                        !getHelpController.isAllIssueShown.value;
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(
                          right: 11.0, bottom: 11, top: 11, left: 11),
                      child: Obx(() {
                        return Text(
                          !getHelpController.isAllIssueShown.value
                              ? "Show More"
                              : "Show less",
                          style: TextStyle(
                            fontSize: 16,
                            color: SolhColors.green,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      })),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 1.5.h),
              child: Obx(() {
                return Wrap(
                  runSpacing: 5,
                  children: getHelpController.issueList.value.map((issue) {
                    return IssuesTile(
                      title: issue.name ?? '',
                      onPressed: () {
                        bookAppointmentController.query = issue.name;
                        Navigator.pushNamed(
                            context, AppRoutes.viewAllConsultant, arguments: {
                          "slug": issue.slug ?? '',
                          "type": 'issue'
                        });
                      },
                    );
                  }).toList(),
                );
              })),
          GetHelpDivider(),
          GetHelpCategory(
            title: "Search by speciality",
          ),
          Obx(() {
            return getHelpController
                        .getSpecializationModel.value.specializationList !=
                    null
                ? Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 2.5.w,
                          crossAxisSpacing: 2.5.w,
                          crossAxisCount: 2,
                          childAspectRatio: 2),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: getHelpController.getSpecializationModel.value
                          .specializationList!.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                          bookAppointmentController.query = getHelpController
                              .getSpecializationModel
                              .value
                              .specializationList![index]
                              .name;
                          Navigator.pushNamed(
                              context, AppRoutes.viewAllConsultant,
                              arguments: {
                                "slug": getHelpController
                                        .getSpecializationModel
                                        .value
                                        .specializationList![index]
                                        .slug ??
                                    '',
                                "type": 'specialization'
                              });
                        },
                        child: Container(
                          height: 1.h,
                          width: 10.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFEFEFEF)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                                child: CircleAvatar(
                                  radius: 8.w,
                                  child: CircleAvatar(
                                    radius: 7.8.w,
                                    backgroundColor: Colors.white,
                                    child: CachedNetworkImage(
                                      imageUrl: getHelpController
                                              .getSpecializationModel
                                              .value
                                              .specializationList![index]
                                              .displayImage ??
                                          '',
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                              child: Container(
                                                height: 1.h,
                                                width: 1.w,
                                                color: Colors.grey,
                                              ),
                                              baseColor: Colors.grey,
                                              highlightColor: Colors.white),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                        Icons.person,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Container(
                                width: 25.w,
                                child: Text(
                                  getHelpController.getSpecializationModel.value
                                          .specializationList![index].name ??
                                      '',
                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Container();
          }),
          GetHelpDivider(),
          GetHelpCategory(
              title: "Top Consultants",
              onPressed: () => Navigator.pushNamed(
                  context, AppRoutes.viewAllConsultant,
                  arguments: {"slug": '', "type": 'topconsultant'})),
          Container(
            height: 17.h,
            margin: EdgeInsets.only(bottom: 2.h),
            child: Container(child: Obx(() {
              return getHelpController.topConsultantList.value.doctors != null
                  ? getHelpController.topConsultantList.value.doctors!.isEmpty
                      ? Center(
                          child:
                              Text('No Consultant available for your country'),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: getHelpController
                              .topConsultantList.value.doctors!.length,
                          itemBuilder: (_, index) {
                            debugPrint(getHelpController.topConsultantList.value
                                .doctors![index].profilePicture);
                            return TopConsultantsTile(
                              bio: getHelpController.topConsultantList.value
                                      .doctors![index].bio ??
                                  '',
                              name: getHelpController.topConsultantList.value
                                      .doctors![index].name ??
                                  '',
                              mobile: getHelpController.topConsultantList.value
                                      .doctors![index].contactNumber ??
                                  '',
                              imgUrl: getHelpController.topConsultantList.value
                                  .doctors![index].profilePicture,
                              sId: getHelpController
                                  .topConsultantList.value.doctors![index].sId,
                            );
                          })
                  : Container(
                      child: Center(
                      child: Text('No Doctors Found'),
                    ));
            })),
          ),
          GetHelpDivider(),
          GetHelpCategory(
            title: "Solh Volunteer",
          ),
          Container(
            height: 290,
            margin: EdgeInsets.only(bottom: 2.h),
            child: Container(child: Obx(() {
              return getHelpController.solhVolunteerList.value.provider != null
                  ? ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 2.h),
                      separatorBuilder: (_, __) => SizedBox(width: 2.w),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: getHelpController
                          .solhVolunteerList.value.provider!.length,
                      itemBuilder: (context, index) => SolhVolunteers(
                        bio: getHelpController
                                .solhVolunteerList.value.provider![index].bio ??
                            '',
                        isInSendRequest: checkIfAlreadyInSendConnection(
                          getHelpController.solhVolunteerList.value
                                  .provider![index].sId ??
                              '',
                        ),
                        name: getHelpController.solhVolunteerList.value
                                .provider![index].name ??
                            '',
                        mobile: getHelpController.solhVolunteerList.value
                                .provider![index].contactNumber ??
                            '',
                        imgUrl: getHelpController.solhVolunteerList.value
                            .provider![index].profilePicture,
                        sId: getHelpController
                            .solhVolunteerList.value.provider![index].sId,
                        uid: getHelpController
                            .solhVolunteerList.value.provider![index].uid,
                        comments: getHelpController.solhVolunteerList.value
                            .provider![index].commentCount
                            .toString(),
                        connections: getHelpController.solhVolunteerList.value
                            .provider![index].connectionsCount
                            .toString(),
                        likes: getHelpController
                            .solhVolunteerList.value.provider![index].likesCount
                            .toString(),
                        userType: getHelpController
                            .solhVolunteerList.value.provider![index].userType,
                      ),
                    )
                  : Container(
                      child: Center(
                        child: Text('No Volunteers Found'),
                      ),
                    );
            })),
          ),
          SizedBox(
            height: 150,
          )
        ],
      ),
    );
  }

  bool checkIfAlreadyInSendConnection(String sId) {
    var isInConnection = false;
    connectionController.sentConnections.value.forEach((element) {
      if (sId == element.sId) {
        isInConnection = true;
      }
    });
    debugPrint('++++' + sId + isInConnection.toString());
    return isInConnection;
  }
}

class IssuesTile extends StatelessWidget {
  const IssuesTile({
    Key? key,
    required String title,
    required VoidCallback onPressed,
  })  : _title = title,
        _onPressed = onPressed,
        super(key: key);

  final String _title;
  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFEFEFEF),
          ),
          borderRadius: BorderRadius.circular(18),
          color: Color(0xFFFBFBFB),
        ),
        child: Text(
          _title,
          style: TextStyle(color: Color(0xFF666666)),
        ),
      ),
    );
  }
}

class TopConsultantsTile extends StatelessWidget {
  const TopConsultantsTile({
    required String name,
    required String bio,
    required String mobile,
    String? imgUrl,
    String? sId,
    Key? key,
  })  : _name = name,
        _bio = bio,
        _mobile = mobile,
        _imgUrl = imgUrl,
        _sId = sId,
        super(key: key);

  final String _mobile;
  final String _name;
  final String _bio;
  final String? _imgUrl;
  final String? _sId;

  @override
  Widget build(BuildContext context) {
    debugPrint(_imgUrl ?? '' + 'sjfiodksmlsd,clsdiofjksdomflfmfdsmdsmm');
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ConsultantProfile(id: _sId)));
      },
      child: Container(
        //width: 70.w,
        //height: 25.h,
        margin: EdgeInsets.symmetric(horizontal: 2.5.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: SolhColors.grey196.withOpacity(0.4))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
              child: CachedNetworkImage(
                imageUrl: _imgUrl ??
                    'https://solh.s3.amazonaws.com/user/profile/1651493729337',
                width: 30.w,
                height: double.maxFinite,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 2.w),
            Container(
                width: 42.w,
                // height: 15.h,
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(_name),
                    // Text(_qualification),
                    Text(
                      _bio,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w300),
                    ),
                    Center(
                      child: SolhGreenButton(
                        height: 5.h,
                        width: 35.w,
                        child: Text(
                          "Book Appointment",
                          style: TextStyle(fontSize: 12),
                        ),
                        onPressed: () {
                          //launch("tel://$_mobile");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ConsultantProfile(id: _sId)));
                        },
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class GetHelpCategory extends StatelessWidget {
  const GetHelpCategory({
    Key? key,
    required String title,
    VoidCallback? onPressed,
  })  : _title = title,
        _onPressed = onPressed,
        super(key: key);

  final String _title;
  final VoidCallback? _onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _title,
            style: TextStyle(fontSize: 20, color: Color(0xFF666666)),
          ),
          if (_onPressed != null)
            InkWell(
              onTap: _onPressed,
              child: Text(
                "View All",
                style: TextStyle(color: SolhColors.green),
              ),
            )
        ],
      ),
    );
  }
}

class GetHelpDivider extends StatelessWidget {
  const GetHelpDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0x30D9D9D9),
      height: 1.8.h,
    );
  }
}

class SolhVolunteers extends StatelessWidget {
  SolhVolunteers(
      {Key? key,
      required this.mobile,
      required this.name,
      required this.bio,
      this.imgUrl,
      this.isInSendRequest,
      this.sId,
      this.comments,
      this.connections,
      this.likes,
      this.uid,
      this.userType})
      : super(key: key);
  final String? mobile;
  final String? name;
  final String? bio;
  final String? imgUrl;
  final String? sId;
  final String? likes;
  final String? connections;
  final bool? isInSendRequest;
  final String? comments;
  final String? uid;
  final String? userType;

  ConnectionController connectionController = Get.find();
  ConnectScreenController connectScreenController =
      Get.put(ConnectScreenController());
  //optimization needed in cancle and connect
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.pushNamed(context, AppRoutes.connectScreen,
            arguments: {'sId': sId ?? '', 'userName': null});
      }),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color(0xFFEFEFEF),
            width: 1,
          ),
        ),
        // height: 289,
        width: 164,
        child: Stack(children: [
          Container(
            height: 52,
            // width: 164,
            decoration: BoxDecoration(
              color: SolhColors.green,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 8,
            child: Column(
              children: [
                SimpleImageContainer(
                  imageUrl: imgUrl ?? "",
                  enableborder: true,
                  radius: 80,
                  borderColor: Colors.white,
                  boxFit: BoxFit.cover,
                  zoomEnabled: true,
                ),
                Text(name ?? ''),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userType ?? '',
                      style: GoogleFonts.signika(
                        fontSize: 12,
                        color: Color(0xFF5F9B8C),
                      ),
                    ),
                    userType != null
                        ? Image(
                            image: AssetImage('assets/images/verifiedTick.png'))
                        : Container(),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      bio ?? '',
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.signika(
                        fontSize: 12,
                        color: Color(0xff666666),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.comment,
                            color: Color(0xFF5F9B8C),
                            size: 12,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            comments ?? '',
                            style: GoogleFonts.signika(
                              fontSize: 12,
                              color: Color(0xFF5F9B8C),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.thumb_up,
                            size: 12,
                            color: Color(0xff5F9B8C),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            likes ?? '',
                            style: GoogleFonts.signika(
                                fontSize: 12, color: Color(0xff5F9B8C)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.group,
                            size: 12,
                            color: Color(0xff5F9B8C),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            connections ?? '',
                            style: GoogleFonts.signika(
                                fontSize: 12, color: Color(0xff5F9B8C)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  return SizedBox(
                    height: getConnectionIdBySId(sId ?? '') != '' ? 17 : 33,
                  );
                }),
                Obx(() {
                  return getConnectionIdBySId(sId ?? '') != ''
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Request Sent',
                                style: GoogleFonts.signika(
                                  fontSize: 12,
                                  color: Color(0xffA6A6A6),
                                )),
                            Icon(
                              Icons.done,
                              color: Color(0xffA6A6A6),
                              size: 15,
                            )
                          ],
                        )
                      : Container();
                }),
                SizedBox(
                  height: 5,
                ),
                Obx(() {
                  return InkWell(
                    onTap: () {
                      getConnectionIdBySId(sId ?? '') != ''
                          ? connectionController.deleteConnectionRequest(
                              getConnectionIdBySId(sId ?? ''))
                          : connectionController.addConnection(sId ?? '');
                    },
                    child: Container(
                      height: 32,
                      width: 148,
                      decoration: BoxDecoration(
                          color: getConnectionIdBySId(sId ?? '') != ''
                              ? Colors.white
                              : SolhColors.green,
                          border: Border.all(color: SolhColors.green),
                          borderRadius: BorderRadius.circular(16)),
                      child: connectionController
                                  .isSendingConnectionRequest.value &&
                              connectionController.currentSendingRequest == sId
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 1,
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  getConnectionIdBySId(sId ?? '') != ''
                                      ? Container()
                                      : SvgPicture.asset(
                                          'assets/images/connect.svg',
                                          height: 14,
                                          color: Colors.white,
                                        ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  getConnectionIdBySId(sId ?? '') != ''
                                      ? Text('Cancel',
                                          style: GoogleFonts.signika(
                                            fontSize: 14,
                                            color: SolhColors.green,
                                          ))
                                      : Text(
                                          'Connect',
                                          style: GoogleFonts.signika(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                    ),
                  );
                })
              ],
            ),
          )
        ]),
      ),
    );
  }

  String getConnectionIdBySId(String sId) {
    String connectionId = '';
    connectionController.allConnectionModel.value.connections!
        .forEach((element) {
      if (element.sId == sId && element.flag == 'sent') {
        connectionId = element.connectionId!;
      }
    });
    return connectionId;
  }
}
 */