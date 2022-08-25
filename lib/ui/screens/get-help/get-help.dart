import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bottom-navigation/bottom_navigator_controller.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/controllers/getHelp/get_help_controller.dart';
import 'package:solh/controllers/getHelp/search_market_controller.dart';
import 'package:solh/model/get-help/search_market_model.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/ui/screens/connect/connect-screen.dart';
import 'package:solh/ui/screens/get-help/search_screen.dart';
import 'package:solh/ui/screens/get-help/view-all/consultants.dart';
import 'package:solh/ui/screens/journaling/side_drawer.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/others/semi-circle.dart';
import 'package:solh/widgets_constants/solh_search_field.dart';

import 'consultant_profile.dart';

class GetHelpMaster extends StatefulWidget {
  const GetHelpMaster({Key? key}) : super(key: key);

  @override
  State<GetHelpMaster> createState() => _GetHelpMasterState();
}

class _GetHelpMasterState extends State<GetHelpMaster> {
  @override
  Widget build(BuildContext context) {
    debugPrint('it ran');
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [SideDrawer(), GetHelpScreen()],
        ),
      ),
    );
  }
}

class GetHelpScreen extends StatefulWidget {
  const GetHelpScreen({Key? key}) : super(key: key);

  @override
  State<GetHelpScreen> createState() => _GetHelpScreenState();
}

class _GetHelpScreenState extends State<GetHelpScreen> {
  GetHelpController getHelpController = Get.find();
  SearchMarketController searchMarketController = Get.find();
  BookAppointmentController bookAppointmentController = Get.find();
  BottomNavigatorController _bottomNavigatorController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          left: _bottomNavigatorController.isDrawerOpen.value ? 78.w : 0,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.35),
                    offset: const Offset(
                      14.0,
                      14.0,
                    ),
                    blurRadius: 20.0,
                    spreadRadius: 4.0,
                  )
                ],
                color: Colors.white),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Scaffold(
                  appBar: getAppBar(),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SolhSearchField(
                              hintText:
                                  'Anxiety, Corporate Stress, Family Issues',
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
                              GetHelpCategory(title: 'Search by issues'),
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
                                        right: 11.0,
                                        bottom: 11,
                                        top: 11,
                                        left: 11),
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
                                children: getHelpController.issueList.value
                                    .map((issue) {
                                  return IssuesTile(
                                    title: issue.name ?? '',
                                    onPressed: () {
                                      bookAppointmentController.query =
                                          issue.name;
                                      AutoRouter.of(context).push(
                                          ConsultantsScreenRouter(
                                              slug: issue.slug ?? '',
                                              type: 'issue'));
                                    },
                                  );
                                }).toList(),
                              );
                            })),
                        GetHelpDivider(),
                        GetHelpCategory(
                          title: "Search by speciality",
                        ),
                        getHelpController.getSpecializationModel.value
                                    .specializationList !=
                                null
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 1.5.h),
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 2.5.w,
                                          crossAxisSpacing: 2.5.w,
                                          crossAxisCount: 2,
                                          childAspectRatio: 2),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: getHelpController
                                      .getSpecializationModel
                                      .value
                                      .specializationList!
                                      .length,
                                  shrinkWrap: true,
                                  itemBuilder: (_, index) => GestureDetector(
                                    onTap: () {
                                      bookAppointmentController.query =
                                          getHelpController
                                              .getSpecializationModel
                                              .value
                                              .specializationList![index]
                                              .name;
                                      AutoRouter.of(context).push(
                                          ConsultantsScreenRouter(
                                              slug: getHelpController
                                                      .getSpecializationModel
                                                      .value
                                                      .specializationList![
                                                          index]
                                                      .slug ??
                                                  '',
                                              type: 'specialization'));
                                    },
                                    child: Container(
                                      height: 1.h,
                                      width: 10.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Color(0xFFEFEFEF)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                4, 0, 0, 0),
                                            child: CircleAvatar(
                                              radius: 8.w,
                                              child: CircleAvatar(
                                                radius: 7.8.w,
                                                backgroundColor: Colors.white,
                                                child: CachedNetworkImage(
                                                  imageUrl: getHelpController
                                                          .getSpecializationModel
                                                          .value
                                                          .specializationList![
                                                              index]
                                                          .displayImage ??
                                                      '',
                                                  placeholder: (context, url) =>
                                                      Shimmer.fromColors(
                                                          child: Container(
                                                            height: 1.h,
                                                            width: 1.w,
                                                            color: Colors.grey,
                                                          ),
                                                          baseColor:
                                                              Colors.grey,
                                                          highlightColor:
                                                              Colors.white),
                                                  errorWidget:
                                                      (context, url, error) =>
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
                                              getHelpController
                                                      .getSpecializationModel
                                                      .value
                                                      .specializationList![
                                                          index]
                                                      .name ??
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
                            : Container(),
                        GetHelpDivider(),
                        GetHelpCategory(
                          title: "Top Consultants",
                          onPressed: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ConsultantsScreen(
                                        slug: '',
                                        type: 'topconsultant',
                                      ))),
                        ),
                        Container(
                          height: 17.h,
                          margin: EdgeInsets.only(bottom: 2.h),
                          child: Container(
                            child: getHelpController
                                        .topConsultantList.value.doctors !=
                                    null
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 6,
                                    itemBuilder: (_, index) {
                                      print(getHelpController
                                          .topConsultantList
                                          .value
                                          .doctors![index]
                                          .profilePicture);
                                      return TopConsultantsTile(
                                        bio: getHelpController.topConsultantList
                                                .value.doctors![index].bio ??
                                            '',
                                        name: getHelpController
                                                .topConsultantList
                                                .value
                                                .doctors![index]
                                                .name ??
                                            '',
                                        mobile: getHelpController
                                                .topConsultantList
                                                .value
                                                .doctors![index]
                                                .contactNumber ??
                                            '',
                                        imgUrl: getHelpController
                                            .topConsultantList
                                            .value
                                            .doctors![index]
                                            .profilePicture,
                                        sId: getHelpController.topConsultantList
                                            .value.doctors![index].sId,
                                      );
                                    })
                                : Container(
                                    child: Center(
                                    child: Text('No Doctors Found'),
                                  )),
                          ),
                        ),
                        GetHelpDivider(),
                        GetHelpCategory(
                          title: "Solh Volunteer",
                          onPressed: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ConsultantsScreen(
                                        slug: '',
                                        type: 'topconsultant',
                                      ))),
                        ),
                        Container(
                          height: 38.h,
                          margin: EdgeInsets.only(bottom: 2.h),
                          child: Container(child: Obx(() {
                            return getHelpController
                                        .solhVolunteerList.value.provider !=
                                    null
                                ? ListView.separated(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.h),
                                    separatorBuilder: (_, __) =>
                                        SizedBox(width: 2.w),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: getHelpController
                                        .solhVolunteerList
                                        .value
                                        .provider!
                                        .length,
                                    itemBuilder: (context, index) =>
                                        SolhVolunteers(
                                      bio: getHelpController.solhVolunteerList
                                              .value.provider![index].bio ??
                                          '',
                                      name: getHelpController.solhVolunteerList
                                              .value.provider![index].name ??
                                          '',
                                      mobile: getHelpController
                                              .solhVolunteerList
                                              .value
                                              .provider![index]
                                              .contactNumber ??
                                          '',
                                      imgUrl: getHelpController
                                          .solhVolunteerList
                                          .value
                                          .provider![index]
                                          .profilePicture,
                                      sId: getHelpController.solhVolunteerList
                                          .value.provider![index].sId,
                                      uid: getHelpController.solhVolunteerList
                                          .value.provider![index].uid,
                                      comments: getHelpController
                                          .solhVolunteerList
                                          .value
                                          .provider![index]
                                          .commentCount
                                          .toString(),
                                      connections: getHelpController
                                          .solhVolunteerList
                                          .value
                                          .provider![index]
                                          .connectionsCount
                                          .toString(),
                                      likes: getHelpController.solhVolunteerList
                                          .value.provider![index].likesCount
                                          .toString(),
                                      userType: getHelpController
                                          .solhVolunteerList
                                          .value
                                          .provider![index]
                                          .userType,
                                    ),
                                  )
                                : Container(
                                    child: Center(
                                      child: Text('No Volunteers Found'),
                                    ),
                                  );
                          })),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
    });
  }

  SolhAppBar getAppBar() {
    return SolhAppBar(
      title: Row(
        children: [
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: InkWell(
              onTap: () {
                print("side bar tapped");

                _bottomNavigatorController.isDrawerOpen.value == true
                    ? _bottomNavigatorController.isDrawerOpen.value = false
                    : _bottomNavigatorController.isDrawerOpen.value = true;
                // setState(() {
                //   _isDrawerOpen = !_isDrawerOpen;
                // });
                print("opened");
              },
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                height: 40,
                width: 30,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: SvgPicture.asset(
                  "assets/icons/app-bar/app-bar-menu.svg",
                  width: 26,
                  height: 24,
                  color: SolhColors.green,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 2.h,
          ),
          Text(
            "Get help",
            style: SolhTextStyles.AppBarText,
          ),
        ],
      ),
      isLandingScreen: true,
    );
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
    print(_imgUrl ?? '' + 'sjfiodksmlsd,clsdiofjksdomflfmfdsmdsmm');
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
                    // Text(
                    //   "07 Year of Experience",
                    //   style: TextStyle(fontSize: 12),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 1.w),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Icon(
                    //             Icons.people,
                    //             color: SolhColors.green,
                    //             size: 18,
                    //           ),
                    //           Text(
                    //             "72",
                    //             style: SolhTextStyles.GreenBorderButtonText,
                    //           )
                    //         ],
                    //       ),
                    //       Text(
                    //         "Free",
                    //         style: TextStyle(color: SolhColors.green),
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class ProfilePictureHeader extends StatelessWidget {
  const ProfilePictureHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12.8.h,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
                color: SolhColors.green,
                borderRadius: BorderRadius.circular(8)),
            height: 6.5.h,
          ),
          Positioned(
            top: 1.54.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                MyArc(
                  diameter: 10.h,
                  color: Colors.white,
                ),
                RotatedBox(quarterTurns: 2, child: MyArc(diameter: 10.h)),
                CircleAvatar(
                  radius: 4.75.h,
                  backgroundImage: CachedNetworkImageProvider(
                    "https://techcrunch.com/wp-content/uploads/2017/09/sunshine.jpg?w=1000",
                  ),
                ),
              ],
            ),
          ),
        ],
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
  final String? comments;
  final String? uid;
  final String? userType;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => ConnectProfileScreen(
                  uid: uid!,
                  sId: sId!,
                ))));
      }),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color(0xFFEFEFEF),
            width: 1,
          ),
        ),
        height: 289,
        width: 164,
        child: Stack(children: [
          Container(
            height: 52,
            width: 164,
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
                Container(
                  height: 70,
                  width: 70,
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Container(
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 35,
                          backgroundImage: CachedNetworkImageProvider(
                            imgUrl ?? "",
                          ),
                          // child: CachedNetworkImage(
                          //   imageUrl: imgUrl ?? '',
                          //   fit: BoxFit.fill,
                          //   placeholder: (context, url) => Shimmer.fromColors(
                          //       child: CircleAvatar(
                          //         backgroundColor: Colors.grey,
                          //       ),
                          //       baseColor: Colors.grey[300]!,
                          //       highlightColor: Colors.grey[300]!),
                          //   errorWidget: (context, url, error) =>
                          //       Icon(Icons.person, size: 35, color: Colors.grey),
                          // ),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(name ?? ''),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(
                    //   'Solh Expert',
                    //   style: GoogleFonts.signika(
                    //     fontSize: 12,
                    //     color: Color(0xFF5F9B8C),
                    //   ),
                    // ),
                    // Image(image: AssetImage('assets/images/verifiedTick.png')),
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
                SizedBox(
                  height: 33,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ConnectProfileScreen(
                              sId: sId!,
                              uid: uid!,
                            )));
                  },
                  child: Container(
                    height: 32,
                    width: 148,
                    decoration: BoxDecoration(
                        color: SolhColors.green,
                        borderRadius: BorderRadius.circular(16)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/connect.svg',
                            height: 14,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
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
                )
              ],
            ),
          )
        ]),
      ),
    );

    // return Container(
    //   child: Column(
    //     children: [

    //       // Container(
    //       //   height: 300,
    //       //   padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
    //       //   child: ListView.separated(
    //       //     separatorBuilder: (context, index) => SizedBox(
    //       //       width: 10,
    //       //     ),
    //       //     shrinkWrap: true,
    //       //     scrollDirection: Axis.horizontal,
    //       //     itemCount: _solhVolunteers.length,
    //       //     itemBuilder: (context, index) {
    //       //       return Container(
    //       //         decoration: BoxDecoration(
    //       //           borderRadius: BorderRadius.circular(8),
    //       //           border: Border.all(
    //       //             color: Color(0xFFEFEFEF),
    //       //             width: 1,
    //       //           ),
    //       //         ),
    //       //         height: 289,
    //       //         width: 164,
    //       //         child: Stack(children: [
    //       //           Container(
    //       //             height: 52,
    //       //             width: 164,
    //       //             decoration: BoxDecoration(
    //       //               color: SolhColors.green,
    //       //               borderRadius: BorderRadius.circular(8),
    //       //             ),
    //       //           ),
    //       //           Positioned(
    //       //             left: 0,
    //       //             right: 0,
    //       //             top: 8,
    //       //             child: Column(
    //       //               children: [
    //       //                 Container(
    //       //                   height: 70,
    //       //                   width: 70,
    //       //                   padding: EdgeInsets.all(1),
    //       //                   decoration: BoxDecoration(
    //       //                       color: Colors.white, shape: BoxShape.circle),
    //       //                   child: Container(
    //       //                     child: FittedBox(
    //       //                         fit: BoxFit.fill,
    //       //                         child: CircleAvatar(
    //       //                           backgroundColor: Colors.white,
    //       //                           backgroundImage: AssetImage(
    //       //                               _solhVolunteers[index]['image']!),
    //       //                         )),
    //       //                   ),
    //       //                 ),
    //       //                 Text(_solhVolunteers[index]['name']!),
    //       //                 Row(
    //       //                   mainAxisAlignment: MainAxisAlignment.center,
    //       //                   children: [
    //       //                     Text(
    //       //                       'Solh Expert',
    //       //                       style: GoogleFonts.signika(
    //       //                         fontSize: 10,
    //       //                         color: Color(0xFF5F9B8C),
    //       //                       ),
    //       //                     ),
    //       //                     Image(
    //       //                         image: AssetImage(
    //       //                             'assets/images/verifiedTick.png')),
    //       //                   ],
    //       //                 ),
    //       //                 SizedBox(
    //       //                   height: 4,
    //       //                 ),
    //       //                 Container(
    //       //                   height: 45,
    //       //                   child: Padding(
    //       //                     padding:
    //       //                         const EdgeInsets.symmetric(horizontal: 8),
    //       //                     child: Text(
    //       //                       _solhVolunteers[index]['bio']!,
    //       //                       textAlign: TextAlign.center,
    //       //                       maxLines: 3,
    //       //                       overflow: TextOverflow.ellipsis,
    //       //                       style: GoogleFonts.signika(
    //       //                         fontSize: 12,
    //       //                         color: Color(0xff666666),
    //       //                       ),
    //       //                     ),
    //       //                   ),
    //       //                 ),
    //       //                 SizedBox(
    //       //                   height: 13,
    //       //                 ),
    //       //                 Padding(
    //       //                   padding: const EdgeInsets.symmetric(horizontal: 8),
    //       //                   child: Row(
    //       //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       //                     children: [
    //       //                       Row(
    //       //                         children: [
    //       //                           Icon(
    //       //                             Icons.thumb_up,
    //       //                             size: 12,
    //       //                             color: Color(0xff5F9B8C),
    //       //                           ),
    //       //                           SizedBox(
    //       //                             width: 4,
    //       //                           ),
    //       //                           Text(
    //       //                             _solhVolunteers[index]['like']!,
    //       //                             style: GoogleFonts.signika(
    //       //                                 fontSize: 12,
    //       //                                 color: Color(0xff5F9B8C)),
    //       //                           ),
    //       //                         ],
    //       //                       ),
    //       //                       Row(
    //       //                         children: [
    //       //                           SvgPicture.asset(
    //       //                             'assets/images/connect.svg',
    //       //                           ),
    //       //                           SizedBox(
    //       //                             width: 4,
    //       //                           ),
    //       //                           Text(
    //       //                             _solhVolunteers[index]['helped']!,
    //       //                             style: GoogleFonts.signika(
    //       //                                 fontSize: 12,
    //       //                                 color: Color(0xff5F9B8C)),
    //       //                           ),
    //       //                         ],
    //       //                       ),
    //       //                       Row(
    //       //                         children: [
    //       //                           Icon(
    //       //                             Icons.group,
    //       //                             size: 12,
    //       //                             color: Color(0xff5F9B8C),
    //       //                           ),
    //       //                           SizedBox(
    //       //                             width: 4,
    //       //                           ),
    //       //                           Text(
    //       //                             _solhVolunteers[index]['interaction']!,
    //       //                             style: GoogleFonts.signika(
    //       //                                 fontSize: 12,
    //       //                                 color: Color(0xff5F9B8C)),
    //       //                           ),
    //       //                         ],
    //       //                       ),
    //       //                     ],
    //       //                   ),
    //       //                 ),
    //       //                 SizedBox(
    //       //                   height: 33,
    //       //                 ),
    //       //                 Container(
    //       //                   height: 32,
    //       //                   width: 148,
    //       //                   decoration: BoxDecoration(
    //       //                       color: SolhColors.green,
    //       //                       borderRadius: BorderRadius.circular(16)),
    //       //                   child: Center(
    //       //                     child: Row(
    //       //                       mainAxisAlignment: MainAxisAlignment.center,
    //       //                       children: [
    //       //                         SvgPicture.asset(
    //       //                           'assets/images/connect.svg',
    //       //                           height: 14,
    //       //                           color: Colors.white,
    //       //                         ),
    //       //                         SizedBox(
    //       //                           width: 4,
    //       //                         ),
    //       //                         Text(
    //       //                           'Connect',
    //       //                           style: GoogleFonts.signika(
    //       //                             fontSize: 14,
    //       //                             color: Colors.white,
    //       //                           ),
    //       //                         ),
    //       //                       ],
    //       //                     ),
    //       //                   ),
    //       //                 )
    //       //               ],
    //       //             ),
    //       //           )
    //       //         ]),
    //       //       );
    //       //     },
    //       //   ),
    //       // ),
    //     ],
    //   ),
    // );
  }
}
