import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/appointment_controller.dart';
import 'package:solh/ui/screens/chat/chat_provider.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

import '../../../widgets_constants/buttons/custom_buttons.dart';
import '../../../widgets_constants/constants/colors.dart';

class DoctorsAppointmentPage extends StatefulWidget {
  DoctorsAppointmentPage({Key? key}) : super(key: key);

  @override
  State<DoctorsAppointmentPage> createState() => _DoctorsAppointmentPageState();
}

class _DoctorsAppointmentPageState extends State<DoctorsAppointmentPage>
    with SingleTickerProviderStateMixin {
  final AppointmentController appointmentController = Get.find();
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    getAppointment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          getOnlineList(),
          getOfflineList(),
          getCompletedList(),
        ],
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(0), child: getTabBarView()),
    );
  }

  getTabBarView() {
    return Container(
      height: 50,
      child: TabBar(
        controller: _tabController,
        indicatorColor: SolhColors.primary_green,
        labelColor: SolhColors.primary_green,
        unselectedLabelColor: SolhColors.grey,
        tabs: [
          Tab(
            child: Text(
              'Online',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Tab(
            child: Text(
              'Offline',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Tab(
            child: Text(
              'Completed',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  getOnlineList() {
    return Container(
        padding: EdgeInsets.all(8),
        child: Obx(() {
          return appointmentController.isAppointmentLoading.value
              ? Center(
                  child: Container(height: 50, width: 50, child: MyLoader()))
              : appointmentController.doctorAppointmentModel.value
                              .scheduldAppointments ==
                          null ||
                      appointmentController.doctorAppointmentModel.value
                          .scheduldAppointments!.isEmpty
                  ? Center(
                      child: Text('No Scheduled Appointment yet',
                          style: SolhTextStyles.JournalingDescriptionText),
                    )
                  : ListView.builder(
                      itemCount: appointmentController.doctorAppointmentModel
                          .value.scheduldAppointments!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return appointmentController
                                    .doctorAppointmentModel
                                    .value
                                    .scheduldAppointments![index]
                                    .patient !=
                                null
                            ? Padding(
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
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(2.w),
                                          bottomLeft: Radius.circular(2.w),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: appointmentController
                                                  .doctorAppointmentModel
                                                  .value
                                                  .scheduldAppointments![index]
                                                  .patient!
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            child: Text(
                                              appointmentController
                                                      .doctorAppointmentModel
                                                      .value
                                                      .scheduldAppointments![
                                                          index]
                                                      .patient!
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
                                              '${appointmentController.doctorAppointmentModel.value.scheduldAppointments![index].scheduledOn ?? ''}',
                                              style: SolhTextStyles
                                                  .JournalingDescriptionText,
                                            ),
                                          ),
                                          SolhGreenMiniButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChatProviderScreen(
                                                            name: appointmentController
                                                                    .doctorAppointmentModel
                                                                    .value
                                                                    .scheduldAppointments![
                                                                        index]
                                                                    .patient!
                                                                    .name ??
                                                                '',
                                                            imageUrl: appointmentController
                                                                    .doctorAppointmentModel
                                                                    .value
                                                                    .scheduldAppointments![
                                                                        index]
                                                                    .patient!
                                                                    .profilePicture ??
                                                                '',
                                                            sId: appointmentController
                                                                    .doctorAppointmentModel
                                                                    .value
                                                                    .scheduldAppointments![
                                                                        index]
                                                                    .patient!
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
                      });
        }));
  }

  getCompletedList() {
    return Container(
        padding: EdgeInsets.all(8),
        child: Obx(() {
          return appointmentController.isAppointmentLoading.value
              ? Center(
                  child: Container(height: 50, width: 50, child: MyLoader()))
              : appointmentController.doctorAppointmentModel.value
                              .completedAppointments ==
                          null ||
                      appointmentController.doctorAppointmentModel.value
                          .completedAppointments!.isEmpty
                  ? Center(
                      child: Text('No Completed Appointment yet'.tr,
                          style: SolhTextStyles.JournalingDescriptionText),
                    )
                  : ListView.builder(
                      itemCount: appointmentController.doctorAppointmentModel
                          .value.completedAppointments!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return appointmentController
                                    .doctorAppointmentModel
                                    .value
                                    .completedAppointments![index]
                                    .patient !=
                                null
                            ? Padding(
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
                                  child: Row(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(2.w),
                                        bottomLeft: Radius.circular(2.w),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: appointmentController
                                                .doctorAppointmentModel
                                                .value
                                                .completedAppointments![index]
                                                .patient!
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          child: Text(
                                            appointmentController
                                                    .doctorAppointmentModel
                                                    .value
                                                    .completedAppointments![
                                                        index]
                                                    .patient!
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
                                            '${appointmentController.doctorAppointmentModel.value.scheduldAppointments![index].scheduledOn ?? ''}',
                                            style: SolhTextStyles
                                                .JournalingDescriptionText,
                                          ),
                                        ),
                                        SolhGreenBorderMiniButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChatProviderScreen(
                                                          name: appointmentController
                                                                  .doctorAppointmentModel
                                                                  .value
                                                                  .completedAppointments![
                                                                      index]
                                                                  .patient!
                                                                  .name ??
                                                              '',
                                                          imageUrl: appointmentController
                                                                  .doctorAppointmentModel
                                                                  .value
                                                                  .completedAppointments![
                                                                      index]
                                                                  .patient!
                                                                  .profilePicture ??
                                                              '',
                                                          sId: appointmentController
                                                                  .doctorAppointmentModel
                                                                  .value
                                                                  .completedAppointments![
                                                                      index]
                                                                  .patient!
                                                                  .sId ??
                                                              '',
                                                        )));
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'session',
                                                style: SolhTextStyles
                                                    .GreenBorderButtonText,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ]),
                                ),
                              )
                            : Container();
                      });
        }));
  }

  getOfflineList() {
    return Container(
        child: Center(
      child: Text('Not Available Now',
          style: SolhTextStyles.JournalingDescriptionText),
    ));
  }

  Future<void> getAppointment() async {
    await appointmentController.getDoctorAppointments();
  }
}
