import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/appointment_controller.dart';
import 'package:solh/model/profile/allied_appoinment_list.dart';
import 'package:solh/model/user/user_appointments_model.dart';
import 'package:solh/ui/screens/chat/chat_provider.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/image_container.dart';
import '../../../../widgets_constants/constants/colors.dart';
import '../../../../widgets_constants/loader/my-loader.dart';

class AppointmentScreen extends StatefulWidget {
  AppointmentScreen({Key? key, Map<dynamic, dynamic>? args}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen>
    with SingleTickerProviderStateMixin {
  final AppointmentController appointmentController = Get.find();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      appointmentController.getAlliedBooking();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        height: 100,
        isLandingScreen: false,
        title: Text(
          'Appointments'.tr,
          style: SolhTextStyles.AppBarText,
        ),
        bottom: getTab(),
      ),
      /*  body: SingleChildScrollView(child: Obx(() {
        return appointmentController.isAppointmentLoading.value
            ? Center(
                child: MyLoader(),
              )
            : Column(
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  getScheduledAppointments(appointmentController
                      .userAppointmentModel.value.scheduldAppointments),
                  GetHelpDivider(),
                  getCompletedAppointments(appointmentController
                      .userAppointmentModel.value.completedAppointments),
                ],
              );
      })), */
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(child: Obx(() {
            return appointmentController.isAppointmentLoading.value
                ? Center(
                    child: MyLoader(),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 3.h,
                      ),
                      getScheduledAppointments(appointmentController
                          .userAppointmentModel.value.scheduldAppointments),
                      GetHelpDivider(),
                      getCompletedAppointments(appointmentController
                          .userAppointmentModel.value.completedAppointments),
                    ],
                  );
          })),
          Obx(() => appointmentController.isAlliedLoading.value
              ? Center(
                  child: MyLoader(),
                )
              : AlliedAppointmentList(
                  alliedAppoinmentModel:
                      appointmentController.alliedAppoinmentModel.value))
        ],
      ),
    );
  }

  Widget getScheduledAppointments(
      List<ScheduldAppointments>? scheduldAppointments) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Scheduled'.tr,
            style: TextStyle(
              fontSize: SolhTextStyles.AppBarText.fontSize,
              fontWeight: SolhTextStyles.AppBarText.fontWeight,
              color: SolhColors.grey,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          appointmentController
                      .alliedAppoinmentModel.value.inHousePackageOrders ==
                  null
              ? Container()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: appointmentController
                      .userAppointmentModel.value.inHousePackageOrders!.length,
                  itemBuilder: ((context, index) {
                    return getAlliedInHousePackageCard(appointmentController
                        .userAppointmentModel
                        .value
                        .inHousePackageOrders![index]);
                  })),
          scheduldAppointments != null
              ? ListView.builder(
                  itemCount: scheduldAppointments.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return scheduldAppointments[index].doctor != null
                        ? InkWell(
                            onTap: () {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => ChatProviderScreen(
                              //         imageUrl: scheduldAppointments[index]
                              //             .doctor!
                              //             .profilePicture!,
                              //         name: scheduldAppointments[index]
                              //             .doctor!
                              //             .name!,
                              //         sId: scheduldAppointments[index]
                              //             .doctor!
                              //             .sId!),
                              //   ),
                              // );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.w),
                                    color: SolhColors.white,
                                    border: Border.all(
                                      color: SolhColors.primary_green,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                scheduldAppointments[index]
                                                    .doctor!
                                                    .name!,
                                                style: SolhTextStyles
                                                    .QS_body_2_bold,
                                              ),
                                              Text(
                                                scheduldAppointments[index]
                                                    .doctor!
                                                    .specialization!
                                                    .first
                                                    .name!,
                                                style:
                                                    SolhTextStyles.QS_caption,
                                              )
                                            ],
                                          ),
                                          SimpleImageContainer(
                                              radius: 50,
                                              boxFit: BoxFit.cover,
                                              imageUrl:
                                                  scheduldAppointments[index]
                                                      .doctor!
                                                      .profilePicture!)
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                CupertinoIcons.calendar,
                                                size: 14,
                                                color: SolhColors.Grey_1,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(scheduldAppointments[index]
                                                  .seekerTime!
                                                  .time!
                                                  .substring(4, 10))
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                CupertinoIcons.clock_fill,
                                                size: 14,
                                                color: SolhColors.Grey_1,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(scheduldAppointments[index]
                                                          .seekerTime!
                                                          .time!
                                                          .length >
                                                      20
                                                  ? scheduldAppointments[index]
                                                      .seekerTime!
                                                      .time!
                                                      .substring(15, 21)
                                                  : '')
                                            ],
                                          ),
                                          SolhGreenMiniButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) => ChatProviderScreen(
                                                      imageUrl:
                                                          scheduldAppointments[
                                                                  index]
                                                              .doctor!
                                                              .profilePicture!,
                                                      name:
                                                          scheduldAppointments[
                                                                  index]
                                                              .doctor!
                                                              .name!,
                                                      sId: scheduldAppointments[
                                                              index]
                                                          .doctor!
                                                          .sId!),
                                                ),
                                              );
                                            },
                                            width: 100,
                                            height: 40,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Session'.tr,
                                                  style: SolhTextStyles.CTA
                                                      .copyWith(
                                                          color:
                                                              SolhColors.white),
                                                ),
                                                Icon(
                                                  CupertinoIcons.right_chevron,
                                                  color: SolhColors.white,
                                                )
                                              ],
                                            ),
                                          )
                                          // Row(
                                          //   children: [
                                          //     Container(
                                          //       height: 5,
                                          //       width: 5,
                                          //       decoration: BoxDecoration(
                                          //           shape: BoxShape.circle,
                                          //           color: Color.fromARGB(
                                          //               255, 3, 208, 223)),
                                          //     ),
                                          //     SizedBox(width: 5),
                                          //     Text(
                                          //       'Scheduled',
                                          //       style: SolhTextStyles
                                          //           .QS_cap_2_semi,
                                          //     ),
                                          //   ],
                                          // )
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                          )
                        : Container();
                  })
              : Container(),
        ],
      ),
    );
  }

  Widget getCompletedAppointments(
      List<ScheduldAppointments>? completedAppointments) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Completed'.tr,
            style: TextStyle(
              fontSize: SolhTextStyles.AppBarText.fontSize,
              fontWeight: SolhTextStyles.AppBarText.fontWeight,
              color: SolhColors.grey,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          completedAppointments != null
              ? ListView.builder(
                  itemCount: completedAppointments.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return completedAppointments[index].doctor != null
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.w),
                                color: SolhColors.white,
                                border: Border.all(
                                  color: SolhColors.greyS200,
                                  width: 0.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(2.w),
                                                bottomLeft:
                                                    Radius.circular(2.w),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    completedAppointments[index]
                                                            .doctor!
                                                            .profilePicture ??
                                                        '',
                                                //'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200',
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  width: 20.w,
                                                  height: 20.w,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                            SizedBox(width: 3.w),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 150,
                                                  child: Text(
                                                    completedAppointments[index]
                                                            .doctor!
                                                            .name ??
                                                        '',
                                                    style: SolhTextStyles
                                                        .JournalingUsernameText,
                                                  ),
                                                ),
                                                Text(
                                                  '${completedAppointments[index].seekerTime!.time ?? ''}',
                                                  style: GoogleFonts.signika(
                                                      color: Color(0xffA6A6A6)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 6.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SolhGreenMiniButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatProviderScreen(
                                                              name: completedAppointments[
                                                                          index]
                                                                      .doctor!
                                                                      .name ??
                                                                  '',
                                                              imageUrl: completedAppointments[
                                                                          index]
                                                                      .doctor!
                                                                      .profilePicture ??
                                                                  '',
                                                              sId: completedAppointments[
                                                                          index]
                                                                      .doctor!
                                                                      .sId ??
                                                                  '',
                                                            )));
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '',
                                                    style: SolhTextStyles
                                                        .GreenButtonText,
                                                  ),
                                                  SizedBox(width: 1.w),
                                                  Icon(
                                                    Icons.chat,
                                                    color: SolhColors.white,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container();
                  },
                )
              : Container(),
        ],
      ),
    );
  }

  PreferredSize getTab() {
    return PreferredSize(
      preferredSize: Size(double.infinity, 60),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: SolhColors.grey_3.withOpacity(0.5),
                blurRadius: 5,
                offset: Offset(-10, 5))
          ],
          color: Colors.white,
        ),
        child: TabBar(
          controller: _tabController,
          tabs: [
            Text(
              'Counselling'.tr,
            ),
            Text(
              'Allied'.tr,
            ),
          ],
          labelStyle:
              SolhTextStyles.QS_body_1_med.copyWith(color: SolhColors.Grey_1),
          labelColor: SolhColors.primary_green,
          unselectedLabelStyle:
              SolhTextStyles.QS_body_1_med.copyWith(color: SolhColors.Grey_1),
          unselectedLabelColor: SolhColors.Grey_1,
          labelPadding: EdgeInsets.all(8),
        ),
      ),
    );
  }
}

class AlliedAppointmentList extends StatelessWidget {
  const AlliedAppointmentList({Key? key, required this.alliedAppoinmentModel})
      : super(key: key);
  final AlliedAppoinmentModel alliedAppoinmentModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                Column(
                    children: alliedAppoinmentModel.userPackageOrders!
                        .map((e) => getAlliedOrderCard(e))
                        .toList()),
                SizedBox(
                  height: 8,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                Column(
                  children: alliedAppoinmentModel.inHousePackageOrders!
                      .map((e) => getAlliedInHousePackageCard(e))
                      .toList(),
                ),
                SizedBox(
                  height: 8,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getAlliedOrderCard(UserPackageOrders e) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: SolhColors.grey_3)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                      width: 60.w,
                      child: Text(
                        e.packageName ?? '',
                        style: SolhTextStyles.QS_body_2_bold,
                      )),
                  e.provider!.isNotEmpty
                      ? Container(
                          width: 60.w,
                          child: Text(
                            e.provider![0].name ?? 'Owners name',
                            style: SolhTextStyles.QS_caption.copyWith(
                                color: SolhColors.dark_grey),
                          ))
                      : SizedBox(),
                ],
              ),
              Column(
                children: [
                  e.provider!.isNotEmpty
                      ? SimpleImageContainer(
                          imageUrl: e.provider![0].profilePicture ??
                              "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y",
                          boxFit: BoxFit.cover,
                        )
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 5,
                        width: 5,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: e.status == 'Inprocess'
                                ? Colors.orange
                                : e.status == 'Confirmed'
                                    ? Colors.green
                                    : e.status == 'Cancelled'
                                        ? Colors.red
                                        : Colors.yellow),
                      ),
                      SizedBox(width: 5),
                      Text(
                        e.status ?? '',
                        style: SolhTextStyles.QS_cap_2_semi,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          Divider(height: 25),
          Text(
            "Services are in process and we'll be delivering them soon. Please keep an eye on your emails."
                .tr,
            style: SolhTextStyles.QS_caption.copyWith(color: SolhColors.angry),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

Widget getAlliedInHousePackageCard(e) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
        border: Border.all(color: SolhColors.grey_3),
        // color: SolhColors.light_Bg_2,
        borderRadius: BorderRadius.circular(8)),
    child: Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.packageName ?? '',
                  style: SolhTextStyles.QS_body_2_bold,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  e.carouselName ?? '',
                  style: SolhTextStyles.QS_cap_semi,
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Text(
                      'Duration: ',
                      style: SolhTextStyles.QS_caption_bold,
                    ),
                    Text(
                      "${e.packageDuration!} ",
                      style: SolhTextStyles.QS_caption,
                    ),
                    Text(
                      e.packageUnitDuration!,
                      style: SolhTextStyles.QS_caption,
                    )
                  ],
                )
              ],
            ),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${e.packageCurrency!}  ",
                      style: SolhTextStyles.QS_caption_2_bold,
                    ),
                    Text(
                      e.packageAmount!.toString(),
                      style: SolhTextStyles.QS_body_1_bold,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: e.status == 'Inprocess'
                              ? Colors.orange
                              : e.status == 'Confirmed'
                                  ? Colors.green
                                  : e.status == 'Cancelled'
                                      ? Colors.red
                                      : Colors.yellow),
                    ),
                    SizedBox(width: 5),
                    Text(
                      e.status ?? '',
                      style: SolhTextStyles.QS_cap_2_semi,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Html(
          data: e.packageAboutPackage!,
        ),
        Divider(height: 25),
        Text(
          "Services are in process and we'll be delivering them soon. Please keep an eye on your emails."
              .tr,
          style: SolhTextStyles.QS_caption.copyWith(color: SolhColors.angry),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
