import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/mood-meter/mood_meter_controller.dart';
import 'package:solh/controllers/my_diary/my_diary_controller.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/mood-meter/mood-reason-page.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class MoodMeter extends StatelessWidget {
  MoodMeter({Key? key, Map<String, dynamic>? args})
      : continueAction = args?['continueAction'],
        super(key: key);
  final VoidCallback? continueAction;
  final MoodMeterController moodMeterController = Get.find();
  MyDiaryController myDiaryController = Get.find();
  FocusNode _focusNode = FocusNode();
  TextEditingController _reasonController = TextEditingController();
  LinearGradient gradient = LinearGradient(colors: <Color>[
    Color(0xFFE1555A),
    Colors.yellow,
    Colors.blue,
    SolhColors.primary_green,
  ]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            image: DecorationImage(
              image: AssetImage('assets/intro/png/mood_meter_bg.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: Obx(() {
            return moodMeterController.isLoading.value
                ? getShimmer()
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Container()),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Express Yourself".tr,
                          style: SolhTextStyles.QS_head_5,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Obx(() {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: moodMeterController.selectedGif.value,
                                height: 200,
                                width: 200,
                                fit: BoxFit.fill,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  child: Container(
                                    color: Colors.grey,
                                  ),
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                ),
                              ));
                        }),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(() {
                          return Text(
                            moodMeterController.selectedMood.value,
                            style: SolhTextStyles.ProfileMenuGreyText,
                          );
                        }),
                        SizedBox(
                          height: 10,
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
                                  overlayColor:
                                      SolhColors.black.withOpacity(0.2),
                                  tickMarkShape: MyTickerShape()),
                              child: Obx(() {
                                return Slider(
                                    thumbColor: Colors.white,
                                    divisions: moodMeterController
                                            .moodMeterModel
                                            .value
                                            .moodList!
                                            .length -
                                        1,
                                    min: 0,
                                    max: moodMeterController.moodMeterModel
                                            .value.moodList!.length -
                                        1.toDouble(),
                                    value:
                                        moodMeterController.selectedValue.value,
                                    onChanged: (value) {
                                      moodMeterController.selectedValue.value =
                                          value;
                                      moodMeterController.changeImg(value);
                                      print(value);
                                    });
                              })),
                        ),
                        TextFormField(
                          focusNode: _focusNode,
                          controller: _reasonController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelText: "Tell Us More".tr,
                            labelStyle: TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: SolhColors.primary_green),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: SolhColors.primary_green),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: SolhColors.primary_green),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SolhGreenButton(
                              height: 50,
                              child: Text("Done".tr),
                              onPressed: continueAction != null
                                  ? continueAction
                                  : () {
                                      moodMeterController.saveMoodOfday();
                                      if (_reasonController.text.isNotEmpty) {
                                        try {
                                          moodMeterController.saveReason(
                                              _reasonController.text);
                                          myDiaryController.getMyJournals(1);
                                          Utility.showToast(
                                              'Successfully Saved to Diary');
                                          _focusNode.unfocus();
                                        } on Exception catch (e) {
                                          // TODO
                                        }
                                      }
                                      Navigator.pop(context);
                                    }),
                        ),
                      ],
                    ),
                  );
          })),
    );
  }

  getShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              height: 100,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 10,
              width: double.infinity,
              color: Colors.grey[300],
            ),
            SizedBox(
              height: 30,
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
      ..color = SolhColors.primary_green
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
