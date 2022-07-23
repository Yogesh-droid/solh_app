import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solh/controllers/mood-meter/mood_meter_controller.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class MoodAnalyticPage extends StatelessWidget {
  MoodAnalyticPage({Key? key}) : super(key: key);
  final MoodMeterController moodMeterController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SolhColors.greyS200,
      appBar: getAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getMoodRightNowWidget(),
            getMoodCountWidget(context),
          ],
        ),
      ),
    );
  }

  SolhAppBar getAppBar() {
    return SolhAppBar(
      title: Text(
        'Mood Analytics',
        style: SolhTextStyles.AppBarText,
      ),
      isLandingScreen: false,
    );
  }

  Widget getMoodRightNowWidget() {
    return Container(
      color: SolhColors.white,
      margin: EdgeInsets.only(top: 20),
      height: 50,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Text(
            'Your mood right now',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF666666),
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: SolhColors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '${moodMeterController.selectedMood.value}',
                style: TextStyle(
                  fontSize: 16,
                  color: SolhColors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: SolhColors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: SolhColors.green,
                width: 1,
              ),
            ),
            child: Center(
              child: InkWell(
                onTap: (() async {}),
                child: Icon(
                  Icons.add,
                  color: SolhColors.green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getMoodCountWidget(BuildContext context) {
    return Container(
      color: SolhColors.white,
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Mood count',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                ),
              ),
              Spacer(),
              getFrequencyButton(context),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Obx(() {
            return moodMeterController.isFetchingMoodAnalytics.value
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Shimmer.fromColors(
                      baseColor: SolhColors.grey,
                      highlightColor: SolhColors.greyS200,
                      child: Container(
                        decoration: BoxDecoration(
                            color: SolhColors.greyS200, shape: BoxShape.circle),
                      ),
                    ),
                  )
                : moodMeterController
                                .moodAnlyticsModel.value.moodAnalytic!.length >
                            0 &&
                        moodMeterController
                                .selectedFrequencyMoodMap.value.length >
                            0
                    ? getMoodPieChartWidget(context)
                    : noMoodContainer(context);
          }),
          Obx(() {
            return moodMeterController.isFetchingMoodAnalytics.value
                ? Container()
                : getMoodCountListWidget(context);
          })
        ],
      ),
    );
  }

  Widget getFrequencyButton(BuildContext context) {
    return Obx(() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: SolhColors.green,
            width: 1,
          ),
        ),
        child: DropdownButtonHideUnderline(
            child: DropdownButton(
          icon: Icon(
            Icons.keyboard_arrow_down_sharp,
            color: SolhColors.green,
          ),
          value: moodMeterController.selectedFrequency.value,
          items: [
            DropdownMenuItem(
              child: Text(
                'Week',
                style: TextStyle(
                  fontSize: 16,
                  color: SolhColors.green,
                ),
              ),
              value: '7',
            ),
            DropdownMenuItem(
              child: Text(
                '30 days',
                style: TextStyle(
                  fontSize: 16,
                  color: SolhColors.green,
                ),
              ),
              value: '30',
            ),
            DropdownMenuItem(
              child: Text(
                '60 days',
                style: TextStyle(
                  fontSize: 16,
                  color: SolhColors.green,
                ),
              ),
              value: '60',
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
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                moodMeterController.moodAnlyticsModel.value.avgFeeling!.media ??
                    '',
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                color: Color(int.parse((moodMeterController
                    .moodAnlyticsModel.value.avgFeeling!.hexCode!
                    .replaceAll('#', '0xFF')))),
                shape: BoxShape.circle,
              ),
            ),
            PieChart(
                dataMap: moodMeterController.selectedFrequencyMoodMap.value,
                animationDuration: Duration(milliseconds: 800),
                colorList: moodMeterController.activeColorList.value,
                baseChartColor: SolhColors.grey,
                chartType: ChartType.ring,
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: false,
                  showChartValues: false,
                  showChartValuesOutside: false,
                ),
                chartRadius: MediaQuery.of(context).size.width / 2,
                centerText:
                    '${moodMeterController.moodAnlyticsModel.value.avgMood} % \n Average Score',
                centerTextStyle: TextStyle(
                  fontSize: 16,
                  color: SolhColors.white,
                ),
                legendOptions: LegendOptions(
                  showLegends: false,
                )),
          ],
        ),
      );
    });
  }

  Widget getMoodCountListWidget(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        for (var mood in moodMeterController.moodList)
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                        style: TextStyle(
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
                SizedBox(
                  width: 5,
                ),
                Text(
                  '$mood',
                  style: TextStyle(
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

  Widget noMoodContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              color: SolhColors.greyS200,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: SolhColors.white,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            'No mood found',
            style: TextStyle(
              fontSize: 16,
              color: SolhColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
