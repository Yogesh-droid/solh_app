import 'package:firebase_auth/firebase_auth.dart';
import 'package:solh/constants/api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solh/model/journals/journals_response_model.dart';
import 'package:solh/services/network/network.dart';

class MyJournalsBloc {
  final _myJournalController = PublishSubject<List<Journals?>>();

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
    Map<String, dynamic> apiResponse = await Network.makeHttpGetRequestWithToken(
        "${APIConstants.api}/api/user-journal/${FirebaseAuth.instance.currentUser!.uid}");
    print(
        'sdklckldmcklmsdklcmsdklmcklsdmcdklsmcsdklmcklsdmvklmdskvdsklvmdklmvkldfl;v,dflmvfmvkdfm' +
            apiResponse['journals'].length.toString());

    List<Journals> _journals = <Journals>[];

    _numberOfPosts = apiResponse["totalJournals"];

    print("total pages: " + apiResponse["totalPages"].toString());

    _endPageLimit = apiResponse["totalPages"];

    print("Number of pages: $_endPageLimit");

    //print('journals are ${JournalModel.fromJson(apiResponse["journals"])}');

    for (var journal in apiResponse["journals"]) {
      print("kldsm");
      _journals.add(Journals.fromJson(journal));
    }
    print("Number of journals: ${_journals.length}");
    print("Number of posts: $_numberOfPosts");

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
