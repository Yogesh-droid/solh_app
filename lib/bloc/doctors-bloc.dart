import 'package:solh/constants/api.dart';
import 'package:solh/model/doctor.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solh/services/network/network.dart';

class DoctorsBloc {
  final _doctorController = PublishSubject<List<DoctorModel?>>();

  List<DoctorModel?> _doctorsList = <DoctorModel?>[];
  int _currentPage = 1;
  int _endPageLimit = 1;

  Stream<List<DoctorModel?>> get doctorsStateStream => _doctorController.stream;

  Future<List<DoctorModel?>> _fetchDetailsFirstTime() async {
    print("getting doctors for the first time...");
    _currentPage = 1;
    try {
      Map<String, dynamic> apiResponse =
          await Network.makeHttpGetRequest(
              "${APIConstants.aws}/api/doctors");

      List<DoctorModel> _doctors = <DoctorModel>[];

      print("total pages: " + apiResponse["totalPages"].toString());

      _endPageLimit = apiResponse["totalPages"];
      
      print("Number of pages: $_endPageLimit");
      
      for (var doctor in apiResponse["doctorsList"]) {
        print(doctor);
        _doctors.add(DoctorModel.fromJson(doctor));
      }
      return _doctors;
    } catch (error) {
      throw error;
    }
  }

  Future<List<DoctorModel?>> _fetchDetailsNextPage() async {
    print("getting doctors for the next page...");
    try {
      Map<String, dynamic> apiResponse =
          await Network.makeHttpGetRequest(
              "${APIConstants.aws}/api/doctors?page=$_currentPage");

      List<DoctorModel> _doctors = <DoctorModel>[];
      for (var doctor in apiResponse["doctorsList"]) {
        _doctors.add(DoctorModel.fromJson(doctor));
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
    await _fetchDetailsFirstTime().then((doctors) {
      _doctorsList.addAll(doctors);
      return _doctorController.add(_doctorsList);
    }).onError((error, stackTrace) =>
        _doctorController.sink.addError(error.toString()));
  }

  Future getNextPageDoctorsSnapshot() async {
    print("fetching next page doctors.............");
    _currentPage++;

    if (_currentPage <= _endPageLimit) {
      await _fetchDetailsNextPage().then((doctors) {
        _doctorsList.addAll(doctors);
        return _doctorController.add(_doctorsList);
      }).onError((error, stackTrace) =>
          _doctorController.sink.addError(error.toString()));
    } else {
      print(" end of Page  DB");
    }
  }
}

DoctorsBloc doctorsBlocNetwork = DoctorsBloc();
