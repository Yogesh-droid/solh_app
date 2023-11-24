import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      "No Item",
      style: SolhTextStyles.QS_body_1_bold,
    ));
  }
}
