import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solh/model/get-help/counsellors_country_model..dart';
import 'package:solh/model/get-help/solh_volunteer_model.dart';
import 'package:solh/widgets_constants/constants/locale.dart';
import '../../constants/api.dart';
import '../../model/get-help/get_issue_response_model.dart';
import '../../model/get-help/search_market_model.dart';
import '../../services/network/error_handling.dart';
import '../../services/network/network.dart';

class GetHelpController extends GetxController {
  var getIssueResponseModel = GetIssueResponseModel().obs;
  var issueList = [].obs;
  var issueList1 = [].obs;
  var issueList2 = [].obs;
  var topConsultantList = SearchMarketModel().obs;
  var solhVolunteerList = SolhVolunteerModel().obs;
  var getSpecializationModel = GetIssueResponseModel().obs;
  var getAlliedTherapyModel = GetIssueResponseModel().obs;
  var getAlliedTherapyModelMore = GetIssueResponseModel().obs;
  var isAlliedShown = false.obs;
  var isAlliedShownAll = false.obs;
  var isAllIssueShown = false.obs;
  var counsellorsCountryModel = CounsellorsCountryModel().obs;
  var isCountryLoading = false.obs;

  void getIssueList() async {
    try {
      Map<String, dynamic> map = await Network.makeGetRequest(
          "${APIConstants.api}/api/issue",
          {"Accept-Language": AppLocale.appLocale.languageCode});

      print('issues $map');
      getIssueResponseModel.value = GetIssueResponseModel.fromJson(map);
      // issueList.value = getSpecializationModel.value.specializationList != null
      //     ? getIssueResponseModel.value.specializationList!
      //     : [];
      issueList.value = getIssueResponseModel.value.specializationList != null
          ? getIssueResponseModel.value.specializationList!.length > 8
              ? getIssueResponseModel.value.specializationList!.sublist(0, 8)
              : getIssueResponseModel.value.specializationList!
          : [];
      /*  if (getIssueResponseModel.value.specializationList != null) {
        int val = getIssueResponseModel.value.specializationList!.length ~/ 3;
        issueList.value =
            getIssueResponseModel.value.specializationList!.take(val).toList();
        issueList1.value = getIssueResponseModel.value.specializationList!
            .skip(val)
            .take(val)
            .toList();
        issueList2.value = getIssueResponseModel.value.specializationList!
            .skip(val + val)
            .take(val * 3)
            .toList();
      } */
    } on Exception catch (e) {
      ErrorHandler.handleException(e.toString());
    }
  }

  void showAllIssues() {
    if (getIssueResponseModel.value.specializationList != null) {
      issueList.value = getIssueResponseModel.value.specializationList!;
    }
  }

  void showLessIssues() {
    if (getIssueResponseModel.value.specializationList != null) {
      issueList.value =
          getIssueResponseModel.value.specializationList!.length > 8
              ? getIssueResponseModel.value.specializationList!.sublist(0, 8)
              : getIssueResponseModel.value.specializationList!;
    }
  }

  void getSpecializationList() async {
    try {
      ///   Pass 111 as query to get specialization only and 222 to get allied therapy  ///
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        "${APIConstants.api}/api/v1/get-app-specialization?parent=111",
      );

      getSpecializationModel.value = GetIssueResponseModel.fromJson(map);
    } on Exception catch (e) {
      ErrorHandler.handleException(e.toString());
    }
  }

  void getAlliedTherapyList() async {
    try {
      ///   Pass 111 as query to get specialization only and 222 to get allied therapy  ///
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        "${APIConstants.api}/api/v1/get-app-specialization?parent=222",
      );
      if (map['success']) {
        isAlliedShown.value = true;
      }

      getAlliedTherapyModel.value = GetIssueResponseModel.fromJson(map);
    } on Exception catch (e) {
      ErrorHandler.handleException(e.toString());
    }
  }

  void getAlliedTherapyListMore() async {
    try {
      ///   Pass 111 as query to get specialization only and 222 to get allied therapy  ///
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/get-app-specialization-all?parent=222");
      getAlliedTherapyModelMore.value = GetIssueResponseModel.fromJson(map);
      print(map);
    } on Exception catch (e) {
      ErrorHandler.handleException(e.toString());
    }
  }

  Future<void> getTopConsultant() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? country = sharedPreferences.getString('userCountry') ?? "IN";
    try {
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/top-consultants?country=$country");

      topConsultantList.value = SearchMarketModel.fromJson(map);
    } on Exception catch (e) {
      ErrorHandler.handleException(e.toString());
    }
  }

  Future<void> getSolhVolunteerList() async {
    print('getSolhVolunteerList');
    try {
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/volunteers");
      print('getSolhVolunteerList $map');
      solhVolunteerList.value = SolhVolunteerModel.fromJson(map);
    } on Exception catch (e) {
      ErrorHandler.handleException(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getIssueList();
    getSpecializationList();
    getAlliedTherapyList();
    getTopConsultant();
    getSolhVolunteerList();
    getCountryList();
  }

  Future<void> getCountryList() async {
    isCountryLoading.value = true;
    try {
      Map<String, dynamic> map = await Network.makeGetRequest(
          "${APIConstants.api}/api/provider-country");

      print('Cousellors Country Model $map');
      counsellorsCountryModel.value = CounsellorsCountryModel.fromJson(map);
    } on Exception catch (e) {
      ErrorHandler.handleException(e.toString());
    }
    isCountryLoading.value = false;
  }
}
