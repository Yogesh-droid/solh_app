import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(
          'Details',
          style: GoogleFonts.signika(color: Colors.black),
        ),
        isLandingScreen: false,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GoalNameStack(),
              SizedBox(
                height: 24,
              ),
              TaskList(),
              SizedBox(
                height: 40,
              ),
              DoneButton(),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoalNameStack extends StatelessWidget {
  const GoalNameStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            height: 40.h,
            width: 100.w,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image(
                image: NetworkImage(
                    'https://img.freepik.com/free-photo/human-hand-holding-cigarette-world-no-tobacco-day-concept_1150-44244.jpg?w=740&t=st=1656577005~exp=1656577605~hmac=7984259e30c61238f69760608f60cdbc1a7878f12ced2cd1404d736f72bc6713'),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 12.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: Color(
                  0x90ffffff,
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Name of the Goal',
                        style: GoogleFonts.signika(
                          fontSize: 18,
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.punch_clock_outlined,
                                    color: SolhColors.green,
                                  ),
                                  Text(
                                    '5 min',
                                    style: GoogleFonts.signika(
                                        fontSize: 14, color: SolhColors.green),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 18,
                                width: 1,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: SolhColors.green,
                                  ),
                                  Text(
                                    '4.5',
                                    style: GoogleFonts.signika(
                                        fontSize: 14, color: SolhColors.green),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('You will be achiveing this goal by doing following :-'),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 30 * 4,
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle_sharp,
                            color: SolhColors.green,
                          ),
                          Text('Drink 16 Glass of water Daily')
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  );
                }),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            'Occurance',
            style: GoogleFonts.signika(
              color: Color(0xff666666),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffA6A6A6),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Quit smoking',
                  hintStyle: GoogleFonts.signika(
                    color: Color(
                      0xffA6A6A6,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            'Max Reminders',
            style: GoogleFonts.signika(
              color: Color(0xff666666),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffA6A6A6),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Quit smoking',
                  hintStyle: GoogleFonts.signika(
                    color: Color(
                      0xffA6A6A6,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DoneButton extends StatelessWidget {
  const DoneButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 48,
        width: 70.w,
        decoration: BoxDecoration(
            color: SolhColors.green,
            borderRadius: BorderRadius.circular(
              24,
            )),
        child: Center(
          child: Text(
            'set Goal',
            style: GoogleFonts.signika(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
