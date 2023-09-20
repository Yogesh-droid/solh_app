import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/mood_meter/ui/controllers/get_sub_mood_controller.dart';

import '../../../../widgets_constants/constants/colors.dart';

class CommentBox extends StatelessWidget {
  const CommentBox({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    final SubMoodController subMoodController = Get.find();
    return TextFormField(
      controller: textEditingController,
      onTapOutside: (value) {
        subMoodController.commentText.value = textEditingController.text;
      },
      maxLines: 3,
      decoration: InputDecoration(
          labelText: "Add Comment Here",
          alignLabelWithHint: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: SolhColors.primary_green)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: SolhColors.primary_green))),
    );
  }
}
