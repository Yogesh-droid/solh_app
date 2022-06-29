import 'package:get/get.dart';
import '../../constants/api.dart';
import '../../model/get-help/get_issue_response_model.dart';
import '../../model/get-help/search_market_model.dart';
import '../../services/network/error_handling.dart';
import '../../services/network/network.dart';

class GetHelpController extends GetxController {
  var getIssueResponseModel = GetIssueResponseModel().obs;
  var issueList = [].obs;
  var topConsultantList = SearchMarketModel().obs;
  var getSpecializationModel = GetIssueResponseModel().obs;
  var isAllIssueShown = false.obs;

  void getIssueList() async {
    try {
      Map<String, dynamic> map =
          await Network.makeGetRequest("${APIConstants.api}/api/issue");

      print('issues $map');

      getIssueResponseModel.value = GetIssueResponseModel.fromJson(map);
      issueList.value = getIssueResponseModel.value.specializationList != null
          ? getIssueResponseModel.value.specializationList!.length > 8
              ? getIssueResponseModel.value.specializationList!.sublist(0, 8)
              : getIssueResponseModel.value.specializationList!
          : [];
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
      Map<String, dynamic> map = await Network.makeGetRequest(
          "${APIConstants.api}/api/get-app-specialization");

      getSpecializationModel.value = GetIssueResponseModel.fromJson(map);
    } on Exception catch (e) {
      ErrorHandler.handleException(e.toString());
    }
  }

  Future<void> getTopConsultant() async {
    try {
      Map<String, dynamic> map = await Network.makeGetRequest(
          "${APIConstants.api}/api/top-consultants");

      topConsultantList.value = SearchMarketModel.fromJson(map);
    } on Exception catch (e) {
      ErrorHandler.handleException(e.toString());
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getIssueList();
    getSpecializationList();
    getTopConsultant();
  }
}
