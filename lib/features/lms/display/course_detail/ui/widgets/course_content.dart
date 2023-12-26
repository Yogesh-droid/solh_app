import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/course_detail/data/models/course_details_model.dart';
import 'package:solh/features/lms/display/course_detail/ui/controllers/course_detail_controller.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class CourseContent extends StatefulWidget {
  const CourseContent({super.key});

  @override
  State<CourseContent> createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
  final CourseDetailController courseDetailController = Get.find();

  var selectedPanelId = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: courseDetailController.courseDetailEntity.value.sections!
          .map((e) => AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: selectedPanelId == e.id
                  ? ExpandedWidget(
                      e: e,
                      onTapped: (id) {
                        setState(() {
                          selectedPanelId = '';
                        });
                      })
                  : CollapsedWidget(
                      e: e,
                      onTapped: (id) {
                        setState(() {
                          selectedPanelId = id;
                        });
                      })))
          .toList(),
    );
  }
}

class ExpandedWidget extends StatelessWidget {
  const ExpandedWidget({super.key, required this.e, required this.onTapped});
  final Sections e;
  final Function(String id) onTapped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapped(e.id ?? ''),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: SolhColors.greyS200),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [
            // Title
            Row(
              children: [
                const SizedBox(width: 5),
                Text(
                  "Module :",
                  style: SolhTextStyles.QS_body_2_semi.copyWith(
                      color: SolhColors.primary_green),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    e.title ?? '',
                    style: SolhTextStyles.QS_body_2_semi,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(
                  Icons.remove,
                  color: SolhColors.primary_green,
                ),
                const SizedBox(
                  width: 5,
                )
              ],
            ),
            // lecture List
            ...e.lectures!.map((e1) => Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: SolhColors.greyS200),
                      color: const Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e1.title ?? '',
                              style: SolhTextStyles.QS_caption,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 5),
                            // Duration And resources
                            Row(
                              children: [
                                Row(children: [
                                  const Icon(
                                    Icons.play_arrow,
                                    size: 12,
                                  ),
                                  Text(
                                    "${e1.totalDuration!.hours} hrs ${e1.totalDuration!.minutes} mins",
                                    style: SolhTextStyles.QS_cap_2_semi,
                                  )
                                ]),
                                // Resources
                                const SizedBox(width: 30),
                                InkWell(
                                  onTap: () {},
                                  child: const Row(children: [
                                    Icon(
                                      Icons.cloud_download_rounded,
                                      size: 12,
                                    ),
                                    Text(
                                      " Resources",
                                      style: SolhTextStyles.QS_cap_2_semi,
                                    )
                                  ]),
                                ),
                              ],
                            )
                          ]),
                      const CircleAvatar(
                          backgroundColor: SolhColors.grey239,
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.black,
                          ))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class CollapsedWidget extends StatelessWidget {
  const CollapsedWidget({super.key, required this.e, required this.onTapped});
  final Sections e;
  final Function(String id) onTapped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapped(e.id ?? ''),
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(color: SolhColors.greyS200),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            const SizedBox(width: 5),
            Text(
              "Module :",
              style: SolhTextStyles.QS_body_2_semi.copyWith(
                  color: SolhColors.primary_green),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                e.title ?? '',
                style: SolhTextStyles.QS_body_2_semi,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              Icons.add,
              color: SolhColors.primary_green,
            ),
            const SizedBox(
              width: 5,
            )
          ],
        ),
      ),
    );
  }
}
