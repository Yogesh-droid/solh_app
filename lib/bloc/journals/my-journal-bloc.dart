import 'package:firebase_auth/firebase_auth.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/journal.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solh/services/network/network.dart';

class MyJournalsBloc {
  final _myJournalController = PublishSubject<List<JournalModel?>>();

  List<JournalModel?> _journalsList = <JournalModel?>[];
  int _currentPage = 1;
  int _endPageLimit = 1;
  int _numberOfPosts = 0;

  int numberOfPosts() {
    return _numberOfPosts;
  }

  Stream<List<JournalModel?>> get journalsStateStream =>
      _myJournalController.stream;

  Future<List<JournalModel?>> _fetchDetailsFirstTime() async {
    print("getting my journals for the first time...");

    _currentPage = 1;
    try {
      Map<String, dynamic> apiResponse = await Network.makeHttpGetRequestWithToken(
          "${APIConstants.api}/api/user-journal/${FirebaseAuth.instance.currentUser!.uid}");

      List<JournalModel> _journals = <JournalModel>[];

      _numberOfPosts = apiResponse["totalJournals"];

      print("total pages: " + apiResponse["totalPages"].toString());

      _endPageLimit = apiResponse["totalPages"];

      print("Number of pages: $_endPageLimit");

      for (var journal in apiResponse["journals"]) {
        _journals.add(JournalModel.fromJson(journal));
      }

      return _journals;
    } catch (error) {
      throw error;
    }
  }

  Future<List<JournalModel?>> _fetchDetailsNextPage() async {
    print("getting journals for the next page...");
    try {
      Map<String, dynamic> apiResponse = await Network.makeHttpGetRequestWithToken(
          "${APIConstants.api}/api/user-journal/${FirebaseAuth.instance.currentUser!.uid}?page=$_currentPage");

      List<JournalModel> _journals = <JournalModel>[];
      for (var journal in apiResponse["journals"]) {
        _journals.add(JournalModel.fromJson(journal));
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
