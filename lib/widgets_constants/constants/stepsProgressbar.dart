import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

class StepsProgressbar extends StatelessWidget {
  StepsProgressbar(
      {Key? key,
      required double this.stepNumber,
      this.bottomBarcolor = const Color(0x60ffffff),
      this.upperBarcolor = const Color(0xffffffff)})
      : super(key: key);
  final double stepNumber;
  final Color bottomBarcolor;
  final Color? upperBarcolor;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          height: 0.7.h,
          decoration: BoxDecoration(
            color: bottomBarcolor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        LayoutBuilder(
            builder: ((BuildContext context, BoxConstraints constraints) {
          return Container(
            width: (constraints.maxWidth / 6) * stepNumber,
            height: 0.7.h,
            decoration: BoxDecoration(
              color: upperBarcolor,
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }))
      ],
    );
  }
}
