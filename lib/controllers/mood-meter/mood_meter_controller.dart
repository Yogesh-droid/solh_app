import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/mood-meter/mood_meter.dart';
import 'package:solh/services/network/network.dart';

/* 
 'Bohut jyada happy',
    'happy',
    'Thoda happy',
    'Thoda confused',
    'Confused',
    'bohut jyada frustrated',
    'bahut jyada sad',
    'Ekdum hyper',
    'very angry',
    'toot gaya hoo ekdum',
    'bas bahut hua, dekh li duniya',

 'https://media.giphy.com/media/JmBXdjfIblJDi/giphy.gif',
    'https://media.giphy.com/media/d1E2IByItLUuONMc/giphy.gif',
    'https://media.giphy.com/media/6pUBXVTai18Iw/giphy.gif',
    'https://media.giphy.com/media/100QWMdxQJzQC4/giphy.gif',
    'https://media.giphy.com/media/Xev2JdopBxGj1LuGvt/giphy.gif',
    'https://media.giphy.com/media/JmBXdjfIblJDi/giphy.gif',
    'https://media.giphy.com/media/d1E2IByItLUuONMc/giphy.gif',
    'https://media.giphy.com/media/6pUBXVTai18Iw/giphy.gif',
    'https://media.giphy.com/media/100QWMdxQJzQC4/giphy.gif',
    'https://media.giphy.com/media/Xev2JdopBxGj1LuGvt/giphy.gif',
    'https://media.giphy.com/media/JmBXdjfIblJDi/giphy.gif',
    'https://media.giphy.com/media/d1E2IByItLUuONMc/giphy.gif',
    


 */

class MoodMeterController extends GetxController {
  var isLoading = false.obs;
  List<String> gifList = [];
  List<String> moodList = [];
  var moodMeterModel = MoodMeterModel().obs;

  var selectedGif = 'https://media.giphy.com/media/JmBXdjfIblJDi/giphy.gif'.obs;
  var selectedMood = 'Bohut jyada happy'.obs;

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
}
