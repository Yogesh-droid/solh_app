import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solh/controllers/journals/journal_page_controller.dart';
import 'package:solh/model/journals/journals_response_model.dart';
import 'package:solh/services/network/network.dart';
import 'package:video_player/video_player.dart';

class MyJournalsBloc {
  final _myJournalController = PublishSubject<List<Journals?>>();
  final _moreLoader = PublishSubject<bool>();
  JournalPageController _journalPageController = Get.find();
  int? nextPage = 1;
  List<Journals?> _journalsList = <Journals?>[];
  int _currentPage = 1;
  // int _endPageLimit = 1;
  int _numberOfPosts = 0;
  bool isFetchingPost = false;
  bool isFetchingMore = false;

  int numberOfPosts() {
    return _numberOfPosts;
  }

  Stream<List<Journals?>> get journalsStateStream =>
      _myJournalController.stream;

  Stream<bool>? get moreLoaderStream => _moreLoader.stream;

  Future<List<Journals?>> fetchDetailsFirstTime(String? sId) async {
    print("getting my journals for the first time...");

    _currentPage = 1;
    // try {
    if (nextPage == 1) {
      isFetchingPost = true;
    } else {
      isFetchingMore = true;
      _moreLoader.sink.add(true);
    }
    Map<String, dynamic> apiResponse = await Network.makeGetRequestWithToken(
        "${APIConstants.api}/api/v1/get-my-journal?pageNumber=$nextPage");

    List<Journals> _journals = <Journals>[];
    nextPage = apiResponse['data']["next"] != null
        ? apiResponse['data']["next"]['pageNumber']
        : _currentPage;
    JournalsResponseModel _journalsResponseModel =
        JournalsResponseModel.fromJson(apiResponse['data']);

    print('Journals no null ${_journalsResponseModel.journals!.length}');

    if (_journalsResponseModel.journals != null) {
      print('Journals no null ${_journalsResponseModel.journals!.length}');
      _journals = _journalsResponseModel.journals!;
      isFetchingPost = false;
      _moreLoader.sink.add(false);
      _myJournalController.sink.add(_journals);
    }

    _journalPageController.myVideoPlayerControllers.value.forEach((element) {
      if (element != null) {
        element.forEach((key, value) {
          value.dispose();
        });
      }
    });
    _journalPageController.myVideoPlayerControllers.value.clear();
    for (int i = 0; i < _journals.length; i++) {
      if (_journals[i].mediaType == "video/mp4") {
        if (_journalPageController.myVideoPlayerControllers.value.isEmpty) {
          _journalPageController.myVideoIndex = i;
        }
        VideoPlayerController vc =
            VideoPlayerController.network(_journals[i].mediaUrl!);
        _journalPageController.myVideoPlayerControllers.value
            .add({i: vc..initialize()});
      } else {
        _journalPageController.myVideoPlayerControllers.value.add({});
      }
    }
    print('length of video player controller: ' +
        _journalPageController.myVideoPlayerControllers.value.length
            .toString());

    return _journals;
    // } catch (error) {
    //   throw error;
    // }
  }

  /* Future<List<Journals?>> _fetchDetailsNextPage(String? sId) async {
    print("getting my journals for the first time...");

    _currentPage = 1;
    // try {
    isFetchingMore.value = true;
    Map<String, dynamic> apiResponse = await Network.makeGetRequestWithToken(
        "${APIConstants.api}/api/v1/get-my-journal?pageNumber=$nextPage");

    List<Journals> _journals = <Journals>[];
    nextPage = apiResponse['data']["next"] != null
        ? apiResponse['data']["next"]['pageNumber']
        : _currentPage;
    print(apiResponse['data']);

    JournalsResponseModel _journalsResponseModel =
        JournalsResponseModel.fromJson(apiResponse['data']);

    print('Journals no null ${_journalsResponseModel.journals!.length}');

    if (_journalsResponseModel.journals != null) {
      print('Journals no null ${_journalsResponseModel.journals!.length}');
      _journals = _journalsResponseModel.journals!;
      isFetchingMore.value = false;
      _myJournalController.sink.add(_journals);
    }

    _journalPageController.myVideoPlayerControllers.value.forEach((element) {
      if (element != null) {
        element.forEach((key, value) {
          value.dispose();
        });
      }
    });
    _journalPageController.myVideoPlayerControllers.value.clear();
    for (int i = 0; i < _journals.length; i++) {
      if (_journals[i].mediaType == "video/mp4") {
        if (_journalPageController.myVideoPlayerControllers.value.isEmpty) {
          _journalPageController.myVideoIndex = i;
        }

        _journalPageController.myVideoPlayerControllers.value.add({
          i: await VideoPlayerController.network(_journals[i].mediaUrl!)
            ..initialize()
        });
      } else {
        _journalPageController.myVideoPlayerControllers.value.add({});
      }
    }
    print('length of video player controller: ' +
        _journalPageController.myVideoPlayerControllers.value.length
            .toString());

    return _journals;
    // } catch (error) {
    //   throw error;
    // }
  } */

  // Future<List<Journals?>> _fetchDetailsNextPage(String? sId) async {
  //   print("getting journals for the next page...");
  //   try {
  //     Map<String, dynamic> apiResponse = await Network.makeGetRequestWithToken(
  //         "${APIConstants.api}/api/v1/get-my-journal?pageNumber=$nextPage");

  //     List<Journals> _journals = <Journals>[];
  //     for (var journal in apiResponse["journals"]) {
  //       _journals.add(Journals.fromJson(journal['data']));
  //     }
  //     return _journals;
  //   } catch (error) {
  //     _currentPage--;
  //     throw error;
  //   }
  // }

  Future getJournalsSnapshot(String? sId) async {
    _journalsList = [];
    await fetchDetailsFirstTime(sId).then((journals) {
      _journalsList.addAll(journals);
      print("journals fetched: " + journals.length.toString());
      _journalsList.forEach((journal) {
        print(journal!.postedBy!.name ?? '');
      });
      return _myJournalController.add(_journalsList);
    }).onError((error, stackTrace) =>
        _myJournalController.sink.addError(error.toString()));
  }

  Future getNextPageJournalsSnapshot(String? sId) async {
    print("fetching next page journals.............");
    _currentPage++;
    print(nextPage);
    if (_currentPage <= nextPage!) {
      await fetchDetailsFirstTime(sId).then((journals) {
        _journalsList.addAll(journals);
        return _myJournalController.add(_journalsList);
      }).onError((error, stackTrace) =>
          _myJournalController.sink.addError(error.toString()));
    } else {
      print(" end of Page  DB");
    }
  }
}

MyJournalsBloc myJournalsBloc = MyJournalsBloc();
