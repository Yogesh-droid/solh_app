import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/mood-meter/mood_meter_controller.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/image_container.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

import '../../../features/mood_meter/ui/screens/mood_meter_v2.dart';

class MoodAnalyticPage extends StatelessWidget {
  MoodAnalyticPage({
    Key? key,
  }) : super(key: key);
  final MoodMeterController moodMeterController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        moodMeterController.selectedFrequency.value = '7';
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        // backgroundColor: SolhColors.greyS200,
        appBar: getAppBar(moodMeterController, context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              getMoodRightNowWidget(context),
              const GetHelpDivider(),
              getMoodCountWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  SolhAppBar getAppBar(MoodMeterController moodMeterController, context) {
    return SolhAppBar(
      title: Text(
        'Mood Analytics'.tr,
        style: SolhTextStyles.QS_body_1_bold,
      ),
      callback: (() {
        moodMeterController.selectedFrequency.value = '7';
        Navigator.pop(context);
      }),
      isLandingScreen: false,
    );
  }

  Widget getMoodRightNowWidget(context) {
    return Container(
      color: SolhColors.white,
      margin: const EdgeInsets.only(top: 20),
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        onTap: () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MoodMeterV2()));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/app-bar/mood-meter.svg'),
            const SizedBox(
              width: 15,
            ),
            Text('Tap to add current mood'.tr,
                style: SolhTextStyles.QS_body_1_med),

            const Spacer(),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 10),
            //   decoration: BoxDecoration(
            //     color: SolhColors.grey,
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Center(
            //     child: Text(
            //       '${moodMeterController.selectedMood.value}',
            //       style: TextStyle(
            //         fontSize: 16,
            //         color: SolhColors.white,
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   width: 10,
            // ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 10),
            //   decoration: BoxDecoration(
            //     color: SolhColors.white,
            //     shape: BoxShape.circle,
            //     border: Border.all(
            //       color: SolhColors.green,
            //       width: 1,
            //     ),
            //   ),
            //   child: Center(
            //     child: InkWell(
            //       onTap: (() async {}),
            //       child: Icon(
            //         Icons.add,
            //         color: SolhColors.green,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget getMoodCountWidget(BuildContext context) {
    return Obx(() {
      return moodMeterController.isFetchingMoodAnalytics.value
          ? MyLoader()
          : Column(
              children: [
                Container(
                  color: SolhColors.white,
                  margin: const EdgeInsets.only(top: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Mood count'.tr,
                              style: SolhTextStyles.QS_body_semi_1),
                          const Spacer(),
                          getFrequencyButton(context),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        return moodMeterController
                                    .moodAnlyticsModel.value.moodAnalytic ==
                                null
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                child: Shimmer.fromColors(
                                  baseColor: SolhColors.grey,
                                  highlightColor: SolhColors.greyS200,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: SolhColors.greyS200,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                              )
                            : moodMeterController.moodAnlyticsModel.value
                                        .moodAnalytic!.isNotEmpty &&
                                    moodMeterController.selectedFrequencyMoodMap
                                        .value.isNotEmpty
                                ? getMoodPieChartWidget(context)
                                : noMoodContainer(context);
                      }),
                      getMoodHistoryList(),
                      emotionsCount(),
                      // Obx(() {
                      //   return moodMeterController.isFetchingMoodAnalytics.value
                      //       ? getMoodListShimmer(context)
                      //       : getMoodCountListWidget(context);
                      // }),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),

                // getResultCard()
              ],
            );
    });
  }

  Widget getMoodHistoryList() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Obx(() {
              return InkWell(
                onTap: () {
                  moodMeterController.currentSelectedMood.value =
                      moodMeterController.moodAnlyticsModel.value
                              .moodAnalytic![index].sId ??
                          '';
                  moodMeterController.getSubMoodAnalytics(
                      moodMeterController.selectedFrequency.value.toString(),
                      moodMeterController.moodAnlyticsModel.value
                              .moodAnalytic![index].sId ??
                          '');
                },
                child: Container(
                  width: 90,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color:
                          Color(int.parse((moodMeterController.moodAnlyticsModel.value.moodAnalytic![index].hexCode!.replaceAll('#', '0xFF'))))
                              .withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                      border: moodMeterController.currentSelectedMood.value ==
                              moodMeterController.moodAnlyticsModel.value
                                  .moodAnalytic![index].sId
                          ? Border.all(
                              color: Color(int.parse((moodMeterController
                                  .moodAnlyticsModel
                                  .value
                                  .moodAnalytic![index]
                                  .hexCode!
                                  .replaceAll('#', '0xFF')))))
                          : null),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SimpleImageContainer(
                        imageUrl: moodMeterController.moodAnlyticsModel.value
                                .moodAnalytic![index].media ??
                            '',
                        radius: 40,
                      ),
                      Text(
                        moodMeterController.moodAnlyticsModel.value
                                .moodAnalytic![index].name ??
                            '',
                        style: SolhTextStyles.QS_cap_2_semi,
                      ),
                      Text(
                        moodMeterController.moodAnlyticsModel.value
                            .moodAnalytic![index].moodCount
                            .toString(),
                        style: SolhTextStyles.QS_cap_semi,
                      ),
                    ],
                  ),
                ),
              );
            });
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 10,
            );
          },
          itemCount:
              moodMeterController.moodAnlyticsModel.value.moodAnalytic!.length),
    );
  }

  Widget emotionsCount() {
    return moodMeterController.isFetchingSubMoodAnalytics.value
        ? SizedBox(height: 200, child: ButtonLoadingAnimation())
        : (moodMeterController.subMoodAnlyticsModel.value.data == null ||
                moodMeterController.subMoodAnlyticsModel.value.data!.isEmpty
            ? Container()
            : SizedBox(
                width: 100.w,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        '${moodMeterController.subMoodAnlyticsModel.value.mood!.name} Emotions',
                        style: SolhTextStyles.QS_body_2_semi,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        runSpacing: 10,
                        spacing: 10,
                        children: moodMeterController
                            .subMoodAnlyticsModel.value.data!
                            .map(
                              (e) => Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: SolhColors.red_shade_3,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('${e.moodCount ?? 0}',
                                        style: SolhTextStyles.QS_body_2_semi
                                            .copyWith(
                                                color: SolhColors.primaryRed)),
                                    Text(
                                      e.name ?? '',
                                      style: SolhTextStyles.QS_caption,
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ));
  }

  Widget getFrequencyButton(BuildContext context) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: SolhColors.primary_green,
            width: 1,
          ),
        ),
        child: DropdownButtonHideUnderline(
            child: DropdownButton(
          icon: const Icon(
            Icons.keyboard_arrow_down_sharp,
            color: SolhColors.primary_green,
          ),
          value: moodMeterController.selectedFrequency.value,
          items: [
            DropdownMenuItem(
              value: '7',
              child: Text(
                'Week'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  color: SolhColors.primary_green,
                ),
              ),
            ),
            DropdownMenuItem(
              value: '30',
              child: Text(
                '30 days'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  color: SolhColors.primary_green,
                ),
              ),
            ),
            DropdownMenuItem(
              value: '60',
              child: Text(
                '60 days'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  color: SolhColors.primary_green,
                ),
              ),
            ),
          ],
          onChanged: (value) {
            moodMeterController.selectedFrequency.value = value.toString();
            moodMeterController.getMoodAnalytics(int.parse(value.toString()));
            moodMeterController.selectedFrequencyMoodMap.refresh();
            moodMeterController.colorList.refresh();
          },
        )),
      );
    });
  }

  Widget getMoodPieChartWidget(BuildContext context) {
    return Obx(() {
      return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                moodMeterController.moodAnlyticsModel.value.avgFeeling!.media !=
                        null
                    ? SimpleImageContainer(
                        imageUrl: moodMeterController
                                .moodAnlyticsModel.value.avgFeeling!.media ??
                            '',
                        radius: 110,
                      )
                    : Text(
                        'No mood recorded',
                        style: SolhTextStyles.QS_caption_bold,
                      ),
                Text(
                  moodMeterController
                          .moodAnlyticsModel.value.avgFeeling!.name ??
                      '',
                  style: SolhTextStyles.QS_cap_2_semi,
                ),
              ],
            ),
            // Container(
            //   height: MediaQuery.of(context).size.height * 0.4,
            //   width: MediaQuery.of(context).size.width * 0.4,
            //   decoration: BoxDecoration(
            //     color: moodMeterController
            //                 .moodAnlyticsModel.value.avgFeeling!.hexCode !=
            //             null
            //         ? Color(int.parse((moodMeterController
            //             .moodAnlyticsModel.value.avgFeeling!.hexCode!
            //             .replaceAll('#', '0xFF'))))
            //         : Colors.white,
            //     shape: BoxShape.circle,
            //   ),
            // ),
            PieChart(
                dataMap: moodMeterController.selectedFrequencyMoodMap.value,
                animationDuration: const Duration(milliseconds: 800),
                colorList: moodMeterController.activeColorList.value,
                baseChartColor: SolhColors.grey,
                chartType: ChartType.ring,
                ringStrokeWidth: 30,
                chartValuesOptions: const ChartValuesOptions(
                  showChartValueBackground: false,
                  showChartValues: false,
                  showChartValuesOutside: false,
                ),
                chartRadius: MediaQuery.of(context).size.width / 2,
                // centerText:
                //     '${moodMeterController.moodAnlyticsModel.value.avgMood} % \n Average Score',
                // centerTextStyle: const TextStyle(
                //   fontSize: 18,
                //   color: SolhColors.white,
                //   shadows: [
                //     Shadow(
                //       blurRadius: 2,
                //       color: Colors.grey,
                //       offset: Offset(1, 1),
                //     ),
                //   ],
                // ),
                legendOptions: const LegendOptions(
                  showLegends: false,
                )),
          ],
        ),
      );
    });
  }

  Widget getMoodCountListWidget(BuildContext context) {
    print("mood number ${moodMeterController.moodList.length}");
    return Wrap(
      direction: Axis.horizontal,
      children: [
        for (var mood in moodMeterController.moodList)
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    // color: moodMeterController.colorList.value[
                    //     moodMeterController.selectedFrequencyMoodMap.keys
                    //         .toList()
                    //         .indexOf(mood)],
                    color: moodMeterController.colorList
                        .value[moodMeterController.moodList.indexOf(mood)],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Obx(() => Text(
                        '${moodMeterController.selectedFrequencyMoodMap.value[mood] ?? 0}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFFFFF),
                          shadows: [
                            Shadow(
                              blurRadius: 2,
                              color: Color(0xFF000000),
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      )),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '$mood',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget getMoodListShimmer(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        for (var i = 0; i < 10; i++)
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Shimmer.fromColors(
                  period: const Duration(milliseconds: 800),
                  baseColor: SolhColors.grey.withOpacity(0.4),
                  highlightColor: SolhColors.grey,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: SolhColors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    height: 30,
                    width: 40,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Shimmer.fromColors(
                    period: const Duration(milliseconds: 800),
                    baseColor: SolhColors.grey.withOpacity(0.4),
                    highlightColor: SolhColors.grey,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: SolhColors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      height: 10,
                      width: 30,
                    )),
              ],
            ),
          ),
      ],
    );
  }

  Widget noMoodContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: const BoxDecoration(
              color: SolhColors.greyS200,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: const BoxDecoration(
              color: SolhColors.white,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            'No mood found'.tr,
            style: const TextStyle(
              fontSize: 16,
              color: SolhColors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget getResultCard() {
    return moodMeterController.moodAnlyticsModel.value.moodAnalytic != null &&
            moodMeterController.moodAnlyticsModel.value.moodAnalytic!.isEmpty
        ? Container()
        : Obx(() {
            return Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: moodMeterController
                            .moodAnlyticsModel.value.avgFeeling!.hexCode !=
                        null
                    ? moodMeterController.moodAnlyticsModel.value.avgMood !=
                            null
                        ? Color(int.parse((moodMeterController
                            .moodAnlyticsModel.value.avgFeeling!.hexCode!
                            .replaceAll('#', '0xFF'))))
                        : Colors.grey
                    : Colors.grey,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    moodMeterController.moodAnlyticsModel.value.moodAnalytic ==
                            null
                        ? ''
                        : moodMeterController
                                .moodAnlyticsModel.value.moodAnalytic!.isEmpty
                            ? ''
                            : (moodMeterController
                                        .moodAnlyticsModel.value.avgMood !=
                                    null
                                ? "${moodMeterController.moodAnlyticsModel.value.avgMood} % \n Average Score"
                                : 'Loading ...'.tr),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: SolhColors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 2,
                          color: Colors.grey,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    endIndent: 20,
                    indent: 20,
                    color: SolhColors.white,
                    thickness: 1,
                  ),
                  Text(
                    moodMeterController.moodAnlyticsModel.value.moodAnalytic ==
                            null
                        ? ''
                        : moodMeterController
                                .moodAnlyticsModel.value.moodAnalytic!.isEmpty
                            ? ''
                            : (moodMeterController
                                        .moodAnlyticsModel.value.avgMood !=
                                    null
                                ? "${moodMeterController.moodAnlyticsModel.value.avgFeeling!.name} \n Average Mood"
                                : 'Loading ...'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: SolhColors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 2,
                          color: Colors.grey,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
  }
}
