import 'package:solh/constants/api.dart';
import 'package:solh/model/doctor.dart';
import 'package:solh/model/journal.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solh/services/network/network.dart';

class DoctorsBloc {
  final _doctorController = PublishSubject<List<DoctorModel?>>();

  List<DoctorModel?> _doctorsList = <DoctorModel?>[];
  int _currentPage = 1;
  int _endPageLimit = 1;

  Stream<List<DoctorModel?>> get doctorsStateStream => _doctorController.stream;

  Future<List<JournalModel?>> _fetchDetailsFirstTime() async {
    print("getting doctors for the first time...");
    _currentPage = 1;
    try {
      Map<String, dynamic> apiResponse =
          await Network.makeHttpGetRequestWithToken(
              "${APIConstants.aws}/api/doctors");

      List<JournalModel> _journals = <JournalModel>[];
      print("total pages: " + apiResponse["totalPages"].toString());
      _endPageLimit = apiResponse["totalPages"];
      print("Number of pages: $_endPageLimit");
      for (var journal in apiResponse["doctorsList"]) {
        _journals.add(JournalModel.fromJson(journal));
      }
      return _journals;
    } catch (error) {
      throw error;
    }
  }

  Future<List<DoctorModel?>> _fetchDetailsNextPage() async {
    print("getting journals for the next page...");
    try {
      Map<String, dynamic> apiResponse =
          await Network.makeHttpGetRequestWithToken(
              "${APIConstants.aws}/api/doctors?page=$_currentPage");

      List<DoctorModel> _doctors = <DoctorModel>[];
      for (var journal in apiResponse["doctorsList"]) {
        _doctors.add(DoctorModel.fromJson(journal));
      }
      return _doctors;
    } catch (error) {
      _currentPage--;
      throw error;
    }
  }

  Future getDoctorsSnapshot() async {
    _doctorsList = [];
    int _currentPage = 1;
    await _fetchDetailsFirstTime().then((journals) {
      _doctorsList.addAll(_doctorsList);
      return _doctorController.add(_doctorsList);
    }).onError((error, stackTrace) =>
        _doctorController.sink.addError(error.toString()));
  }

  Future getNextPageJournalsSnapshot() async {
    print("fetching next page journals.............");
    _currentPage++;

    if (_currentPage <= _endPageLimit) {
      await _fetchDetailsNextPage().then((journals) {
        _doctorsList.addAll(journals);
        return _doctorController.add(_doctorsList);
      }).onError((error, stackTrace) =>
          _doctorController.sink.addError(error.toString()));
    } else {
      print(" end of Page  DB");
    }
  }
}

DoctorsBloc doctorsBlocNetwork = DoctorsBloc();
