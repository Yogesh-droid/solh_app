import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

import '../../../../services/utility.dart';

class TimeSlotBox extends StatelessWidget {
  TimeSlotBox({Key? key, required this.onTap}) : super(key: key);
  final BookAppointmentController bookAppointmentController = Get.find();
  final Function(String date) onTap;

  @override
  Widget build(BuildContext context) {
    return Obx(() => bookAppointmentController.loadingTimeSlots.value
        ? Center(
            child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: MyLoader(),
          ))
        : Wrap(
            children: bookAppointmentController.timeSlotList.value
                .map((element) => getTimeSlotcontainer(element))
                .toList(),
          ));
  }

  Widget getTimeSlotcontainer(element) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0, bottom: 14),
      child: InkWell(
        onTap: bookAppointmentController.bookedTimeSlots.value.contains(element)
            ? () {
                Utility.showToast('This time slot is not available');
                return;
              }
            : () {
                onTap(element);
              },
        child: Container(
          height: 32,
          width: 95,
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
          decoration: BoxDecoration(
              color: bookAppointmentController.bookedTimeSlots.value
                      .contains(element)
                  ? SolhColors.white
                  : bookAppointmentController.selectedTimeSlotN.value == element
                      ? SolhColors.primary_green
                      : SolhColors.white,
              border: Border.all(
                  color: bookAppointmentController.bookedTimeSlots.value
                          .contains(element)
                      ? SolhColors.grey_2
                      : bookAppointmentController.selectedTimeSlotN.value ==
                              element
                          ? SolhColors.white
                          : SolhColors.dark_grey),
              borderRadius: BorderRadius.circular(16)),
          child: Text(element,
              style: SolhTextStyles.CTA.copyWith(
                  color: bookAppointmentController.bookedTimeSlots.value
                          .contains(element)
                      ? SolhColors.grey_2
                      : bookAppointmentController.selectedTimeSlotN.value ==
                              element
                          ? SolhColors.white
                          : SolhColors.dark_grey)),
        ),
      ),
    );
  }
}
