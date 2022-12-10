import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/get-help/widgets/solh_week_cal.dart';
import 'package:solh/ui/screens/get-help/widgets/time_slot_box.dart';
import 'package:solh/widgets_constants/text_field_styles.dart';
import '../../../../controllers/getHelp/consultant_controller.dart';
import '../../../../widgets_constants/buttons/custom_buttons.dart';
import '../../../../widgets_constants/constants/colors.dart';
import '../../../../widgets_constants/constants/textstyles.dart';

class BookAppoinmentSheet extends StatelessWidget {
  BookAppoinmentSheet({Key? key, required this.onContinueBtnPressed})
      : super(key: key);
  final Function() onContinueBtnPressed;
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
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                getBookcalenderWidget(context),
                getBookingInputWidget(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getBookcalenderWidget(BuildContext context) {
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
                    bookAppointmentController.selectedTimeSlotN.value = '';
                    bookAppointmentController.selectedDayForTimeSlot.value =
                        dateTime.day;
                    bookAppointmentController.selectedDate.value = dateTime;
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
                width: MediaQuery.of(context).size.width,
                onPressed: () {
                  if (bookAppointmentController
                      .selectedTimeSlotN.value.isEmpty) {
                    Utility.showToast('Please choose a time slot');
                    return;
                  }
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

  Widget getBookingInputWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email-Id',
            style: SolhTextStyles.QS_caption_bold,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            color: SolhColors.light_Bg,
            height: 48,
            child: TextField(
              decoration: TextFieldStyles.greenF_greenBroadUF_4R(
                      hintText: 'John@email.com')
                  .copyWith(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: SolhColors.primary_green)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: SolhColors.primary_green)),
                      fillColor: SolhColors.light_Bg,
                      hintStyle: SolhTextStyles.QS_body_2.copyWith(
                          color: SolhColors.black)),
              controller: bookAppointmentController.emailTextEditingController,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'How Can we help ? (optional)',
            style: SolhTextStyles.QS_caption_bold,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 100,
            color: SolhColors.light_Bg,
            child: TextField(
              controller: bookAppointmentController.descTextEditingController,
              maxLengthEnforcement: MaxLengthEnforcement.none,
              maxLines: 4,
              decoration: TextFieldStyles.greenF_noBorderUF_4R(
                      hintText: 'Message, symptoms, etc')
                  .copyWith(
                      contentPadding: EdgeInsets.all(16),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintStyle: SolhTextStyles.QS_body_2.copyWith(
                          color: SolhColors.grey_2)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Preffered Date & Time',
            style: SolhTextStyles.QS_caption_bold,
          ),
          SizedBox(height: 5),
          InkWell(
            onTap: () {
              pageController.previousPage(
                  duration: Duration(seconds: 1), curve: Curves.ease);
            },
            child: Container(
              padding: EdgeInsets.all(16),
              height: 48,
              color: SolhColors.light_Bg,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(
                        DateFormat('EE, dd MMM yyyy').format(
                            bookAppointmentController.selectedDate.value),
                        style: SolhTextStyles.QS_body_2.copyWith(
                            color: SolhColors.black),
                      )),
                  Obx(() => Text(
                      bookAppointmentController.selectedTimeSlotN.value,
                      style: SolhTextStyles.CTA
                          .copyWith(color: SolhColors.primary_green)))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SolhGreenButton(
              height: 48,
              width: MediaQuery.of(context).size.width,
              onPressed: onContinueBtnPressed,
              child: Text(
                'Continue',
                style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
              ))
        ],
      ),
    );
  }
}
