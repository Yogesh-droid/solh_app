import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No Items Added",
        style: SolhTextStyles.QS_body_2,
      ),
    );
  }
}
