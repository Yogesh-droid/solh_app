import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class MyCourseMoreOptions extends StatelessWidget {
  const MyCourseMoreOptions({super.key, required this.courseId});
  final String courseId;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          OptionsTile(
            icon: Icons.info_outline,
            onTap: () {},
            title: "About This Course",
          ),
          OptionsTile(
            icon: Icons.message,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.courseChatPage,
                  arguments: {
                    'courseId': courseId,
                  });
            },
            title: "Message",
          ),
          OptionsTile(
            icon: Icons.help_outline,
            onTap: () {},
            title: "Course Certificate",
          ),
          OptionsTile(
            icon: Icons.download,
            onTap: () {},
            title: "Resources",
          ),
          OptionsTile(
            icon: Icons.rate_review_outlined,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.addReviewPage, arguments: {
                'courseId': courseId,
              });
            },
            title: "Add Review",
          ),
          OptionsTile(
            icon: Icons.assignment_turned_in,
            onTap: () {},
            title: "Assignment",
          ),
        ],
      ),
    );
  }
}

class OptionsTile extends StatelessWidget {
  const OptionsTile(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});
  final String title;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.quicksand(
            textStyle: SolhTextStyles.CTA.copyWith(color: Colors.black)),
      ),
      leading: Icon(
        icon,
        color: SolhColors.primary_green,
      ),
      onTap: onTap,
    );
  }
}
