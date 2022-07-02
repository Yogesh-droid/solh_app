import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/my-goals/add_select_goal.dart';
import 'package:solh/ui/screens/my-goals/select_goal.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class MyGoalsScreen extends StatelessWidget {
  const MyGoalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(
          "Goals",
          style: SolhTextStyles.AppBarText,
        ),
        isLandingScreen: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Goals',
                        style: goalFontStyle(16.0, Color(0xffA6A6A6)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: SolhColors.green),
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              Text(
                                'Add',
                                style: goalFontStyle(14.0, SolhColors.green),
                              ),
                              Icon(
                                Icons.add,
                                color: SolhColors.green,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 31.5,
                  ),
                  TodaysGoal(),
                  SizedBox(
                    height: 24,
                  ),
                  AddGoalButton(),
                  SizedBox(
                    height: 40,
                  ),
                  GoalName(),
                  SizedBox(
                    height: 24,
                  ),
                  MileStone(),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'I want to work on',
                    style: goalFontStyle(14.0, Color(0xffA6A6A6)),
                  ),
                  Expanded(child: IWantToWorkOn())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

goalFontStyle(
    [size = 14.0, color = Colors.black, fontWeight = FontWeight.w400]) {
  return GoogleFonts.signika(
      fontSize: size, fontWeight: fontWeight, color: color);
}

class TodaysGoal extends StatelessWidget {
  const TodaysGoal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today\'s Goals',
                style: goalFontStyle(24.0, Color(0xff666666), FontWeight.w400),
              ),
              Text(
                'Here is the track of today\'s Goals',
                style: goalFontStyle(14.0, Color(0xffA6A6A6), FontWeight.w300),
              )
            ],
          ),
          Container(
            height: 86,
            width: 86,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffA6A6A6A),
            ),
            child: Center(
                child: Container(
              height: 81,
              width: 81,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('0/0'),
                  Text('Completed'),
                ],
              )),
            )),
          )
        ],
      ),
    );
  }
}

class GoalName extends StatelessWidget {
  const GoalName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Goal Name',
                style: goalFontStyle(
                  18.0,
                  Color(0xff666666),
                ),
              ),
              Row(
                children: [
                  Text(
                    'Persnonal Development',
                    style: goalFontStyle(
                      14.0,
                      Color(0xffA6A6A6),
                      FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Container(
                    height: 14,
                    color: Color(0xffA6A6A6),
                    width: 2,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    '10:30 PM',
                    style: goalFontStyle(
                      14.0,
                      Color(0xffA6A6A6),
                      FontWeight.w300,
                    ),
                  )
                ],
              )
            ],
          ),
          Icon(
            Icons.more_vert,
            color: SolhColors.green,
          )
        ],
      ),
    );
  }
}

class MileStone extends StatefulWidget {
  const MileStone({Key? key}) : super(key: key);

  @override
  State<MileStone> createState() => _MileStoneState();
}

class _MileStoneState extends State<MileStone> {
  var type = ['checkbox', 'text'];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Color(0xffD7E6E2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Milestone outside app 1'),
            Checkbox(
                checkColor: SolhColors.green,
                activeColor: Colors.white,
                side: MaterialStateBorderSide.resolveWith((states) =>
                    BorderSide(width: 1.0, color: Color(0xffA6A6A6))),
                shape: CircleBorder(),
                value: true,
                onChanged: (value) {})
          ],
        ),
      ),
    );
  }
}

class IWantToWorkOn extends StatelessWidget {
  const IWantToWorkOn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: 10,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 1.2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (() => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddSelectGoal()))),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffA6A6A6)),
                    borderRadius: BorderRadius.circular(
                      8,
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://180dc.org/wp-content/uploads/2016/08/default-profile.png'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: Text('Educational Goal'))
                  ]),
                ),
              ),
            );
          }),
    );
  }
}

class AddGoalButton extends StatelessWidget {
  const AddGoalButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SelectGoal())),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 70.w,
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: SolhColors.green),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add Goal',
                      style: GoogleFonts.signika(
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
