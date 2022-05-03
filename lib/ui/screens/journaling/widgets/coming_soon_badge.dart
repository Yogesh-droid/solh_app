import 'package:flutter/material.dart';

import '../../../../widgets_constants/constants/colors.dart';
import '../../../../widgets_constants/constants/textstyles.dart';

class ComingSoonBadge extends StatelessWidget {
  const ComingSoonBadge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height / 40,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / 40,
      ),
      decoration: BoxDecoration(
          color: SolhColors.grey239,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Comming Soon",
            style: SolhTextStyles.JournalingBadgeText,
          ),
        ],
      ),
    );
  }
}
