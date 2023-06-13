import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class StepsProgressbar extends StatelessWidget {
  StepsProgressbar(
      {Key? key,
      required double this.stepNumber,
      this.maxStep = 8,
      this.bottomBarcolor = const Color(0x60ffffff),
      this.upperBarcolor = const Color(0xffffffff)})
      : super(key: key);
  final double stepNumber;
  final int maxStep;
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
            width: (constraints.maxWidth / maxStep) * stepNumber,
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
