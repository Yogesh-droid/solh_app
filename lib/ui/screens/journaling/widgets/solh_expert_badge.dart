import 'package:flutter/material.dart';

import '../../../../widgets_constants/constants/colors.dart';

class SolhExpertBadge extends StatelessWidget {
  const SolhExpertBadge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          Icons.verified,
          color: SolhColors.green,
          size: 14,
        ),
      ],
    );
  }
}
