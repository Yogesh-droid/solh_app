import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/profileSetupFloatingActionButton.dart';
import 'package:solh/widgets_constants/constants/stepsProgressbar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class NeedSupportOn extends StatelessWidget {
  const NeedSupportOn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundArt(
      floatingActionButton:
          ProfileSetupFloatingActionButton.profileSetupFloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, AppRoutes.partOfAnOrgnisation),
      ),
      appBar: SolhAppBarTanasparentOnlyBackButton(
        backButtonColor: SolhColors.black666,
        onBackButton: () => Navigator.of(context).pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            StepsProgressbar(
              stepNumber: 5,
              bottomBarcolor: SolhColors.grey196,
              upperBarcolor: SolhColors.green,
            ),
            SizedBox(
              height: 3.h,
            ),
            NeedSupportOnText(),
            SizedBox(
              height: 3.h,
            ),
            Expanded(
              child: ListView(
                children: [
                  IssueChips(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NeedSupportOnText extends StatelessWidget {
  const NeedSupportOnText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Need support on',
          style: SolhTextStyles.Large2BlackTextS24W7,
        ),
        Text(
          "Give us a rough idea of the issues that you deal with on a daily basis. You may select more than one.  ",
          style: SolhTextStyles.NormalTextGreyS14W5,
        ),
      ],
    );
  }
}

class IssueChips extends StatelessWidget {
  const IssueChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 5, children: getAllChips(context));
  }
}

List<FilterChip> getAllChips(context) {
  List<FilterChip> chipsList = issues
      .map((e) => FilterChip(
          onSelected: (value) {},
          backgroundColor: SolhColors.grey239,
          label: Text(
            e,
            style: Theme.of(context).textTheme.headline1,
          )))
      .toList();

  chipsList.add(FilterChip(
    label: Text('Other'),
    onSelected: (value) {},
    backgroundColor: SolhColors.grey239,
    side: BorderSide(color: SolhColors.green),
  ));

  return chipsList;
}

List issues = [
  "ADHD",
  "Addiction",
  "Adoption/Foster Care",
  "Alcohol/Drug Abuse",
  "Anxiety",
  "Autism Spectrum",
  "Bipolar",
  "Borderline (BPD)",
  "Breakups",
  "Bullying",
  "Cancer",
  "Chronic Pain",
  "Depression",
  "Diabetes",
  "Disabilities",
  "Dissociative Identity Disorder (DID)",
  "Domestic Violence",
  "Eating Disorder",
  "Exercise Motivation",
  "Family Stress",
  "Financial Stress",
  "Forgiveness",
  "General Mental Health"
      "Getting Unstuck",
  "Grief",
  "LGBTQ+ Issues",
  "Loneliness",
  "Managing Emotions",
  "Men's Issues",
  "Obsessive Compulsive Disorder"
      "PTSD",
  "Panic Attacks",
  "Parenting",
  "Perinatal Mood Disorder",
  "Personality Disorder",
  "Racial & Cultural Identity",
  "Recovery",
  "Relationship Stress",
  "Schizophrenia",
  "Self-Esteem",
  "Self-Harm",
  "Sexual Health"
      "Sleeping Well   ",
  "Social Anxiety",
  "Spirituality",
  "Student Life",
  "Weight Management",
  "Women's Issues",
  "Work Stress",
];
