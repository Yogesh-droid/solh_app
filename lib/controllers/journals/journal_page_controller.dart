import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/model/journals/journals_response_model.dart';
import 'package:solh/services/network/error_handling.dart';
import 'package:solh/services/network/network.dart';
import 'package:video_player/video_player.dart';
import '../../constants/api.dart';

class JournalPageController extends GetxController {
  var journalsResponseModel = JournalsResponseModel().obs;
  TextEditingController descriptionController = TextEditingController();
  var anonymousProfilePositionL = 4.0.obs;
  var anonymousProfilePositionT = 15.0.obs;
  var nomalProfilePositionL = 24.0.obs;
  var nomalProfilePositionT = 2.0.obs;
  var isAnonymousSelected = false.obs;
  var anonymousProfileRadius = 3.5.w.obs;
  var nomalProfileRadius = 6.w.obs;

  var journalsList = <Journals>[].obs;
  var trendingJournalsList = <Journals>[].obs;
  var outputPath = "".obs;
  var selectedDiary = Journals().obs;
  var isLoading = false.obs;
  int endPageLimit = 1;
  int pageNo = 1;
  int videoIndex = 0;
  int myVideoIndex = 0;
  int trendingVideoIndex = 0;
  bool isPlayingMyPostVideo = false;
  bool isPlayingTrendingPostVideo = false;
  var videoPlayerController = [].obs;
  var tredingVideoPlayerController = [].obs;
  var myVideoPlayerControllers = [].obs;
  var selectedGroupId = "".obs;
  var isScrollingStarted = false.obs;
  var isImageUploading = false.obs;
  var isTrendingLoading = false.obs;

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

  Future<void> getTrendingJournals() async {
    isTrendingLoading.value = true;
    try {
      Map<String, dynamic> map = await Network.makeHttpGetRequestWithToken(
          "${APIConstants.api}/api/trending");
      journalsResponseModel.value = JournalsResponseModel.fromJson(map);
      trendingJournalsList.value
          .addAll(journalsResponseModel.value.journals ?? []);
      tredingVideoPlayerController.value.forEach((element) {
        if (element != null) {
          element.forEach((key, value) {
            value.dispose();
          });
        }
      });
      tredingVideoPlayerController.value.clear();
      for (int i = 0; i < trendingJournalsList.value.length; i++) {
        if (trendingJournalsList[i].mediaType == "video/mp4") {
          if (videoPlayerController.value.isEmpty) {
            videoIndex = i;
          }

          tredingVideoPlayerController.value.add({
            i: VideoPlayerController.network(
                trendingJournalsList.value[i].mediaUrl!)
              ..initialize()
          });
        } else {
          tredingVideoPlayerController.value.add(null);
        }
      }
    } on Exception catch (e) {
      ErrorHandler.handleException(e.toString());
    }
    isTrendingLoading.value = false;
  }

  void playVideo(int index) {
    isPlayingMyPostVideo = false;
    isPlayingTrendingPostVideo = false;
    if (videoPlayerController.value[index] != null) {
      if (videoIndex != index) {
        videoPlayerController.value[index]![index]!.pause();
      }
      if (videoPlayerController.value[index]![index]!.value.isPlaying) {
        videoPlayerController.value[index]![index]!.pause();
      } else {
        if (!isPlayingMyPostVideo && !isPlayingTrendingPostVideo) {
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

  void playTrendingPostVideo(int index) {
    isPlayingTrendingPostVideo = true;
    if (tredingVideoPlayerController.value[index] != null) {
      if (trendingVideoIndex != index) {
        tredingVideoPlayerController.value[index]![index]!.pause();
      }
      if (tredingVideoPlayerController.value[index]![index]!.value.isPlaying) {
        tredingVideoPlayerController.value[index]![index]!.pause();
      } else {
        tredingVideoPlayerController.value[index]![index]!.play();
        trendingVideoIndex = index;
      }
    }
  }

  @override
  void onInit() {
    getAllJournals(1);
    getTrendingJournals();
    super.onInit();
  }
}
