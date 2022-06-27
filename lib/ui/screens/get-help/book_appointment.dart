import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/controllers/getHelp/consultant_controller.dart';
import 'package:solh/model/user/user.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key}) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  ConnectionController controller = Get.find();
  var _bookingController = Get.put(BookAppointmentController());

  @override
  void initState() {
    // TODO: implement initState
    _bookingController.mobileNotextEditingController.text =
        controller.userModel.value.name ?? '';
    _bookingController.emailTextEditingController.text =
        controller.userModel.value.email ?? '';

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        isLandingScreen: false,
        title: Text('Book appointment',
            style: GoogleFonts.signika(color: SolhColors.black)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 49),
          child: Column(
            children: [
              Text(
                'You are about to book an appointment, Please fill the details below',
                style: GoogleFonts.signika(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffA6A6A6),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mobile No.',
                    style: GoogleFonts.signika(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff666666),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffA6A6A6),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextField(
                        controller:
                            _bookingController.mobileNotextEditingController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email-Id.',
                    style: GoogleFonts.signika(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff666666),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffA6A6A6),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextField(
                        controller:
                            _bookingController.emailTextEditingController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Preffered date & time.',
                    style: GoogleFonts.signika(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff666666),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffA6A6A6),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Container(
                        height: 48,
                        child: GetDateAndTime(),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How Can we help ? (optional)',
                    style: GoogleFonts.signika(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff666666),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.17,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffA6A6A6),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 24,
              ),
              BookAppointmentWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class BookAppointmentWidget extends StatelessWidget {
  BookAppointmentWidget({Key? key}) : super(key: key);
  var _controller = Get.put(BookAppointmentController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
    );
  }
}

class GetDateAndTime extends StatefulWidget {
  const GetDateAndTime({Key? key}) : super(key: key);

  @override
  State<GetDateAndTime> createState() => _GetDateAndTimeState();
}

class _GetDateAndTimeState extends State<GetDateAndTime> {
  BookAppointmentController _controller = Get.put(BookAppointmentController());

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.selectedDay.value = '';
    _controller.selectedTimeSlot.value = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return DayPicker();
          });
    }, child: Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Today' == _controller.selectedDay.value
              ? 'Today'
              : 'Upcoming ${_controller.selectedDay.value}'),
          Text(_controller.selectedTimeSlot.value)
        ],
      );
    }));
  }
}

class DayPicker extends StatefulWidget {
  const DayPicker({Key? key}) : super(key: key);

  @override
  State<DayPicker> createState() => _DayPickerState();
}

class _DayPickerState extends State<DayPicker> {
  var _controller = Get.put(BookAppointmentController());

  Map day = {
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': false,
  };

  Map timeSlot = {
    '10:00-10:30': false,
    '11:00-11:30': false,
    '12:00-12:30': false,
    '13:00-13:30': false,
    '14:00-14:30': false,
    '15:00-15:30': false,
  };

  List<String> days = [];
  List<String> updatedList = [];
  // getUpcomingMap() {
  //   var date = DateTime.now();
  //   String today = DateFormat('EEEE').format(date);

  //   Map newMap = {};
  //   var index;
  //   for (var i = 0; i < 6; i++) {
  //     if (day.keys.elementAt(i) == today) {
  //       index = i;
  //       break;
  //     }
  //   }
  //   print(index);
  //   for (var i = index; i < 6; i++) {
  //     int count = 1;
  //     if (day.keys.elementAt(i) == today) {
  //       newMap['Today'] = false;
  //     } else {
  //       newMap[day.keys.elementAt(i)] = false;
  //     }

  //     if (count < 5 && i == 5) {
  //       print('it ran');
  //       print(count);
  //       i = 0;
  //     }

  //     if (day.keys.elementAt(index) == day.keys.elementAt(i + 1)) {
  //       print('it ran2');
  //       print(i);
  //       break;
  //     }
  //     count = count++;
  //   }

  //   print(newMap.toString());
  //   return newMap;
  // }

  @override
  void initState() {
    // TODO: implement initState
    getUpcomingMap();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print(
        getdateTime(_controller.selectedDay, _controller.selectedTimeSlot, 0));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                child:
                    SvgPicture.asset('assets/images/canclewithbackgroung.svg'),
              )
            ],
          ),
        ),
        SizedBox(
          height: 50,
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
                    onTap: () {
                      _controller.selectedDay.value = days[index];
                      print('+++++' + _controller.selectedDay.value);
                      print('----' + days[index]);
                    },
                    child: Obx(() {
                      return Container(
                        decoration: BoxDecoration(
                            color: _controller.selectedDay.value == days[index]
                                ? SolhColors.green
                                : Colors.white,
                            border: Border.all(color: SolhColors.green),
                            borderRadius: BorderRadius.circular(18)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            // child: Text(
                            //   getUpcomingMap().keys.elementAt(index),
                            // ),
                            child: Text(
                              days[index],
                              style: GoogleFonts.montserrat(
                                color:
                                    _controller.selectedDay.value == days[index]
                                        ? SolhColors.white
                                        : SolhColors.green,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              })),
        ),
        SizedBox(
          height: 40,
        ),
        Obx(() {
          return Wrap(
            children: timeSlot.keys.map((e) {
              return InkWell(
                onTap: () {
                  _controller.selectedTimeSlot.value = e;
                  print(e + "++" + _controller.selectedTimeSlot.value);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        color: _controller.selectedTimeSlot.value == e
                            ? SolhColors.green
                            : SolhColors.white,
                        border: Border.all(color: SolhColors.green),
                        borderRadius: BorderRadius.circular(18)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        e,
                        style: GoogleFonts.montserrat(
                          color: _controller.selectedTimeSlot.value == e
                              ? SolhColors.white
                              : SolhColors.green,
                        ),
                      )),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        })
      ],
    );
  }

  void getUpcomingMap() {
    updatedList = [];
    _controller.days = days = [];
    for (int i = 0; i < 7; i++) {
      updatedList.add(
          DateFormat('EEEE').format(DateTime.now().add(Duration(days: i))));
    }
    updatedList.forEach((element) {
      if (DateFormat('EEEE').format(DateTime.now()) == element) {}
      if (element != 'Sunday') {
        if (DateFormat('EEEE').format(DateTime.now()) == element) {
          days.add('Today');
        } else {
          days.add(element);
        }
      }
    });

    _controller.days = days;
  }
}

class BookAppointmentPopup extends StatelessWidget {
  BookAppointmentPopup({Key? key}) : super(key: key);

  BookAppointmentController _controller = Get.find();

  ConsultantController _consultantController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Booking appointment'),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.17,
        child: Column(
          children: [
            Text('You are about to book an appointment with :'),
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
              _controller.selectedDay.value +
                  " ," +
                  _controller.selectedTimeSlot.value,
              style: GoogleFonts.montserrat(
                color: SolhColors.green,
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
                    border: Border.all(color: SolhColors.green),
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
                      _controller.selectedDay, _controller.selectedTimeSlot, 0),
                  'end': getdateTime(
                      _controller.selectedDay, _controller.selectedTimeSlot, 1),
                  'from': _controller.selectedTimeSlot.split('-')[0],
                  'to': _controller.selectedTimeSlot.split('-')[1],
                  "type": "app",
                  "duration": "30"
                };
                String response = await _controller.bookAppointment(body);

                Navigator.of(context).pop();

                if (response == 'Successfully created appointment.') {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return appointmentConfirmationPopup(response);
                      });
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                    color: SolhColors.green,
                    border: Border.all(color: SolhColors.green),
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
}

validator(
    {required String mobile_no,
    required email,
    required selected_day,
    required time_slot}) {
  if (mobile_no.isEmpty) {
    return 'Mobile no. is required';
  }
  if (email.isEmpty) {
    return 'Email is required';
  }
  if (selected_day == '') {
    return 'You need to select day of appointment.';
  }
  if (time_slot == '') {
    return 'You need to select time slot of appointment.';
  } else {
    return true;
  }
}

getdateTime(selectedDay, selectedSlot, itemNoinList) {
  BookAppointmentController _controller = Get.find();

  var now = new DateTime.now();

  getDate() {
    if (selectedDay == 'Today') {
      return DateFormat('yyyy-MM-dd').format(now);
    } else if (_controller.days!.indexOf(selectedDay.toString()) <
        _controller.days!
            .indexOf(DateFormat('yyyy-MM-dd').format(now).toString())) {
      return now.add(Duration(
          days: _controller.days!.indexOf(selectedDay.toString()) + 1));
    } else {
      return now.add(
          Duration(days: _controller.days!.indexOf(selectedDay.toString())));
    }
  }

  getTime() {
    return selectedSlot.toString().split('-');
  }

  return DateFormat('yy-MM-dd').format(getDate() as DateTime) +
      'T' +
      getTime()[itemNoinList].toString() +
      ':00';
}

Widget appointmentConfirmationPopup(data) {
  return AlertDialog(
    content: data == 'Successfully created appointment.'
        ? Container(
            child: Row(
              children: [
                Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text('Successfully created appointment.',
                      textAlign: TextAlign.center),
                )
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
                Expanded(child: Text('   Oops! Something went wrong'))
              ],
            ),
          ),
  );
}




//  if (data == 'Successfully created appointment.') {
//     return Container(
//       child: Row(
//         children: [
//           Icon(Icons.check),
//           Text('   Successfully created appointment.')
//         ],
//       ),
//     );
//   } else {
//     return Container(
//       child: Row(
//         children: [Icon(Icons.check), Text('   Oops! Something went wrong')],
//       ),
//     );
//   }