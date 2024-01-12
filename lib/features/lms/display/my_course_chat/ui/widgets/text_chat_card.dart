import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solh/features/lms/display/my_course_chat/data/models/course_chat_model.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class TextChatCard extends StatelessWidget {
  const TextChatCard({super.key, required this.conversation});
  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(conversation.body ?? ''),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (DateTime.tryParse(conversation.dateTime.toString()) != null)
                  Text(
                    DateFormat('dd MMM yyy').format(
                        DateTime.parse(conversation.dateTime.toString())),
                    style: SolhTextStyles.Caption_2_semi.copyWith(
                        color: SolhColors.grey_2),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
