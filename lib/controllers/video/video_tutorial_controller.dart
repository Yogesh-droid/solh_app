import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:solh/model/video_tutorial.dart';

class VideoTutorialController extends GetxController {
  var videoList = <VideoTutorialModel>[].obs;
  var isLoading = false.obs;
  Future<void> getVideolist() async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2), () {
      print('fetching video');
      for (int i = 0; i <= 5; i++) {
        print(i);
        videoList.value.add(VideoTutorialModel(
            name: 'Name of the video $i',
            description: "Video discription in the string from youtube....",
            image:
                'https://i.picsum.photos/id/1025/4951/3301.jpg?hmac=_aGh5AtoOChip_iaMo8ZvvytfEojcgqbCH7dzaz-H8Y',
            url:
                "https://www.youtube.com/watch?v=5Eqb_-j3FDA&ab_channel=CokeStudio"));
      }
      videoList.refresh();
      print(videoList.value.length.toString() + ' Is the l');
    });
    isLoading.value = false;
  }

  @override
  void onInit() {
    getVideolist();
    super.onInit();
  }
}
