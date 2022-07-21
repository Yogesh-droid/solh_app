import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/mood-meter/mood_analytics_model.dart';
import 'package:solh/model/mood-meter/mood_meter.dart';
import 'package:solh/services/network/network.dart';

class MoodMeterController extends GetxController {
  var isLoading = false.obs;
  List<String> gifList = [];
  List<String> moodList = [];
  var moodMeterModel = MoodMeterModel().obs;
  var moodAnlyticsModel = MoodAnalyticsModel().obs;
  var selectedFrequency = '7'.obs;
  RxMap<String, double> selectedFrequencyMoodMap = Map<String, double>().obs;
  // var selectedFrequencyMoodMap = {}.obs;
  var isFetchingMoodAnalytics = false.obs;

  var selectedGif = 'https://media.giphy.com/media/JmBXdjfIblJDi/giphy.gif'.obs;
  var selectedMood = 'happy'.obs;
  //var colorList = [].obs;
  RxList<Color> colorList = RxList<Color>();

  var selectedValue = 0.0.obs;

  void changeImg(double value) {
    print(value.toInt().toString() + 'this is value');

    print(gifList.length.toString() + ' this is the length of the list');
    selectedGif.value = gifList[value.toInt()];
    selectedMood.value = moodList[value.toInt()];
  }

  Future<void> getMoodList() async {
    isLoading.value = true;
    Map<String, dynamic> map =
        await Network.makeGetRequest('${APIConstants.api}/api/mood');

    if (map['success']) {
      moodMeterModel.value = MoodMeterModel.fromJson(map);
      moodMeterModel.value.moodList!.forEach((element) {
        moodList.add(element.name ?? '');
        gifList.add(element.media ?? '');
      });
      selectedGif.value = gifList[0];
      selectedMood.value = moodList[0];
    }
    isLoading.value = false;
  }

  Future<void> saveMoodOfday() async {
    Map<String, dynamic> map = await Network.makePostRequestWithToken(
        url: '${APIConstants.api}/api/mood-today',
        body: {
          'mood':
              moodMeterModel.value.moodList![selectedValue.value.toInt()].sId
        });
  }

  Future<void> getMoodAnalytics(int days) async {
    isFetchingMoodAnalytics.value = true;
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        '${APIConstants.api}/api/mood-analytics?days=$days');
    moodAnlyticsModel.value = MoodAnalyticsModel.fromJson(map);
    selectedFrequencyMoodMap.value.clear();
    colorList.value.clear();
    // moodAnlyticsModel.value.moodAnalytic!.forEach((element) {
    //   selectedFrequencyMoodMap.value[element.name ?? ''] =
    //       element.moodCount!.toDouble();
    //   int color = int.parse((element.hexCode!.replaceAll('#', '0xFF')));
    //   colorList.value.add(Color(color));
    // });
    isFetchingMoodAnalytics.value = false;
  }
}
