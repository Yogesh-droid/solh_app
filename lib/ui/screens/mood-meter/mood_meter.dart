import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/mood-meter/mood_meter_controller.dart';
import 'package:solh/controllers/my_diary/my_diary_controller.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

import '../../../features/mood_meter/ui/widgets/gradient_slider_tracker.dart';
import '../../../features/mood_meter/ui/widgets/slider_ticker_shape.dart';
import '../../../features/mood_meter/ui/widgets/thumb_shape.dart';

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
                                      moodMeterController.saveMoodOfday(
                                          _reasonController.text);
                                      if (_reasonController.text.isNotEmpty) {
                                        try {
                                          moodMeterController.saveReason(
                                              _reasonController.text);
                                          myDiaryController.getMyJournals(1);
                                          Utility.showToast(
                                              'Successfully Saved to Diary');
                                          _focusNode.unfocus();
                                        } on Exception {
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
