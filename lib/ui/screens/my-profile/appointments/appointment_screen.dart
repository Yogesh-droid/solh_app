import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/appointment_controller.dart';
import 'package:solh/model/user/user_appointments_model.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import '../../../../widgets_constants/constants/colors.dart';
import '../../../../widgets_constants/loader/my-loader.dart';
import '../../chat/chat.dart';

class AppointmentScreen extends StatelessWidget {
  AppointmentScreen({Key? key}) : super(key: key);
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
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.w),
                                color: SolhColors.white,
                                border: Border.all(
                                  color: SolhColors.green,
                                  width: 0.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(2.w),
                                      bottomLeft: Radius.circular(2.w),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: scheduldAppointments[index]
                                              .doctor!
                                              .profilePicture ??
                                          '',
                                      imageBuilder: (context, imageProvider) =>
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
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
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
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          '${scheduldAppointments[index].scheduledOn ?? ''}',
                                          style: SolhTextStyles
                                              .JournalingDescriptionText,
                                        ),
                                      ),
                                      SolhGreenMiniButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (context) => ChatScreen(
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
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(2.w),
                                      bottomLeft: Radius.circular(2.w),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: completedAppointments[index]
                                              .doctor!
                                              .profilePicture ??
                                          '',
                                      //'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200',
                                      imageBuilder: (context, imageProvider) =>
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
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  Text(
                                    completedAppointments[index].doctor!.name ??
                                        '',
                                    style:
                                        SolhTextStyles.JournalingUsernameText,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          '${completedAppointments[index].scheduledOn ?? ''}',
                                          style: SolhTextStyles
                                              .JournalingDescriptionText,
                                        ),
                                      ),
                                      SolhGreenMiniButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (context) => ChatScreen(
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
