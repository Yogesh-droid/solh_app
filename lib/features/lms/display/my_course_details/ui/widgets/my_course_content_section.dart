import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/my_course_details/data/models/my_course_detail_model.dart';
import 'package:solh/features/lms/display/my_course_details/ui/controllers/my_course_detail_controller.dart';
import 'package:solh/features/lms/display/my_course_details/ui/controllers/update_lecture_track_controller.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class ExpandedWidget extends StatelessWidget {
  const ExpandedWidget(
      {super.key,
      required this.e,
      required this.onTapped,
      required this.onLectureTapped,
      required this.courseId});
  final SectionList e;
  final String courseId;
  final Function(String id) onTapped;
  final Function(Lectures) onLectureTapped;

  @override
  Widget build(BuildContext context) {
    final UpdateLectureTrackController updateLectureTrackController =
        Get.find();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: SolhColors.greyS200),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          // Title
          InkWell(
            onTap: () => onTapped(e.id ?? ''),
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
                  Icons.remove,
                  color: SolhColors.primary_green,
                ),
                const SizedBox(
                  width: 5,
                )
              ],
            ),
          ),
          // lecture List
          ...e.lectures!.map((e1) => InkWell(
                onTap: () => onLectureTapped(e1),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: SolhColors.greyS200),
                      color: const Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(5)),
                  child: e1.contentType == 'quiz'
                      ? const Row(
                          children: [Icon(Icons.live_help), Text("Quiz")])
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                                activeColor: SolhColors.primary_green,
                                value: e1.isDone,
                                onChanged: (value) async {
                                  e1.isDone = value;
                                  Get.find<MyCourseDetailController>()
                                      .sectionList
                                      .refresh();
                                  await updateLectureTrackController
                                      .updateLectureTrack(
                                          courseId: courseId,
                                          lectureId: e1.id ?? '',
                                          sectionId: e.id ?? '');
                                  Utility.showToast(updateLectureTrackController
                                      .message.value);
                                }),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 250,
                                    child: Text(
                                      e1.title ?? '',
                                      style: SolhTextStyles.QS_caption,
                                      textAlign: TextAlign.left,
                                    ),
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
                                          "${e1.duration!.hours} hrs ${e1.duration!.minutes} mins",
                                          style: SolhTextStyles.QS_cap_2_semi,
                                        )
                                      ]),
                                      // Resources
                                      const SizedBox(width: 30),
                                      const Row(children: [
                                        Icon(
                                          Icons.cloud_download_rounded,
                                          size: 12,
                                        ),
                                        Text(
                                          " Resources",
                                          style: SolhTextStyles.QS_cap_2_semi,
                                        )
                                      ]),
                                    ],
                                  )
                                ]),
                            CircleAvatar(
                                backgroundColor: SolhColors.grey239,
                                child: Icon(
                                  e1.contentType != "video"
                                      ? Icons.book_outlined
                                      : Icons.play_arrow,
                                  color: Colors.black,
                                ))
                          ],
                        ),
                ),
              ))
        ],
      ),
    );
  }
}

class CollapsedWidget extends StatelessWidget {
  const CollapsedWidget(
      {super.key,
      required this.e,
      required this.onTapped,
      required this.percentage});
  final SectionList e;
  final Function(String id) onTapped;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapped(e.id ?? ''),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Row(
            children: [
              Expanded(
                flex: percentage,
                child: Container(
                  color: SolhColors.greenShade3,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 50,
                ),
              ),
              Expanded(
                flex: 100 - percentage,
                child: Container(
                  color: SolhColors.white,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 50,
                ),
              ),
            ],
          ),
          Container(
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
        ],
      ),
    );
  }
}
