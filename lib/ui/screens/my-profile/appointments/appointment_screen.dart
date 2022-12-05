import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/appointment_controller.dart';
import 'package:solh/model/user/user_appointments_model.dart';
import 'package:solh/ui/screens/chat/chat_provider.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import '../../../../widgets_constants/constants/colors.dart';
import '../../../../widgets_constants/loader/my-loader.dart';
import '../../chat/chat.dart';

class AppointmentScreen extends StatelessWidget {
  AppointmentScreen({Key? key, Map<dynamic, dynamic>? args}) : super(key: key);
  final AppointmentController appointmentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
          isLandingScreen: false,
          title: Text(
            'Appointments',
            style: SolhTextStyles.AppBarText,
          )),
      body: SingleChildScrollView(child: Obx(() {
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
            'Scheduled',
            style: TextStyle(
              fontSize: SolhTextStyles.AppBarText.fontSize,
              fontWeight: SolhTextStyles.AppBarText.fontWeight,
              color: SolhColors.grey,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
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
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.w),
                                  color: SolhColors.white,
                                  border: Border.all(
                                    color: SolhColors.primary_green,
                                    width: 0.5,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(2.w),
                                            bottomLeft: Radius.circular(2.w),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                scheduldAppointments[index]
                                                        .doctor!
                                                        .profilePicture ??
                                                    '',
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: Text(
                                                scheduldAppointments[index]
                                                        .doctor!
                                                        .name ??
                                                    '',
                                                style: SolhTextStyles
                                                    .JournalingUsernameText,
                                              ),
                                            ),
                                            Text(
                                                scheduldAppointments[index]
                                                        .scheduledOn! +
                                                    ', ' +
                                                    getDayFromDate(
                                                            scheduldAppointments[
                                                                    index]
                                                                .scheduledOn!)
                                                        .toString(),
                                                style: GoogleFonts.signika(
                                                    color: Color(0xffA6A6A6))),
                                            Text(
                                                scheduldAppointments[index]
                                                        .scheduleTime ??
                                                    '',
                                                style: GoogleFonts.signika(
                                                    color: Color(0xffA6A6A6))),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // Container(
                                        //   alignment: Alignment.centerRight,
                                        //   child: Text(
                                        //     '${scheduldAppointments[index].scheduledOn ?? ''}',
                                        //     style: SolhTextStyles
                                        //         .JournalingDescriptionText,
                                        //   ),
                                        // ),

                                        // Column(
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.center,
                                        //   children: [
                                        //     Text('Starting in',
                                        //         style: GoogleFonts.signika(
                                        //           color: Colors.grey,
                                        //           fontSize: 10,
                                        //         )),
                                        //     Countdown(),
                                        //   ],
                                        // ),
                                        appointmentController
                                                    .userAppointmentModel
                                                    .value
                                                    .scheduldAppointments![
                                                        index]
                                                    .apptFor ==
                                                'doctor'
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        Text('Request Sent',
                                                            style: GoogleFonts
                                                                .signika(
                                                              color: SolhColors
                                                                  .primary_green,
                                                              fontSize: 12,
                                                            )),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Icon(
                                                          Icons.check_circle,
                                                          color: SolhColors
                                                              .primary_green,
                                                          size: 14,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 45,
                                                  )
                                                ],
                                              )
                                            : SolhGreenMiniButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChatProviderScreen(
                                                                name: scheduldAppointments[
                                                                            index]
                                                                        .doctor!
                                                                        .name ??
                                                                    '',
                                                                imageUrl: scheduldAppointments[
                                                                            index]
                                                                        .doctor!
                                                                        .profilePicture ??
                                                                    '',
                                                                sId: scheduldAppointments[
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
                                                      'Session',
                                                      style: SolhTextStyles
                                                          .GreenButtonText,
                                                    ),
                                                    SizedBox(width: 1.w),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
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
      List<CompletedAppointments>? completedAppointments) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Completed',
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
                                                Text(
                                                  completedAppointments[index]
                                                          .doctor!
                                                          .name ??
                                                      '',
                                                  style: SolhTextStyles
                                                      .JournalingUsernameText,
                                                ),
                                                Text(
                                                  '${completedAppointments[index].scheduledOn ?? ''}',
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
}

class Countdown extends StatefulWidget {
  const Countdown({Key? key}) : super(key: key);

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  int second = 300;

  timeManager() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      second--;
      if (second == 0) {
        timer.cancel();
      }

      if (mounted) setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    timeManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text('${(second / 60).floor()}:${60 - (60 - (second % 60))}',
        style: GoogleFonts.signika(color: SolhColors.pink224, fontSize: 16));
  }
}

String getDayFromDate(String date) {
  DateTime dateTime = DateTime.parse(date + " 00:00:00.0");

  return DateFormat('EEEE').format(dateTime);
}
