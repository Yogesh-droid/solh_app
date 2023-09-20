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
        alignment: Alignment.center,
        child: Obx(() => subMoodController.isLoading.value ||
                subMoodController.subMoodList.value.subMoodList == null
            ? loadingShimmer()
            : subMoodController.error.value.isEmpty
                ? Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    children: subMoodController.subMoodList.value.subMoodList!
                        .map((element) => FilterChip(
                              label: Text(element.name ?? '',
                                  style: TextStyle(
                                      color: subMoodController.selectedSubMood
                                              .contains(element)
                                          ? Colors.white
                                          : Colors.black)),
                              showCheckmark: false,
                              onSelected: (value) {
                                subMoodController.selectedSubMood
                                        .contains(element)
                                    ? subMoodController.selectedSubMood
                                        .remove(element)
                                    : subMoodController.selectedSubMood
                                        .add(element);
                              },
                              selected: subMoodController.selectedSubMood
                                  .contains(element),
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
      alignment: WrapAlignment.center,
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
