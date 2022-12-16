import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/video_tutorial.dart';
import 'package:solh/services/network/network.dart';

class VideoTutorialController extends GetxController {
  var videoList = <TutorialList>[].obs;
  var remainingVideos = <TutorialList>[].obs;
  var currentVideo = TutorialList().obs;

  var isLoading = false.obs;
  Future<void> getVideolist() async {
    isLoading.value = true;
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        "${APIConstants.api}/api/custom/get-tutorial-list");
    VideoTutorialModel videoTutorialModel = VideoTutorialModel.fromJson(map);
    videoList.value = videoTutorialModel.tutorialList ?? [];
    isLoading.value = false;
  }

  void getRemainingVideos(
      TutorialList tutorialList, TutorialList currentVideo) {
    remainingVideos.remove(tutorialList);
    remainingVideos.add(currentVideo);
    this.currentVideo.value = tutorialList;
    remainingVideos.refresh();
  }

  @override
  void onInit() {
    getVideolist();
    super.onInit();
  }
}
