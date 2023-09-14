import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/features/mood_meter/ui/controllers/slider_controller.dart';
import 'package:solh/features/mood_meter/ui/widgets/large_thumb_shape.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'slider_bg.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final SliderController sliderController = Get.find();
    return Stack(
      alignment: Alignment.center,
      children: [
        SliderBg(),
        Obx(() => SliderTheme(
              data: SliderThemeData(thumbShape: LargeThumbShape()),
              child: Slider(
                value: sliderController.value.value,
                onChanged: (value) {
                  sliderController.value.value = value;
                },
                divisions: 5,
                thumbColor: SolhColors.primary_green,
                activeColor: Colors.transparent,
                inactiveColor: Colors.transparent,
              ),
            ))
      ],
    );
  }
}
