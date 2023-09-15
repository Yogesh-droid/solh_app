import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solh/features/mood_meter/ui/controllers/get_sub_mood_controller.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class SubMoodList extends StatelessWidget {
  const SubMoodList({super.key});

  @override
  Widget build(BuildContext context) {
    final SubMoodController subMoodController = Get.find();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Obx(() => subMoodController.isLoading.value
            ? loadingShimmer()
            : subMoodController.error.value.isEmpty
                ? Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    spacing: 10,
                    children: subMoodController.subMoodList
                        .map((element) => FilterChip(
                              label: Text(element.name ?? ''),
                              onSelected: (value) {
                                subMoodController.selectedSubMood.value =
                                    element;
                                if (element.name == "Other") {
                                  subMoodController.isCommentActive.value =
                                      true;
                                } else {
                                  subMoodController.isCommentActive.value =
                                      false;
                                }
                              },
                              selected:
                                  subMoodController.selectedSubMood.value ==
                                      element,
                              selectedColor: SolhColors.greenShade1,
                              backgroundColor: SolhColors.greenShade4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ))
                        .toList(),
                  )
                : Center(child: Text(subMoodController.error.value))),
      ),
    );
  }

  Widget loadingShimmer() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 10,
      children: List.generate(
          8,
          (index) => Shimmer.fromColors(
              child: FilterChip(
                label: Text("Mood"),
                onSelected: (value) {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              baseColor: Colors.grey,
              highlightColor: Colors.white)),
    );
  }
}
