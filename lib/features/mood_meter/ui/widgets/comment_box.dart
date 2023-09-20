import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/mood_meter/ui/controllers/get_sub_mood_controller.dart';
import '../../../../widgets_constants/constants/colors.dart';

class CommentBox extends StatelessWidget {
  const CommentBox({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    final SubMoodController subMoodController = Get.find();
    return Obx(() {
      return
          // subMoodController.selectedSubMood.isEmpty
          //     ? SizedBox()
          //     :
          AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: subMoodController.selectedSubMood.isEmpty ? 0 : 120,
        child: subMoodController.selectedSubMood.isEmpty
            ? SizedBox()
            : TextFormField(
                controller: textEditingController,
                onTapOutside: (value) {
                  subMoodController.commentText.value =
                      textEditingController.text;
                },
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    subMoodController.isCommentRequired.value = false;
                  } else {
                    subMoodController.isCommentRequired.value = true;
                  }
                },
                maxLines: 3,
                decoration: InputDecoration(
                    labelText: "Add Comment Here",
                    alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: SolhColors.primary_green)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: SolhColors.primary_green))),
              ),
      );
    });
  }
}
