import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/model/journals/journals_response_model.dart';
import 'package:solh/services/network/error_handling.dart';
import 'package:solh/services/network/network.dart';
import 'package:video_player/video_player.dart';
import '../../constants/api.dart';

class JournalPageController extends GetxController {
  var journalsResponseModel = JournalsResponseModel().obs;
  TextEditingController descriptionController = TextEditingController();

  var journalsList = <Journals>[].obs;
  var outputPath = "".obs;
  var selectedDiary = Journals().obs;
  var isLoading = false.obs;
  int endPageLimit = 1;
  int pageNo = 1;
  int videoIndex = 0;
  int myVideoIndex = 0;
  bool isPlayingMyPostVideo = false;
  var videoPlayerController = [].obs;
  var myVideoPlayerControllers = [].obs;
  var selectedGroupId = "".obs;
  var isScrollingStarted = false.obs;
  var isImageUploading = false.obs;

  Future<void> getAllJournals(int pageNo, {String? groupId}) async {
    print('started gettting all journals $pageNo');
    try {
      if (pageNo == 1) {
        isLoading.value = true;
      }
      if (pageNo <= endPageLimit) {
        print('trying to get all journals');
        Map<String, dynamic> map = groupId != null
            ? await await Network.makeHttpGetRequestWithToken(
                "${APIConstants.api}/api/get-group-journal?page=$pageNo&group=${groupId}")
            : await Network.makeHttpGetRequestWithToken(
                "${APIConstants.api}/api/get-journals?page=$pageNo");

        print('map: ' + map.toString());

        journalsResponseModel.value = JournalsResponseModel.fromJson(map);
        journalsList.value.addAll(journalsResponseModel.value.journals ?? []);

        endPageLimit = journalsResponseModel.value.totalPages!;
        this.pageNo = pageNo;
        videoPlayerController.value.forEach((element) {
          if (element != null) {
            element.forEach((key, value) {
              value.dispose();
            });
          }
        });
        videoPlayerController.value.clear();
        for (int i = 0; i < journalsList.value.length; i++) {
          if (journalsList[i].mediaType == "video/mp4") {
            if (videoPlayerController.value.isEmpty) {
              videoIndex = i;
            }

            videoPlayerController.value.add({
              i: VideoPlayerController.network(journalsList.value[i].mediaUrl!)
                ..initialize()
            });
          } else {
            videoPlayerController.value.add(null);
          }
        }
      }
    } on Exception catch (e) {
      ErrorHandler.handleException(e.toString());
    }
    isLoading.value = false;
  }

  void playVideo(int index) {
    isPlayingMyPostVideo = false;
    if (videoPlayerController.value[index] != null) {
      if (videoIndex != index) {
        videoPlayerController.value[index]![index]!.pause();
      }
      if (videoPlayerController.value[index]![index]!.value.isPlaying) {
        videoPlayerController.value[index]![index]!.pause();
      } else {
        if (!isPlayingMyPostVideo) {
          videoPlayerController.value[index]![index]!.play();
          videoIndex = index;
        }
      }
    }
  }

  void playMyPostVideo(int index) {
    isPlayingMyPostVideo = true;
    if (myVideoPlayerControllers.value[index] != null) {
      if (myVideoIndex != index) {
        myVideoPlayerControllers.value[index]![index]!.pause();
      }
      if (myVideoPlayerControllers.value[index]![index]!.value.isPlaying) {
        myVideoPlayerControllers.value[index]![index]!.pause();
      } else {
        myVideoPlayerControllers.value[index]![index]!.play();
        myVideoIndex = index;
      }
    }
  }

  @override
  void onInit() {
    getAllJournals(1);
    super.onInit();
  }
}
