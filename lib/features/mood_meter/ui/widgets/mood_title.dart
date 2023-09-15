import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/mood_meter/ui/controllers/get_mood_list_controller.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class MoodTitle extends StatelessWidget {
  const MoodTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final GetMoodListController getMoodListController = Get.find();
    return Obx(() => Text(
          getMoodListController.selectedMood.value.name ?? '',
          style: SolhTextStyles.QS_body_semi_1,
        ));
  }
}
