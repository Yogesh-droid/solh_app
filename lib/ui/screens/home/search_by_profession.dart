import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/controllers/getHelp/get_help_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/get-help/widgets/specialization_card_with_discount.dart';

class SearchByProfesssionUI extends StatefulWidget {
  SearchByProfesssionUI({super.key});

  @override
  State<SearchByProfesssionUI> createState() => _SearchByProfesssionUIState();
}

class _SearchByProfesssionUIState extends State<SearchByProfesssionUI> {
  GetHelpController getHelpController = Get.find();
  BookAppointmentController bookAppointmentController = Get.find();
  ProfileController profileController = Get.find();

  @override
  void initState() {
    if (getHelpController.getSpecializationModel.value.specializationList ==
        null) {
      getHelpController.getSpecializationList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return getHelpController
                  .getSpecializationModel.value.specializationList !=
              null
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 2.5.w,
                    crossAxisSpacing: 2.5.w,
                    crossAxisCount: 2,
                    childAspectRatio: 2),
                physics: NeverScrollableScrollPhysics(),
                itemCount: getHelpController
                    .getSpecializationModel.value.specializationList!.length,
                shrinkWrap: true,
                itemBuilder: (_, index) => GestureDetector(
                    onTap: () {
                      bookAppointmentController.query = getHelpController
                          .getSpecializationModel
                          .value
                          .specializationList![index]
                          .name;
                      Navigator.pushNamed(context, AppRoutes.viewAllConsultant,
                          arguments: {
                            "slug": getHelpController.getSpecializationModel
                                    .value.specializationList![index].slug ??
                                '',
                            "type": 'specialization',
                            "name": getHelpController.getSpecializationModel
                                    .value.specializationList![index].name ??
                                ''
                          });
                      FirebaseAnalytics.instance.logEvent(
                          name: 'SearhSpecialityTapped',
                          parameters: {'Page': 'GetHelp'});
                    },
                    child: Obx(() =>
                        profileController.myProfileModel.value.body == null
                            ? SizedBox()
                            : SpecializationCardWithDiscount(
                                image: getHelpController
                                        .getSpecializationModel
                                        .value
                                        .specializationList![index]
                                        .displayImage ??
                                    '',
                                name: getHelpController
                                        .getSpecializationModel
                                        .value
                                        .specializationList![index]
                                        .name ??
                                    '',
                                discount: profileController
                                            .myProfileModel
                                            .value
                                            .body!
                                            .userOrganisations!
                                            .isNotEmpty &&
                                        profileController
                                                .myProfileModel
                                                .value
                                                .body!
                                                .userOrganisations!
                                                .first
                                                .status ==
                                            'Approved'
                                    ? getHelpController
                                        .getSpecializationModel
                                        .value
                                        .specializationList![index]
                                        .orgMarketPlaceOffer
                                    : null,
                              ))),
              ),
            )
          : Container();
    });
  }
}
