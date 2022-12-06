import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/ui/screens/get-help/widgets/solh_week_cal.dart';
import 'package:solh/ui/screens/get-help/widgets/time_slot_box.dart';
import '../../../../controllers/getHelp/consultant_controller.dart';
import '../../../../widgets_constants/buttons/custom_buttons.dart';
import '../../../../widgets_constants/constants/colors.dart';
import '../../../../widgets_constants/constants/textstyles.dart';

class BookAppoinmentSheet extends StatelessWidget {
  BookAppoinmentSheet({Key? key}) : super(key: key);
  final BookAppointmentController bookAppointmentController = Get.find();
  final ConsultantController _controller = Get.find();
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select',
                  style: SolhTextStyles.QS_body_1_bold.copyWith(
                      color: SolhColors.black),
                ),
                Container(
                  height: 10,
                  width: 40,
                  decoration: BoxDecoration(
                      color: SolhColors.grey_3,
                      borderRadius: BorderRadius.circular(5)),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
          Container(
            color: SolhColors.grey239,
            height: 1,
          ),
          Container(
            height: 530,
            child: PageView(
              controller: pageController,
              children: [getBookcalenderWidget(), getBookingInputWidget()],
            ),
          )
        ],
      ),
    );
  }

  Widget getBookcalenderWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Book Anonymously',
                        style: SolhTextStyles.QS_body_2_bold.copyWith(
                            color: SolhColors.dark_grey),
                      ),
                      Text(
                        'Your Identity will not be revealed to your Counselor',
                        style: SolhTextStyles.QS_cap_semi.copyWith(
                            color: SolhColors.Grey_1),
                      ),
                    ],
                  ),
                ),
                Obx(() => Switch(
                    value: _controller.isAnonymousBookingEnabled.value,
                    onChanged: (value) {
                      _controller.isAnonymousBookingEnabled.value =
                          !_controller.isAnonymousBookingEnabled.value;
                    })),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Day',
                    style: SolhTextStyles.QS_body_2_bold,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SolhWeekCalender(onTap: (dateTime) {
                    bookAppointmentController.selectedDayForTimeSlot.value =
                        dateTime.day;
                    bookAppointmentController.getTimeSlot(
                        providerId: _controller
                            .consultantModelController.value.provder!.sId,
                        date: DateFormat('yyyy-MM-dd').format(dateTime));
                  }),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Select Time',
                    style: SolhTextStyles.QS_body_2_bold,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TimeSlotBox(
                    onTap: (value) {
                      bookAppointmentController.selectedTimeSlotN.value = value;
                    },
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SolhGreenButton(
                height: 48,
                onPressed: () {
                  pageController.animateToPage(1,
                      duration: Duration(seconds: 1), curve: Curves.decelerate);
                },
                child: Text(
                  'Next',
                  style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
                )),
          )
        ],
      ),
    );
  }

  Widget getBookingInputWidget() {
    return SingleChildScrollView(
      child: Column(),
    );
  }
}
