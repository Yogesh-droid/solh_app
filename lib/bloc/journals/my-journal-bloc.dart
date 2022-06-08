import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solh/controllers/journals/journal_page_controller.dart';
import 'package:solh/model/journals/journals_response_model.dart';
import 'package:solh/services/network/network.dart';
import 'package:video_player/video_player.dart';

class MyJournalsBloc {
  final _myJournalController = PublishSubject<List<Journals?>>();
  JournalPageController _journalPageController = Get.find();

  List<Journals?> _journalsList = <Journals?>[];
  int _currentPage = 1;
  int _endPageLimit = 1;
  int _numberOfPosts = 0;

  int numberOfPosts() {
    return _numberOfPosts;
  }

  Stream<List<Journals?>> get journalsStateStream =>
      _myJournalController.stream;

  Future<List<Journals?>> _fetchDetailsFirstTime() async {
    print("getting my journals for the first time...");

    _currentPage = 1;
    // try {
    Map<String, dynamic> apiResponse =
        await Network.makeHttpGetRequestWithToken(
            "${APIConstants.api}/api/get-my-journal");

    List<Journals> _journals = <Journals>[];

    _numberOfPosts = apiResponse["totalJournals"];

    _endPageLimit = apiResponse["totalPages"];

    JournalsResponseModel _journalsResponseModel =
        JournalsResponseModel.fromJson(apiResponse);

    if (_journalsResponseModel.journals != null) {
      _journals = _journalsResponseModel.journals!;
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
          i: VideoPlayerController.network(_journals[i].mediaUrl!)..initialize()
        });
      } else {
        _journalPageController.myVideoPlayerControllers.value.add(null);
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

  Future<List<Journals?>> _fetchDetailsNextPage() async {
    print("getting journals for the next page...");
    try {
      Map<String, dynamic> apiResponse = await Network.makeHttpGetRequestWithToken(
          "${APIConstants.api}/api/user-journal/${FirebaseAuth.instance.currentUser!.uid}?page=$_currentPage");

      List<Journals> _journals = <Journals>[];
      for (var journal in apiResponse["journals"]) {
        _journals.add(Journals.fromJson(journal));
      }
      return _journals;
    } catch (error) {
      _currentPage--;
      throw error;
    }
  }

  Future getJournalsSnapshot() async {
    _journalsList = [];
    await _fetchDetailsFirstTime().then((journals) {
      _journalsList.addAll(journals);
      print("journals fetched: " + journals.length.toString());
      _journalsList.forEach((journal) {
        print(journal!.postedBy!.name ?? '');
      });
      return _myJournalController.add(_journalsList);
    }).onError((error, stackTrace) =>
        _myJournalController.sink.addError(error.toString()));
  }

  Future getNextPageJournalsSnapshot() async {
    print("fetching next page journals.............");
    _currentPage++;
    if (_currentPage <= _endPageLimit) {
      await _fetchDetailsNextPage().then((journals) {
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
