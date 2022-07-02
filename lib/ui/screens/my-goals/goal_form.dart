import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/my-goals/details.dart';
import 'package:solh/ui/screens/my-goals/my-goals-controller/my_goal_controller.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

bool isCustomGoal = false;

class GoalForm extends StatelessWidget {
  GoalForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(
          'Custom Goal',
          style: GoogleFonts.signika(
            color: Colors.black,
          ),
        ),
        isLandingScreen: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 36,
              ),
              ImageHolder(),
              GoalName(),
              TaskForm(),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AddTaskButton(),
                ],
              ),
              MaxReminder(),
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

class ImageHolder extends StatelessWidget {
  const ImageHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 60.w,
        height: 25.h,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              left: 0,
              child: Container(
                width: 60.w,
                height: 20.h,
                decoration: BoxDecoration(
                    border: Border.all(color: SolhColors.green),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(child: Text('Add Image')),
              ),
            ),
            Positioned(
              right: 0,
              top: -15,
              child: Container(
                height: 30,
                width: 30,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: SolhColors.green,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GoalName extends StatelessWidget {
  const GoalName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Goal Name',
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
            height: 12,
          ),
          Text(
            'Sub-Category',
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
            height: 12,
          ),
          Text(
            'You will be achieving this goal by doing following :-',
            style: GoogleFonts.signika(
              color: Color(0xff666666),
            ),
          ),
          Divider(),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}

class TaskForm extends StatelessWidget {
  TaskForm({Key? key}) : super(key: key);

  var _controller = Get.put(MyGoalController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: 160.0 * _controller.teskNo.value,
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: _controller.teskNo.value,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Tesk ${index + 1}',
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
                    height: 12,
                  ),
                  Text(
                    'Occurrence',
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
              );
            }),
      );
    });
  }
}

class AddTaskButton extends StatelessWidget {
  AddTaskButton({Key? key}) : super(key: key);
  MyGoalController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _controller.teskNo.value++;
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: SolhColors.green),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Add Task'),
        ),
      ),
    );
  }
}

class DoneButton extends StatelessWidget {
  const DoneButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Details())),
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
            'Done',
            style: GoogleFonts.signika(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class MaxReminder extends StatelessWidget {
  const MaxReminder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Max Reminder',
            style: GoogleFonts.signika(
              color: Color(0xff666666),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            height: 48,
            width: double.maxFinite,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffA6A6A6),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Selected',
                  style: GoogleFonts.signika(
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
