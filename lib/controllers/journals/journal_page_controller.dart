import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/model/journals/journals_response_model.dart';
import 'package:solh/model/journals/liked_users_list.dart';
import 'package:solh/services/network/error_handling.dart';
import 'package:solh/services/network/network.dart';
import 'package:video_player/video_player.dart';
import '../../constants/api.dart';

class JournalPageController extends GetxController {
  var journalsResponseModel = JournalsResponseModel().obs;
  var likedUserList = LikedUsersListModel().obs;
  var isLikedUserListLoading = false.obs;
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
  int? nextPage = 2;
  int pageNo = 1;
  int videoIndex = 0;
  int myVideoIndex = 0;
  int trendingVideoIndex = 0;
  bool isPlayingMyPostVideo = false;
  bool isPlayingTrendingPostVideo = false;
  var videoPlayerController = <Map<int, VideoPlayerController>>[].obs;
  var tredingVideoPlayerController = [].obs;
  var myVideoPlayerControllers = <Map<int, VideoPlayerController>>[].obs;
  var selectedGroupId = "".obs;
  int selectedGroupIndex = 0;
  var selectedGroupName = "".obs;
  var selectedGroupImg = "".obs;
  var isScrollingStarted = false.obs;
  var isImageUploading = false.obs;
  var isTrendingLoading = false.obs;
  var announcementData = ''.obs;
  var dropdownValue = 'Publicaly'.obs;
  ScrollController customeScrollController = ScrollController();

  Future<void> getAllJournals(int pageNo, {String? groupId}) async {
    print('started gettting all journals $pageNo');
    try {
      if (pageNo == 1) {
        isLoading.value = true;
      }
      if (nextPage != null) {
        print('trying to get all journals');
        Map<String, dynamic> map = groupId != null
            ? await await Network.makeGetRequestWithToken(
                "${APIConstants.api}/api/v1/get-group-journal?pageNumber=$pageNo&group=${groupId}")
            : await Network.makeGetRequestWithToken(
                "${APIConstants.api}/api/v2/posts?pageNumber=$pageNo");

        print('map: ' + map.toString());

        journalsResponseModel.value =
            JournalsResponseModel.fromJson(map['data']);
        journalsList.addAll(journalsResponseModel.value.journals ?? []);
        nextPage = journalsResponseModel.value.next != null
            ? journalsResponseModel.value.next!.pageNumber
            : null;
        this.pageNo = pageNo;
        videoPlayerController.forEach((element) {
          element.forEach((key, value) {
            value.dispose();
          });
        });
        videoPlayerController.clear();
        for (int i = 0; i < journalsList.length; i++) {
          if (journalsList[i].mediaType == "video/mp4") {
            if (videoPlayerController.isEmpty) {
              videoIndex = i;
            }
            VideoPlayerController vc =
                VideoPlayerController.network(journalsList[i].mediaUrl!);

            videoPlayerController.add({i: vc..initialize()});
          } else {
            videoPlayerController.add({});
          }
        }
      }
    } on Exception catch (e) {
      ErrorHandler.handleException(e.toString());
    }
    isLoading.value = false;
  }

  Future<void> getTrendingJournals({bool orgToggle = false}) async {
    isTrendingLoading.value = true;
    try {
      if (orgToggle) {
        trendingJournalsList.clear();
      }
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/v1/trending?orgToggle=$orgToggle");
      journalsResponseModel.value = JournalsResponseModel.fromJson(map['data']);
      trendingJournalsList.addAll(journalsResponseModel.value.journals ?? []);
      log(trendingJournalsList.length.toString(), name: 'trending length');
      tredingVideoPlayerController.forEach((element) {
        if (element != null) {
          element.forEach((key, value) {
            value.dispose();
          });
        }
      });
      tredingVideoPlayerController.clear();
      for (int i = 0; i < trendingJournalsList.length; i++) {
        if (trendingJournalsList[i].mediaType == "video/mp4") {
          if (videoPlayerController.isEmpty) {
            videoIndex = i;
          }

          tredingVideoPlayerController.add({
            i: await VideoPlayerController.network(
                trendingJournalsList[i].mediaUrl!)
              ..initialize()
          });
        } else {
          tredingVideoPlayerController.add(null);
        }
      }
    } on Exception catch (e) {
      ErrorHandler.handleException(e.toString());
    }
    isTrendingLoading.value = false;
  }

  Future<void> playVideo(int index) async {
    isPlayingMyPostVideo = false;

    isPlayingTrendingPostVideo = false;
    if (videoIndex != index) {
      videoPlayerController[index][index]!.pause();
    }
    if (videoPlayerController[index][index]!.value.isPlaying) {
      videoPlayerController[index][index]!.pause();
    } else {
      if (!isPlayingMyPostVideo && !isPlayingTrendingPostVideo) {
        videoPlayerController[index][index]!.play();
        videoIndex = index;
      }
    }
  }

  Future<void> playMyPostVideo(int index) async {
    isPlayingMyPostVideo = true;

    if (myVideoIndex != index) {
      myVideoPlayerControllers[index][index]!.pause();
    }
    if (myVideoPlayerControllers[index][index]!.value.isPlaying) {
      myVideoPlayerControllers[index][index]!.pause();
    } else {
      myVideoPlayerControllers[index][index]!.play();
      myVideoIndex = index;
    }
  }

  Future<void> playTrendingPostVideo(int index) async {
    isPlayingTrendingPostVideo = true;
    if (tredingVideoPlayerController[index] != null) {
      if (trendingVideoIndex != index) {
        tredingVideoPlayerController[index]![index]!.pause();
      }
      if (tredingVideoPlayerController[index]![index]!.value.isPlaying) {
        tredingVideoPlayerController[index]![index]!.pause();
      } else {
        tredingVideoPlayerController[index]![index]!.play();
        trendingVideoIndex = index;
      }
    }
  }

  Future<Map<String, dynamic>> getAnnouncement() async {
    Map<String, dynamic> map = {};
    await Network.makeGetRequestWithToken(
            "${APIConstants.api}/api/v1/popup-announcement")
        .then((value) {
      map = {
        //"mediaType": value['announcementList']['mediaType'],
        "media": value['announcementList'].isEmpty
            ? ''
            : value['announcementList'][0]['announcementMedia'],
        "redirectTo": value['announcementList'].isEmpty
            ? ""
            : value['announcementList'][0]['redirectTo'],
        "redirectKey": value['announcementList'].isEmpty
            ? ""
            : value['announcementList'][0]['redirectKey'],
      };
    });
    return map;
  }

  Future<void> getHeaderAnnounce() async {
    log('it ran', name: "announcementMedia");
    await Network.makeGetRequestWithToken(
            "${APIConstants.api}/api/v1/header-announcement")
        .then((value) {
      log(value.toString(), name: "announcementMedia");
      announcementData.value = value['announcementList'].isEmpty
          ? ''
          : value['announcementList'][0]['announcementMedia'];
    });
  }

  Future<void> getUsersLikedPost(String postId, int pageNo) async {
    isLikedUserListLoading.value = true;
    try {
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/like?id=${postId}&pageNumber=$pageNo");

      likedUserList.value = LikedUsersListModel.fromJson(map);
    } on Exception catch (e) {
      print(e);
    }
    isLikedUserListLoading.value = false;
  }

  @override
  void onInit() {
    getAllJournals(1);
    getTrendingJournals();
    super.onInit();
  }

  void hidePost({required String journalId}) {
    Network.makeHttpPostRequestWithToken(
        url: "${APIConstants.api}/api/hide-post?journalId=$journalId",
        body: {});
  }
}
