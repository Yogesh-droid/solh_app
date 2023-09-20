import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/mood_meter/ui/controllers/add_mood_record_controller.dart';
import 'package:solh/features/mood_meter/ui/controllers/get_mood_list_controller.dart';
import 'package:solh/features/mood_meter/ui/controllers/get_sub_mood_controller.dart';

import '../../../../widgets_constants/buttons/custom_buttons.dart';
import '../../../../widgets_constants/constants/colors.dart';
import '../../../../widgets_constants/constants/textstyles.dart';

class ContinueBtn extends StatelessWidget {
  const ContinueBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final SubMoodController subMoodController = Get.find();
    final GetMoodListController getMoodListController = Get.find();
    final AddMoodRecordController addMoodRecordController = Get.find();
    return Obx(() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: SolhGreenButton(
              width: MediaQuery.of(context).size.width,
              backgroundColor: subMoodController.selectedSubMood.isEmpty
                  ? SolhColors.grey
                  : SolhColors.primary_green,
              onPressed: subMoodController.selectedSubMood.isEmpty
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please Choose Correct Mood First")));
                    }
                  : addMoodRecordController.isLoading.value
                      ? null
                      : () async {
                          await addMoodRecordController.addMoodRecord(
                              moodId:
                                  getMoodListController.selectedMood.value.id ??
                                      '',
                              submoodList: List.generate(
                                  subMoodController.selectedSubMood.length,
                                  (index) => subMoodController
                                      .selectedSubMood[index].id),
                              comment: subMoodController.commentText.value);
                          if (addMoodRecordController.error.value.isEmpty) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text(addMoodRecordController.message.value),
                                showCloseIcon: true,
                                behavior: SnackBarBehavior.floating));
                          }
                        },
              child: Text(
                addMoodRecordController.isLoading.value
                    ? "Wait ..."
                    : "Continue",
                style: SolhTextStyles.CTA.copyWith(color: Colors.white),
              )),
        ));
  }
}
