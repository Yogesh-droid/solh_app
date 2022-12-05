import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/goal-setting/goal_setting_controller.dart';
import 'package:solh/model/goal-setting/sample_goals_model.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import '../../../widgets_constants/constants/textstyles.dart';
import 'goal_form.dart';

class Details extends StatelessWidget {
  Details({Key? key, required this.sampleGoal, required this.goalId})
      : super(key: key);
  final SampleGoal sampleGoal;
  final String goalId;
  final GoalSettingController goalSettingController = Get.find();
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
              GoalNameStack(sampleGoal: sampleGoal),
              SizedBox(
                height: 24,
              ),
              TaskList(sampleGoal: sampleGoal),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SolhGreenButton(
                  child: Text(
                    'Set Goal',
                    style: GoogleFonts.signika(color: Colors.white),
                  ),
                  height: 50,
                  onPressed: () {
                    goalSettingController.saveGoal(
                        goalType: 'sample',
                        goalId: sampleGoal.sId,
                        goalCatId: goalId);
                    Utility.showToast('Goal set successfully');
                  },
                ),
              ),
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
  const GoalNameStack({Key? key, required this.sampleGoal}) : super(key: key);
  final SampleGoal sampleGoal;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            height: 40.h,
            width: 100.w,
            child: CachedNetworkImage(
              imageUrl: sampleGoal.image ?? '',
              fit: BoxFit.cover,
              errorWidget: (context, url, error) =>
                  Image.asset('assets/images/no-image-available.png'),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 12.h,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(),
                ),
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
                color: Colors.white.withOpacity(0.8),
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
                        '${sampleGoal.name}',
                        style: GoogleFonts.signika(
                          fontSize: 18,
                        ),
                      ),
                      // Column(
                      //   children: [
                      //     Row(
                      //       children: [
                      //         Row(
                      //           children: [
                      //             Icon(
                      //               Icons.punch_clock_outlined,
                      //               color: SolhColors.green,
                      //             ),
                      //             Text(
                      //               '5 min',
                      //               style: GoogleFonts.signika(
                      //                   fontSize: 14, color: SolhColors.green),
                      //             )
                      //           ],
                      //         ),
                      //         SizedBox(
                      //           width: 10,
                      //         ),
                      //         Container(
                      //           height: 18,
                      //           width: 1,
                      //           color: Colors.grey,
                      //         ),
                      //         SizedBox(
                      //           width: 10,
                      //         ),
                      //         Row(
                      //           children: [
                      //             Icon(
                      //               Icons.star,
                      //               color: SolhColors.green,
                      //             ),
                      //             Text(
                      //               '4.5',
                      //               style: GoogleFonts.signika(
                      //                   fontSize: 14, color: SolhColors.green),
                      //             ),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // )
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
  TaskList({Key? key, required this.sampleGoal}) : super(key: key);
  final SampleGoal sampleGoal;
  GoalSettingController _goalSettingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: SolhColors.primary_green,
              ),
              child: Center(
                  child: Text(
                'You will be achiveing this goal by doing following :-',
                style: TextStyle(color: Colors.white),
              ))),
          SizedBox(
            height: 16,
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: sampleGoal.activity!.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_circle_right_rounded,
                        color: SolhColors.primary_green,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(e.task ?? ''))
                    ],
                  ),
                );
              }).toList()),
          SizedBox(
            height: 24,
          ),
          // getOccuranceBox(),
          // SizedBox(
          //   height: 24,
          // ),
          MaxReminder()
        ],
      ),
    );
  }

  Widget getOccuranceBox() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Occurance",
              style: SolhTextStyles.JournalingHintText,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: SolhColors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: SolhColors.grey,
                  ),
                ),
                filled: true,
                fillColor: SolhColors.white,
              ),
              validator: (value) {
                if (value == null) {
                  return "Please select a subcategory";
                }
                return null;
              },
              onChanged: (value) {
                // map.update(map.keys.first, (value) => value,
                //     ifAbsent: () => value.toString());
                //_goalSettingController.task.value.elementAt(0)[map.keys.first] = value.toString();
              },
              value: '1',
              items: [
                DropdownMenuItem(
                  value: '1',
                  child: Text('Once'),
                ),
                DropdownMenuItem(
                  value: '365',
                  child: Text('Daily'),
                ),
              ]),
        )
      ],
    );
  }
}
