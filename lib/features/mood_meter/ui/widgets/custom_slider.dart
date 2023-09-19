import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solh/features/mood_meter/ui/controllers/get_mood_list_controller.dart';
import 'package:solh/features/mood_meter/ui/controllers/get_sub_mood_controller.dart';
import 'package:solh/features/mood_meter/ui/controllers/slider_controller.dart';
import 'package:solh/features/mood_meter/ui/widgets/large_thumb_shape.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'slider_bg.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final SliderController sliderController = Get.find();
    final GetMoodListController getMoodListController = Get.find();
    final SubMoodController subMoodController = Get.find();
    return Obx(() => getMoodListController.isLoading.value
        ? moodMeterShimmer()
        : getMoodListController.error.value.isNotEmpty
            ? Center(child: Text(getMoodListController.error.value))
            : Stack(
                alignment: Alignment.center,
                children: [
                  SliderBg(),
                  SliderTheme(
                    data: SliderThemeData(thumbShape: LargeThumbShape()),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Slider(
                        value: sliderController.value.value,
                        onChanged: (value) {
                          print(value);
                          sliderController.value.value = value;
                          getMoodListController.selectedMood.value =
                              getMoodListController.moodList[value.toInt()];
                        },
                        onChangeEnd: (value) {
                          print(value);
                          subMoodController.getSubMoodList(getMoodListController
                              .moodList[value.toInt()].id!);
                        },
                        divisions: getMoodListController.moodList.length - 1,
                        thumbColor: SolhColors.primary_green,
                        min: 0.0,
                        max: (getMoodListController.moodList.length - 1)
                            .toDouble(),
                        activeColor: Colors.transparent,
                        inactiveColor: Colors.transparent,
                        label: getMoodListController.selectedMood.value.name,
                      ),
                    ),
                  )
                ],
              ));
  }

  Widget moodMeterShimmer() {
    return Shimmer.fromColors(
        child: Container(
          height: 50,
          width: double.maxFinite,
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 30,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text("Mood Meter Loading ...",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20))),
                  ))),
        ),
        baseColor: Colors.grey,
        highlightColor: Colors.white);
  }
}
