import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/my-goals/goal_form.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class AddSelectGoal extends StatelessWidget {
  const AddSelectGoal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(
          'Select/Add Goal',
          style: GoogleFonts.signika(
            color: Colors.black,
          ),
        ),
        isLandingScreen: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        child: Column(
          children: [
            GoalsFound(),
            SizedBox(
              height: 40,
            ),
            SampleGoals()
          ],
        ),
      ),
    );
  }
}

class GoalsFound extends StatelessWidget {
  const GoalsFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Custom Goals',
              style: GoogleFonts.signika(
                  color: Color(
                    0xffA6A6A6A6,
                  ),
                  fontSize: 16),
            ),
            SizedBox(
              height: 53,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No Goals Found',
                  style: GoogleFonts.signika(
                      color: Color(
                        0xffA6A6A6A6,
                      ),
                      fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [AddGoalButton()],
            )
          ]),
    );
  }
}

class AddGoalButton extends StatelessWidget {
  const AddGoalButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 48,
      decoration: BoxDecoration(
          color: SolhColors.green,
          borderRadius: BorderRadius.circular(
            24,
          )),
      child: Center(
          child: Text(
        'Add Goal',
        style: GoogleFonts.signika(
          color: Colors.white,
        ),
      )),
    );
  }
}

class SampleGoals extends StatelessWidget {
  const SampleGoals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sample Goals',
              style: GoogleFonts.signika(
                  color: Color(0xff666666),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 26,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => GoalForm())),
                        child: Container(
                          height: 100,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffA6A6A6),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    topLeft: Radius.circular(12)),
                                child: Image(
                                    image: NetworkImage(
                                        'https://img.freepik.com/free-photo/human-hand-holding-cigarette-world-no-tobacco-day-concept_1150-44244.jpg?w=740&t=st=1656577005~exp=1656577605~hmac=7984259e30c61238f69760608f60cdbc1a7878f12ced2cd1404d736f72bc6713')),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Quite Smoking',
                                    style: GoogleFonts.signika(
                                        color: Color(0xff666666), fontSize: 16),
                                  ),
                                  Text(
                                    'Take nicotine,  Do exercise',
                                    style: GoogleFonts.signika(
                                        color: Color(0xff666666),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                })
          ]),
    );
  }
}
