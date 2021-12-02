import 'package:solh/constants/api.dart';
import 'package:solh/model/journal.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solh/services/network/network.dart';

class JournalsBloc {
  final _journalController = PublishSubject<List<JournalModel?>>();

  List<JournalModel?> _journalsList = <JournalModel?>[];
  int _currentPage = 1;
  int _endPageLimit = 1;

  Stream<List<JournalModel?>> get journalsStateStream =>
      _journalController.stream;

  Future<List<JournalModel?>> _fetchDetailsFirstTime() async {
    print("getting journals for the first time...");
    try {
      Map<String, dynamic> apiResponse = await Network.makeHttpGetRequest(
          "${APIConstants.aws}/api/get-journals");
      // print("api response of journals: " +
      //     apiResponse["body"]["journals"].toString());
      List<JournalModel> _journals = <JournalModel>[];
      print("total pages: " + apiResponse["body"]["totalPages"].toString());
      _endPageLimit = apiResponse["body"]["totalPages"];
      print("Number of pages: $_endPageLimit");
      for (var journal in apiResponse["body"]["journals"]) {
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
      Map<String, dynamic> apiResponse = await Network.makeHttpGetRequest(
          "${APIConstants.aws}/api/get-journals?page=$_currentPage");

      List<JournalModel> _journals = <JournalModel>[];
      for (var journal in apiResponse["body"]["journals"]) {
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
    int _currentPage = 1;
    await _fetchDetailsFirstTime().then((journals) {
      _journalsList.addAll(journals);
      return _journalController.add(_journalsList);
    }).onError((error, stackTrace) =>
        _journalController.sink.addError(error.toString()));
  }

  Future getNextPageJournalsSnapshot() async {
    print("fetching next page journals.............");
    _currentPage++;

    if (_currentPage < _endPageLimit) {
      await _fetchDetailsNextPage().then((journals) {
        _journalsList.addAll(journals);
        return _journalController.add(_journalsList);
      }).onError((error, stackTrace) =>
          _journalController.sink.addError(error.toString()));
    } else {
      print(" end of Page  DB");
    }
  }
}

JournalsBloc journalsBloc = JournalsBloc();
