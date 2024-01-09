import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solh/features/lms/display/my_courses/ui/widgets/course_progress_bar.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class MyCoursesCard extends StatelessWidget {
  const MyCoursesCard(
      {super.key,
      required this.courseId,
      required this.courseDurationHours,
      required this.courseDurationMins,
      required this.imageUrl,
      required this.progressPercent,
      required this.title});

  final String courseId;
  final String courseDurationHours;
  final String courseDurationMins;
  final String imageUrl;
  final String progressPercent;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.myCourseDetailScreen,
            arguments: {'id': courseId, 'name': title, 'thumbnail': imageUrl});
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: SolhColors.grey_2)),
        child: Row(
          children: [
            Hero(
              tag: courseId,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      Image.asset('assets/images/opening_link.gif'),
                  imageUrl: imageUrl,
                  width: 130,
                  height: 120,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: SolhTextStyles.QS_body_2_bold,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.clock,
                              color: SolhColors.primary_green,
                              size: 12,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              "$courseDurationHours hrs $courseDurationMins mins",
                              style: SolhTextStyles.QS_cap_semi,
                            )
                          ],
                        ),
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: SolhColors.primary_green,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CourseProgressBar(
                            progress: int.parse(progressPercent),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          progressPercent,
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
      ),
    );
  }
}
