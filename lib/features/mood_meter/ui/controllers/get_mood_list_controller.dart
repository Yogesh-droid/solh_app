import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/mood_meter/domain/entities/mood_meter_entity.dart';
import 'package:solh/features/mood_meter/domain/usecases/mood_meter_usecase.dart';

import '../../data/models/mood_meter_model.dart';

class GetMoodListController extends GetxController {
  // di
  final MoodMeterUsecase moodMeterUsecase;

  GetMoodListController({required this.moodMeterUsecase});

  // state variable
  var moodList = MoodMeterEntity().obs;
  var error = ''.obs;
  var isLoading = false.obs;
  var defaultIndex = 0.0.obs;
  int resetIndex = 0;
  var selectedMood = MoodList().obs; // index of selected mood from moodList

  Future<void> getMoodList() async {
    try {
      isLoading.value = true;
      error.value = '';
      DataState<MoodMeterEntity> dataState = await moodMeterUsecase.call(
          RequestParams(
              url: "${APIConstants.api}/api/app-mood-list",
              apiMethods: ApiMethods.get));
      if (dataState.data != null) {
        resetIndex = dataState.data!.defaultIndex!;
        defaultIndex.value = dataState.data!.defaultIndex!.toDouble();

        moodList.value = dataState.data!;
        selectedMood.value =
            dataState.data!.moodList![defaultIndex.value.toInt()];
      } else {
        error.value = dataState.exception.toString();
      }
    } on Exception catch (e) {
      error.value = e.toString();
    }
    isLoading.value = false;
  }

  /* var isLoading = false.obs;
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
  RxList<Color> activeColorList = RxList<Color>();

  var selectedValue = 0.0.obs;

  void changeImg(double value) {
    print(value.toInt().toString() + 'this is value');

    // print(gifList.length.toString() + ' this is the length of the list');
    selectedGif.value = gifList[value.toInt()];
    selectedMood.value = moodList[value.toInt()];
  }

  Future<void> getMoodList() async {
    isLoading.value = true;
    Map<String, dynamic> map =
        await Network.makeGetRequest('${APIConstants.api}/api/mood');

    if (map['success']) {
      moodMeterModel.value = MoodMeterModel.fromJson(map);
      colorList.clear();
      moodList = [];
      moodMeterModel.value.moodList!.forEach((element) {
        moodList.add(element.name ?? '');
        gifList.add(element.media ?? '');
        int color = int.parse((element.color!.replaceAll('#', '0xFF')));
        colorList.add(Color(color));
      });
      selectedGif.value = gifList[0];
      selectedMood.value = moodList[0];
    }
    print(moodList.length.toString() + ' this is the length of the list');
    print(gifList.length.toString() + ' this is the length of the list');
    // print(
    //     colorList.value.length.toString() + ' this is the length of the list');
    isLoading.value = false;
  }

  Future<void> saveMoodOfday(String text) async {
    await Network.makePostRequestWithToken(
        url: '${APIConstants.api}/api/mood-today',
        body: {
          'mood':
              moodMeterModel.value.moodList![selectedValue.value.toInt()].sId,
          'comment': text
        });
  }

  Future<void> saveReason(String reason) async {
    await Network.makePostRequestWithToken(
        url: '${APIConstants.api}/api/feeling-log',
        body: {
          'feelings':
              moodMeterModel.value.moodList![selectedValue.value.toInt()].sId,
          "description": reason
        });
  }

  Future<void> getMoodAnalytics(int days) async {
    isFetchingMoodAnalytics.value = true;
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        '${APIConstants.api}/api/mood-analytics?days=$days');
    moodAnlyticsModel.value = MoodAnalyticsModel.fromJson(map);
    selectedFrequencyMoodMap.clear();
    activeColorList.clear();
    moodAnlyticsModel.value.moodAnalytic!.forEach((element) {
      selectedFrequencyMoodMap[element.name ?? ''] =
          element.moodCount!.toDouble();
      int color = int.parse((element.hexCode!.replaceAll('#', '0xFF')));
      activeColorList.add(Color(color));
    });
    moodAnlyticsModel.refresh();
    isFetchingMoodAnalytics.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    if (moodList.isEmpty) {
      getMoodList();
    }
  } */
}
