/* import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/controllers/getHelp/consultant_controller.dart';
import 'package:solh/controllers/profile/appointment_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class BookAppointmentWidget extends StatelessWidget {
  BookAppointmentWidget({Key? key}) : super(key: key);
  //var _controller = Get.put(BookAppointmentController());
  BookAppointmentController _controller = Get.find();

  ConsultantController _consultantController = Get.find();

  AppointmentController _appointmentController = Get.find();

  @override
  Widget build(BuildContext context) {
    /* return InkWell(
      onTap: () {
        var value = validator(
            mobile_no: _controller.mobileNotextEditingController.text,
            email: _controller.emailTextEditingController.text,
            selected_day: _controller.selectedDay.value,
            time_slot: _controller.selectedTimeSlot.value);

        print(value.toString());
        if (value is bool) {
          showDialog(
              context: context,
              builder: (context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: BookAppointmentPopup());
              });
        } else {
          final snackBar = SnackBar(
            content: Text(value!.toString()),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Container(
        height: 48,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: SolhColors.green, borderRadius: BorderRadius.circular(24)),
        child: Center(
          child: Text(
            'Book Appointment',
            style: GoogleFonts.signika(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: SolhColors.white),
          ),
        ),
      ),
    ); */
    return Obx(() {
      return Container(
        child: _controller.isTimeSlotAdded.value != ''
            ? (_controller.isTimeSlotAdded.value == 'true'
                ? SolhGreenButton(
                    height: 48,
                    child: Text('Book Appointment'),
                    onPressed: () {
                      var value = validator(
                          mobile_no:
                              _controller.mobileNotextEditingController.text,
                          email: _controller.emailTextEditingController.text,
                          selected_day: _controller.selectedDay.value,
                          time_slot: _controller.selectedTimeSlot.value);

                      print(value.toString());
                      if (value is bool) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: BookAppointmentPopup());
                            });
                      } else {
                        Utility.showToast(value);
                      }
                    },
                  )
                : SolhGreenButton(
                    child: Text('Send request'),
                    onPressed: () async {
                      var value = validator(
                          mobile_no:
                              _controller.mobileNotextEditingController.text,
                          email: _controller.emailTextEditingController.text,
                          selected_day: _controller.selectedDay.value,
                          time_slot: _controller.selectedTimeSlot.value);

                      if (value is bool) {
                        Map<String, dynamic> body = {
                          'provider': _consultantController
                                      .consultantModelController
                                      .value
                                      .provder!
                                      .type ==
                                  'provider'
                              ? _consultantController
                                  .consultantModelController.value.provder!.sId
                              : '',
                          'doctor': _consultantController
                                      .consultantModelController
                                      .value
                                      .provder!
                                      .type ==
                                  'doctor'
                              ? _consultantController
                                  .consultantModelController.value.provder!.sId
                              : '',
                          'start': getdateTime(
                              _controller.selectedDay,
                              _controller.selectedTimeSlot,
                              0,
                              _controller.selectedDate.value),
                          'end': getdateTime(
                              _controller.selectedDay,
                              _controller.selectedTimeSlot,
                              1,
                              _controller.selectedDate.value),
                          'seekerEmail':
                              _controller.emailTextEditingController.text,
                          'from': _controller.selectedTimeSlot.split('-')[0],
                          'to': _controller.selectedTimeSlot.split('-')[1],
                          "type": "app",
                          "duration": "30",
                          "label":
                              _controller.catTextEditingController.value.text,
                          "concern": _controller.query ?? ''
                        };
                        var val = await _controller.bookAppointment(body);

                        if (val == 'Successfully created appointment.') {
                          await _appointmentController.getUserAppointments();

                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();

                          Navigator.pushNamed(
                              context, AppRoutes.appointmentPage,
                              arguments: {});

                          final snackBar = SnackBar(
                            content: Text(
                              'Appointment request sent.',
                            ),
                            action: SnackBarAction(
                              label: '',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } else {
                        Utility.showToast(value);
                      }
                    }))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
      );
    });
  }
}

class DayPicker extends StatefulWidget {
  const DayPicker({Key? key}) : super(key: key);

  @override
  State<DayPicker> createState() => _DayPickerState();
}

class _DayPickerState extends State<DayPicker> {
  BookAppointmentController _controller = Get.find();
  ConsultantController _consultantController = Get.find();

  List<DateTime> days = [];
  List<DateTime> updatedList = [];

  @override
  void initState() {
    getUpcomingMap();

    Future.delayed(Duration(microseconds: 10), () {
      getTodaysSlots();
      print('it ran');
    });

    super.initState();
  }

  @override
  void dispose() {
    Future.delayed(Duration(microseconds: 10), () {
      if (DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()) +
                  ' ' +
                  _controller.selectedTimeSlot.split('-')[1])
              .isBefore(DateTime.now()) &&
          _controller.selectedDay == 'Today') {
        _controller.selectedTimeSlot.value = '';
      }
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select time Slot',
                  style: GoogleFonts.signika(fontSize: 16),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: SvgPicture.asset(
                      'assets/images/canclewithbackgroung.svg'),
                )
              ],
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Container(
            height: 36,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: days.length,
                itemBuilder: ((context, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () async {
                          //_controller.selectedDay.value = days[index];
                          _controller.selectedDay.value =
                              DateFormat('EEEE').format(days[index]);
                          _controller.selectedDate.value = days[index];
                          setState(() {});
                          await _controller.getTimeSlot(
                              date:
                                  DateFormat('yyyy-MM-dd').format(days[index]),
                              providerId: _consultantController
                                  .consultantModelController
                                  .value
                                  .provder!
                                  .sId);

                          print('+++++' + _controller.selectedDay.value);
                          print(
                              '----' + DateFormat('EEEE').format(days[index]));
                        },
                        child: Obx(() => Container(
                              decoration: BoxDecoration(
                                  color: _controller.selectedDay.value ==
                                          DateFormat('EEEE').format(days[index])
                                      ? SolhColors.primary_green
                                      : Colors.white,
                                  border: Border.all(
                                      color: SolhColors.primary_green),
                                  borderRadius: BorderRadius.circular(18)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  // child: Text(
                                  //   getUpcomingMap().keys.elementAt(index),
                                  // ),
                                  child: Text(
                                    DateFormat('EEEE').format(days[index]) ==
                                            DateFormat('EEEE')
                                                .format(DateTime.now())
                                        ? 'Today'
                                        : DateFormat('EEEE')
                                            .format(days[index]),
                                    style: GoogleFonts.montserrat(
                                      color: _controller.selectedDay.value ==
                                              DateFormat('EEEE')
                                                  .format(days[index])
                                          ? SolhColors.white
                                          : SolhColors.primary_green,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ));
                })),
          ),
          SizedBox(
            height: 2.h,
          ),
          Obx(() {
            return _controller.loadingTimeSlots.value
                ? Center(
                    child: Text(
                    'Loading Time Slots...',
                    style: TextStyle(
                      color: SolhColors.primary_green,
                    ),
                  ))
                : _controller.timeSlotList.isEmpty
                    ? Center(
                        child: Text(
                        'No Time Slots Available',
                        style: TextStyle(
                          color: SolhColors.grey_2,
                        ),
                      ))
                    : Wrap(
                        children: _controller.timeSlotList.map((e) {
                          return
                              // DateTime.parse(
                              //             DateFormat('yyyy-MM-dd').format(DateTime.now()) +
                              //                 ' ' +
                              //                 e.split('-')[1])
                              //         .isBefore(DateTime.now())
                              //     //      &&
                              //     // _controller.selectedDay == 'Today'
                              //     ? Container(
                              //         child: Padding(
                              //           padding: const EdgeInsets.symmetric(
                              //               horizontal: 8, vertical: 8),
                              //           child: Container(
                              //             width: 110,
                              //             decoration: BoxDecoration(
                              //                 color: Colors.grey,
                              //                 border: Border.all(color: SolhColors.green),
                              //                 borderRadius: BorderRadius.circular(18)),
                              //             child: Padding(
                              //               padding: const EdgeInsets.all(8.0),
                              //               child: Center(
                              //                   child: Text(
                              //                 e,
                              //                 style: GoogleFonts.montserrat(
                              //                   color: SolhColors.green,
                              //                 ),
                              //               )),
                              //             ),
                              //           ),
                              //         ),
                              //       )
                              //:
                              InkWell(
                            onTap: () {
                              if (_controller.bookedTimeSlots
                                  .contains(e.toString())) {
                                Utility.showToast(
                                    'This time slot is not available');
                                return;
                              }
                              _controller.selectedTimeSlot.value = e;
                              print(e +
                                  "++" +
                                  _controller.selectedTimeSlot.value);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: Container(
                                width: 110,
                                decoration: BoxDecoration(
                                    color: _controller.bookedTimeSlots
                                            .contains(e.toString())
                                        ? SolhColors.dark_grey
                                        : _controller.selectedTimeSlot.value ==
                                                e
                                            ? SolhColors.primary_green
                                            : SolhColors.white,
                                    border: Border.all(
                                        color: SolhColors.primary_green),
                                    borderRadius: BorderRadius.circular(18)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text(
                                    e,
                                    style: GoogleFonts.montserrat(
                                      color:
                                          _controller.selectedTimeSlot.value ==
                                                      e ||
                                                  _controller.bookedTimeSlots
                                                      .contains(e.toString())
                                              ? SolhColors.white
                                              : SolhColors.primary_green,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
          }),
          Expanded(
            child: SizedBox(),
          ),
          Obx(() {
            return SizedBox(
                width: 80.w,
                child: _controller.loadingTimeSlots.value
                    ? Container()
                    : SolhGreenButton(
                        child: Text("Continue"),
                        onPressed: () {
                          if (_controller.selectedTimeSlot.isEmpty) {
                            Utility.showToast('Please select time slot');
                            return;
                          }
                          _controller.showBookingDetail.value = true;
                        },
                      ));
          }),
          SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }

  void getUpcomingMap() {
    updatedList = [];
    _controller.days = days = [];
    for (int i = 0; i < 7; i++) {
      updatedList.add(DateTime.now().add(Duration(days: i)));
    }
    updatedList.forEach((element) {
      // if (DateTime.now() == element) {}
      days.add(element);
      // if (DateFormat('EEEE').format(element) != 'Sunday') {
      //   // days.add(element);

      // }
    });

    // for (int i = 0; i < 7; i++) {
    //   updatedList.add(
    //       DateFormat('EEEE').format(DateTime.now().add(Duration(days: i))));
    // }
    // updatedList.forEach((element) {
    //   if (DateFormat('EEEE').format(DateTime.now()) == element) {}
    //   if (element != 'Sunday') {
    //     if (DateFormat('EEEE').format(DateTime.now()) == element) {
    //       days.add('Today');
    //     } else {
    //       days.add(element);
    //     }
    //   }
    // });

    _controller.days = days;
  }

  void getTodaysSlots() {
    _controller.selectedDay = DateFormat('EEEE').format(DateTime.now()).obs;
    _controller.selectedDate.value = DateTime.now();
    _controller.getTimeSlot(
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        providerId:
            _consultantController.consultantModelController.value.provder!.sId);
  }
}

class BookAppointmentPopup extends StatelessWidget {
  BookAppointmentPopup({Key? key}) : super(key: key);

  BookAppointmentController _controller = Get.find();

  ConsultantController _consultantController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm Appointment'),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.14,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text('You are booking an appointment with'),
            SizedBox(
              height: 7,
            ),
            Text(
              _controller.doctorName ?? '',
              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              '${_controller.selectedDay.value}, ${DateFormat('dd-MMM-yy').format(_controller.selectedDate.value)}' +
                  ' at' ' ' +
                  _controller.selectedTimeSlot.value,
              style: GoogleFonts.montserrat(
                color: SolhColors.primary_green,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                    border: Border.all(color: SolhColors.primary_green),
                    borderRadius: BorderRadius.circular(24)),
                child: Center(
                  child: Text('Cancel'),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                Map<String, dynamic> body = {
                  'provider': _consultantController
                              .consultantModelController.value.provder!.type ==
                          'provider'
                      ? _consultantController
                          .consultantModelController.value.provder!.sId
                      : '',
                  'doctor': _consultantController
                              .consultantModelController.value.provder!.type ==
                          'doctor'
                      ? _consultantController
                          .consultantModelController.value.provder!.sId
                      : '',
                  'start': getdateTime(
                      _controller.selectedDay,
                      _controller.selectedTimeSlot,
                      0,
                      _controller.selectedDate.value),
                  'end': getdateTime(
                      _controller.selectedDay,
                      _controller.selectedTimeSlot,
                      1,
                      _controller.selectedDate.value),
                  'seekerEmail': _controller.emailTextEditingController.text,
                  // 'seekerMobile': _controller.mobileNotextEditingController.text,
                  'from': _controller.selectedTimeSlot.split('-')[0],
                  'to': _controller.selectedTimeSlot.split('-')[1],
                  "type": "app",
                  "duration": "30",
                  "label": _controller.catTextEditingController.value.text,
                  "concern": _controller.query ?? ''
                };
                // Navigator.pop(context);
                Utility.showLoader(context);
                // await Future.delayed(Duration(seconds: 2), () {});
                // await Future.delayed(Duration(seconds: 2), () {});
                Map<String, dynamic> response =
                    await _controller.bookAppointment(body);
                Get.find<AppointmentController>().getUserAppointments();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.pushNamed(context, AppRoutes.appointmentPage,
                    arguments: {});

                showDialog(
                    context: context,
                    builder: (context) {
                      Future.delayed(Duration(seconds: 1), () {
                        Navigator.pop(context);
                        if (response['success']) {}
                      });
                      return appointmentConfirmationPopup(
                        response,
                      );
                    });
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                    color: SolhColors.primary_green,
                    border: Border.all(color: SolhColors.primary_green),
                    borderRadius: BorderRadius.circular(24)),
                child: Center(
                  child: Text('Confirm',
                      style: GoogleFonts.montserrat(
                        color: SolhColors.white,
                      )),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget appointmentConfirmationPopup(
    data,
  ) {
    return AlertDialog(
      content: data == 'Successfully created appointment.'
          ? Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Appointment Booked'),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Text(
                      'Your appointment has been booked please pay attention to the app notifications, we will notify you 30 min before the scheduled appointment',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.signika(color: Color(0xffA6A6A6)),
                    ),
                  ),
                  Text(
                      '${_controller.selectedDay},${_controller.selectedTimeSlot}')
                ],
              ),
            )
          : Container(
              child: Row(
                children: [
                  Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(child: Text('Oops! Something went wrong'))
                ],
              ),
            ),
    );
  }
}

validator(
    {required String mobile_no,
    required email,
    required selected_day,
    required time_slot}) {
  BookAppointmentController _controller = Get.find();
  if (mobile_no.isEmpty) {
    return 'Mobile no. is required';
  }
  if (email.isEmpty) {
    return 'Email is required';
  }

  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email)) {
    return 'Enter a valid email';
  }

  if (selected_day == '') {
    return 'You need to select day of appointment.';
  }
  if (time_slot == '') {
    return 'You need to select time slot of appointment.';
  } else {
    return true;
  }
}*/

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/getHelp/book_appointment.dart';

getdateTime(selectedDay, selectedSlot, itemNoinList, DateTime selectedDate) {
  BookAppointmentController _controller = Get.find();

  var now = new DateTime.now();

  getDate() {
    if (selectedDay == DateFormat('EEEE').format(now)) {
      return DateFormat('yyyy-MM-dd').format(now);
    } else if (_controller.days!.indexOf(selectedDay.toString()) >
        _controller.days!.indexOf(_controller.days!.indexOf('Saturday'))) {
      return now.add(Duration(
          days: _controller.days!.indexOf(selectedDay.toString()) + 1));
    } else {
      return now.add(Duration(
          days: _controller.days!.indexOf(selectedDay.toString()) + 1));
    }
  }

  getTime() {
    return selectedSlot.toString().split('-');
  }

  print(DateFormat('yyyy-MM-dd').format(selectedDate) +
      'T' +
      getTime()[itemNoinList].toString() +
      ':00');
  return DateFormat('yyyy-MM-dd').format(selectedDate) +
      'T' +
      getTime()[itemNoinList].toString() +
      ':00';
}
