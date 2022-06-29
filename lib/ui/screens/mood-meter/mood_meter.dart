import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/mood-meter/mood_meter_controller.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class MoodMeter extends StatelessWidget {
  MoodMeter({Key? key}) : super(key: key);
  final MoodMeterController moodMeterController = Get.find();
  LinearGradient gradient = LinearGradient(colors: <Color>[
    Colors.green,
    Colors.red,
  ]);
  @override
  Widget build(BuildContext context) {
    return Container(child: Obx(() {
      return moodMeterController.isLoading.value
          ? getShimmer()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "How are you feeling right now?",
                  style: SolhTextStyles.ProfileMenuGreyText,
                ),
                Expanded(
                  child: Container(),
                ),
                Obx(() {
                  return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: moodMeterController.selectedGif.value,
                        height: 200,
                        width: 200,
                        fit: BoxFit.fill,
                      ));
                }),
                SizedBox(
                  height: 20,
                ),
                Obx(() {
                  return Text(
                    moodMeterController.selectedMood.value,
                    style: SolhTextStyles.ProfileMenuGreyText,
                  );
                }),
                Expanded(
                  child: Container(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SliderTheme(
                      data: SliderThemeData(
                          trackShape: GradientRectSliderTrackShape(
                              gradient: gradient, darkenInactive: true),
                          thumbShape: MyThumbShape(),
                          overlayShape: RoundSliderOverlayShape(
                            overlayRadius: 20.0,
                          ),
                          overlayColor: SolhColors.black.withOpacity(0.2),
                          tickMarkShape: MyTickerShape()),
                      child: Obx(() {
                        return Slider(
                            thumbColor: Colors.white,
                            divisions: moodMeterController
                                    .moodMeterModel.value.moodList!.length -
                                1,
                            min: 0,
                            max: moodMeterController
                                    .moodMeterModel.value.moodList!.length -
                                1.toDouble(),
                            value: moodMeterController.selectedValue.value,
                            onChanged: (value) {
                              moodMeterController.selectedValue.value = value;
                              moodMeterController.changeImg(value);
                              print(value);
                            });
                      })),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SolhGreenButton(
                      child: Text("Done"),
                      onPressed: () {
                        moodMeterController.saveMoodOfday();
                        Navigator.pop(context);
                      }),
                ),
              ],
            );
    }));
  }

  getShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 200,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 10,
              width: 200,
              color: Colors.grey[300],
            ),
            Container(
              height: 10,
              width: 200,
              color: Colors.grey[300],
            ),
            Container(
              height: 10,
              width: 200,
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}

class MyThumbShape extends SliderComponentShape {
  MyThumbShape();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(
      10.w,
      10.h,
    );
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final RRect outer = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: 28,
        height: 28,
      ),
      Radius.circular(15),
    );

    final RRect inner = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: 22,
        height: 22,
      ),
      Radius.circular(11),
    );

    final RRect shadow = RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 30, height: 30),
        Radius.circular(30));

    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Paint paint2 = Paint()
      ..color = SolhColors.green
      ..style = PaintingStyle.fill;

    final Paint paint3 = Paint()
      ..color = SolhColors.black.withOpacity(0.1)
      ..blendMode = BlendMode.multiply
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;

    //context.canvas.drawRRect(shadow, paint3);
    context.canvas
        .drawShadow(Path()..addRRect(shadow), Colors.black, 10, false);
    context.canvas.drawRRect(outer, paint);
    context.canvas.drawRRect(inner, paint2);

    // final paint = Paint();
    // paint.color = Colors.white;
    // paint.style = PaintingStyle.fill;
    // context.canvas.drawCircle(center, 10.w, paint);
  }
}

///  This is a custom tick mark shape.
class MyTickerShape extends SliderTickMarkShape {
  @override
  Size getPreferredSize({
    required SliderThemeData sliderTheme,
    bool? isEnabled,
    bool? isDiscrete,
  }) {
    return Size(10.0, 10.0);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required Animation<double> enableAnimation,
      required Offset thumbCenter,
      required bool isEnabled,
      required TextDirection textDirection}) {
    final paint = Paint();
    paint.color = Color(0xFFA6A6A6);
    paint.style = PaintingStyle.fill;

    final RRect rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: 3.0, height: 20.0),
      Radius.circular(10),
    );
    context.canvas.drawRRect(rRect, paint);
  }
}

class GradientRectSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  GradientRectSliderTrackShape({
    required Gradient gradient,
    required bool darkenInactive,
  })  : _gradient = gradient,
        _darkenInactive = darkenInactive;

  final Gradient _gradient;
  final bool _darkenInactive;

  @override
  void paint(PaintingContext context, Offset offset,
      {required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required Animation<double> enableAnimation,
      required Offset thumbCenter,
      bool? isEnabled,
      bool? isDiscrete,
      required TextDirection textDirection}) {
    //// for the track
    final rect = Rect.fromCenter(
      center: Offset(parentBox.size.width / 2, parentBox.size.height / 2),
      width: parentBox.size.width,
      height: 7,
    );

    final gradient = _gradient.createShader(rect);

    final paint = Paint()
      ..shader = gradient
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
          rect, Radius.circular(sliderTheme.trackHeight ?? 2.0)),
      paint,
    );

    /// for the indicator
  }
}
