import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class BookAppointment extends StatelessWidget {
  const BookAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
      ),
    );
  }
}

class BookAppointmentWidget extends StatelessWidget {
  const BookAppointmentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: BookAppointmentPopup());
            });
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
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return DayPicker();
              });
        },
        child: Container());
  }
}

class DayPicker extends StatefulWidget {
  const DayPicker({Key? key}) : super(key: key);

  @override
  State<DayPicker> createState() => _DayPickerState();
}

class _DayPickerState extends State<DayPicker> {
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

  getUpcomingMap() {
    var date = DateTime.now();
    String today = DateFormat('EEEE').format(date);

    Map newMap = {};
    var index;
    for (var i = 0; i < 6; i++) {
      if (day.keys.elementAt(i) == today) {
        index = i;
        break;
      }
    }
    print(index);
    for (var i = index; i < 6; i++) {
      int count = 1;
      if (day.keys.elementAt(i) == today) {
        newMap['Today'] = false;
      } else {
        newMap[day.keys.elementAt(i)] = false;
      }

      if (count < 5 && i == 5) {
        print('it ran');
        print(count);
        i = 0;
      }

      if (day.keys.elementAt(index) == day.keys.elementAt(i + 1)) {
        print('it ran2');
        print(i);
        break;
      }
      count = count++;
    }

    print(newMap.toString());
    return newMap;
  }

  @override
  void initState() {
    // TODO: implement initState
    getUpcomingMap();
    super.initState();
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
              itemCount: getUpcomingMap().length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: SolhColors.green),
                        borderRadius: BorderRadius.circular(18)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          getUpcomingMap().keys.elementAt(index),
                        ),
                      ),
                    ),
                  ),
                );
              })),
        ),
        SizedBox(
          height: 40,
        ),
        Wrap(
          children: timeSlot.keys.map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                    border: Border.all(color: SolhColors.green),
                    borderRadius: BorderRadius.circular(18)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text(e)),
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}

class BookAppointmentPopup extends StatelessWidget {
  const BookAppointmentPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Booking appointment'),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          children: [
            Text('You are about to book an appointment with'),
            Text('Dr. Priyanka Trivadi(PhD)'),
            Text('')
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                  border: Border.all(color: SolhColors.green),
                  borderRadius: BorderRadius.circular(24)),
              child: Center(
                child: Text('Cancel'),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                  color: SolhColors.green,
                  border: Border.all(color: SolhColors.green),
                  borderRadius: BorderRadius.circular(24)),
              child: Center(child: Text('Confirm')),
            )
          ],
        )
      ],
    );
  }
}
