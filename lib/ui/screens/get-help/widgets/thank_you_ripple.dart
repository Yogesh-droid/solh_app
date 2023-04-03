// import 'package:flutter/material.dart';
// import 'package:flutter/animation.dart';

// class RipplesAnimation extends StatefulWidget {
//   const RipplesAnimation({
//     Key? key,
//     this.size = 80.0,
//     this.color = Colors.red,
//     this.onPressed,
//     @required this.child,
//   }) : super(key: key);
//   final double? size;
//   final Color? color;
//   final Widget? child;
//   final VoidCallback? onPressed;
//   @override
//   _RipplesAnimationState createState() => _RipplesAnimationState();
// }

// class _RipplesAnimationState extends State<RipplesAnimation>
//     with TickerProviderStateMixin {
//   AnimationController _controller;
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     )..repeat();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Widget _button() {
//     return Center(
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(widget.size),
//         child: DecoratedBox(
//           decoration: BoxDecoration(
//             gradient: RadialGradient(
//               colors: <Color>[
//                 widget.color,
//                 Color.lerp(widget.color, Colors.black, .05)
//               ],
//             ),
//           ),
//           child: ScaleTransition(
//               scale: Tween(begin: 0.95, end: 1.0).animate(
//                 CurvedAnimation(
//                   parent: _controller,
//                   curve: const CurveWave(),
//                 ),
//               ),
//               child: Icon(
//                 Icons.speaker_phone,
//                 size: 44,
//               )),
//         ),
//       ),
//     );
//   }
// }

// class CurveWave extends Curve {
//   const PulsateCurve();
//   @override
//   double transform(double t) {
//     if (t == 0 || t == 1) {
//       return 0.01;
//     }
//     return math.sin(t * math.pi);
//   }
// }

import 'package:flutter/material.dart';

class ThankYouRipple extends StatefulWidget {
  ThankYouRipple({Key? key}) : super(key: key);

  @override
  State<ThankYouRipple> createState() => _ThankYouRippleState();
}

class _ThankYouRippleState extends State<ThankYouRipple>
    with SingleTickerProviderStateMixin {
  final double height = 100;
  late AnimationController animationController;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: height,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          shape: BoxShape.circle,
        ));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
