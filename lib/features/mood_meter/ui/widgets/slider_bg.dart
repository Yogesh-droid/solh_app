import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/mood_meter/ui/controllers/get_mood_list_controller.dart';

class SliderBg extends StatelessWidget {
  const SliderBg({super.key});

  @override
  Widget build(BuildContext context) {
    final GetMoodListController getMoodListController = Get.find();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: Obx(() => Row(
          children: getMoodListController.moodList.value.moodList!
              .map(
                (element) => Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(
                          int.parse('0xFF${element.hexCode!.split('#')[1]}')),
                      borderRadius: BorderRadius.only(
                          topLeft: getMoodListController.moodList.value.moodList!.indexOf(element) == 0
                              ? Radius.circular(10)
                              : Radius.zero,
                          bottomLeft: getMoodListController.moodList.value.moodList!
                                      .indexOf(element) ==
                                  0
                              ? Radius.circular(10)
                              : Radius.zero,
                          topRight: getMoodListController.moodList.value.moodList!
                                      .indexOf(element) ==
                                  getMoodListController.moodList.value.moodList!.length -
                                      1
                              ? Radius.circular(10)
                              : Radius.zero,
                          bottomRight: getMoodListController.moodList.value.moodList!
                                      .indexOf(element) ==
                                  getMoodListController.moodList.value.moodList!.length - 1
                              ? Radius.circular(10)
                              : Radius.zero),
                    ),
                  ),
                ),
              )
              .toList())),
      // child: Row(children: [
      //   Expanded(
      //     child: Container(
      //       decoration: BoxDecoration(
      //           color: Color(0xFFF71C25),
      //           borderRadius: BorderRadius.only(
      //               topLeft: Radius.circular(10),
      //               bottomLeft: Radius.circular(10))),
      //     ),
      //   ),
      //   Expanded(
      //     child: Container(
      //       color: Color(0xFFE96A00),
      //     ),
      //   ),
      //   Expanded(
      //     child: Container(
      //       color: Color(0xFFF7B912),
      //     ),
      //   ),
      //   Expanded(
      //     child: Container(
      //       color: Color(0xFF71B644),
      //     ),
      //   ),
      //   Expanded(
      //     child: Container(
      //       decoration: BoxDecoration(
      //           color: Color(0xFF01A54D),
      //           borderRadius: BorderRadius.only(
      //               topRight: Radius.circular(10),
      //               bottomRight: Radius.circular(10))),
      //     ),
      //   ),
      // ]),
    );
  }
}
