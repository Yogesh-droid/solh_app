import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class SolhWeekCalender extends StatelessWidget {
  SolhWeekCalender({Key? key, required this.onTap}) : super(key: key);
  final BookAppointmentController bookAppointmentController = Get.find();
  final Function(DateTime) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: getDatesOfWeek()
              .map((e) => Padding(
                  padding:
                      const EdgeInsets.only(top: 8, bottom: 8, right: 16.0),
                  child: Obx(
                    () => InkWell(
                      onTap: () {
                        onTap(e);
                      },
                      child: Container(
                        width: 56,
                        decoration: BoxDecoration(
                            color: bookAppointmentController
                                        .selectedDayForTimeSlot.value ==
                                    e.day
                                ? SolhColors.primary_green
                                : SolhColors.card,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 0),
                                  blurStyle: BlurStyle.outer,
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  color: Color.fromRGBO(0, 0, 0, 0.15)),
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              e.day == DateTime.now().day
                                  ? 'Today'
                                  : DateFormat('EE').format(e),
                              style: SolhTextStyles.QS_cap_semi.copyWith(
                                color: bookAppointmentController
                                            .selectedDayForTimeSlot.value ==
                                        e.day
                                    ? SolhColors.white
                                    : SolhColors.dark_grey,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(e.day.toString(),
                                style: SolhTextStyles.QS_cap_semi.copyWith(
                                  color: bookAppointmentController
                                              .selectedDayForTimeSlot.value ==
                                          e.day
                                      ? SolhColors.white
                                      : SolhColors.dark_grey,
                                ))
                          ],
                        ),
                      ),
                    ),
                  )))
              .toList()),
    );
  }

  List<DateTime> getDatesOfWeek() {
    List<DateTime> daysList = [];
    DateTime now = DateTime.now();
    for (var i = 0; i < 7; i++) {
      daysList.add(now.add(Duration(days: i)));
    }
    return daysList;
  }
}
