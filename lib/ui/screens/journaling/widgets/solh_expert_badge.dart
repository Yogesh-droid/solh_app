import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../widgets_constants/constants/colors.dart';

class SolhExpertBadge extends StatelessWidget {
  const SolhExpertBadge({
    Key? key,
    this.usertype,
  }) : super(key: key);
  final String? usertype;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Container(
        //   height: 12,
        //   width: 1,
        //   color: SolhColors.grey,
        // ),
        SizedBox(
          width: 6,
        ),
        Text(
          usertype ?? '',
          style: GoogleFonts.signika(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: SolhColors.primary_green),
        ),
        SizedBox(
          width: 4,
        ),
        Icon(
          Icons.verified,
          color: SolhColors.primary_green,
          size: 14,
        ),
      ],
    );
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //   children: [
    //     Icon(
    //       Icons.verified,
    //       color: SolhColors.green,
    //       size: 14,
    //     ),
    //   ],
    // );
  }
}
