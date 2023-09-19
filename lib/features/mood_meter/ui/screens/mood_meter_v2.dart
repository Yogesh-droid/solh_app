import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/features/mood_meter/ui/controllers/get_mood_list_controller.dart';
import 'package:solh/features/mood_meter/ui/controllers/get_sub_mood_controller.dart';
import 'package:solh/features/mood_meter/ui/widgets/continue_btn.dart';
import 'package:solh/features/mood_meter/ui/widgets/custom_slider.dart';
import 'package:solh/features/mood_meter/ui/widgets/mood_image.dart';
import 'package:solh/features/mood_meter/ui/widgets/mood_title.dart';
import 'package:solh/features/mood_meter/ui/widgets/submood_list.dart';
import '../../../../widgets_constants/constants/textstyles.dart';
import '../widgets/comment_box.dart';

class MoodMeterV2 extends StatefulWidget {
  const MoodMeterV2({super.key});

  @override
  State<MoodMeterV2> createState() => _MoodMeterV2State();
}

class _MoodMeterV2State extends State<MoodMeterV2> {
  final GetMoodListController moodListController = Get.find();
  final SubMoodController subMoodController = Get.find();

  @override
  void initState() {
    if (moodListController.moodList.isEmpty) {
      moodListController.getMoodList().then((value) {
        if (moodListController.moodList.isNotEmpty) {
          subMoodController
              .getSubMoodList(moodListController.moodList[0].id ?? '');
        }
      });
    }
    super.initState();
  }

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
            child: SingleChildScrollView(
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
                    "How are you feeling today?".tr,
                    style: SolhTextStyles.QS_head_5,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  if (moodListController.error.isEmpty) MoodImage(),
                  SizedBox(height: 10),
                  if (moodListController.error.isEmpty) MoodTitle(),
                  SizedBox(height: 10),
                  if (moodListController.error.isEmpty) CustomSlider(),
                  SizedBox(height: 30),
                  Text(
                    "Choose your correct mood".tr,
                    style: SolhTextStyles.QS_body_semi_1,
                  ),
                  SizedBox(height: 10),
                  SubMoodList(),
                  SizedBox(height: 10),
                  CommentBox(),
                  SizedBox(height: 10),
                  ContinueBtn(),
                ]))));
  }
}
