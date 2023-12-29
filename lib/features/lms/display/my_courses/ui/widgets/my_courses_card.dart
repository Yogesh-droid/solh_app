import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solh/features/lms/display/my_courses/ui/widgets/course_progress_bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/stepsProgressbar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class MyCoursesCard extends StatelessWidget {
  const MyCoursesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: SolhColors.grey_2)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            child: CachedNetworkImage(
              placeholder: (context, url) =>
                  Image.asset('assets/images/opening_link.gif'),
              imageUrl: "https://picsum.photos/200",
              width: 130,
              height: 120,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Career counselling for beginners counselling for beginners',
                    style: SolhTextStyles.QS_body_2_bold,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.clock,
                            color: SolhColors.primary_green,
                            size: 12,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '2 hr 30 mins',
                            style: SolhTextStyles.QS_cap_semi,
                          )
                        ],
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: SolhColors.primary_green,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CourseProgressBar(
                          progress: 50,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        '30%',
                        style: SolhTextStyles.QS_cap_semi,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
