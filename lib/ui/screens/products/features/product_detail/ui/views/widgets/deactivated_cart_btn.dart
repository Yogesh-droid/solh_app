import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

import '../../../../../../../../widgets_constants/constants/colors.dart';

class DeactivatedCartBtn extends StatelessWidget {
  const DeactivatedCartBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 50,
      child: Row(children: [
        Container(
            height: 30,
            color: SolhColors.greenShade2,
            child: const Icon(Icons.remove, color: SolhColors.white)),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: SolhColors.primary_green)),
          width: 30,
          child: Center(child: MyLoader(strokeWidth: 2, radius: 10)),
        ),
        Container(
          height: 30,
          color: SolhColors.greenShade2,
          child: const Icon(Icons.add, color: SolhColors.white),
        ),
      ]),
    );
  }
}
