import 'package:get/get.dart';
import '../../constants/api.dart';
import '../../model/get-help/get_issue_response_model.dart';
import '../../services/network/error_handling.dart';
import '../../services/network/network.dart';

class GetHelpController extends GetxController {
  var getIssueResponseModel = GetIssueResponseModel().obs;
  var getSpecializationModel = GetIssueResponseModel().obs;

  void getIssueList() async {
    try {
      Map<String, dynamic> map =
          await Network.makeGetRequest("${APIConstants.api}/api/issues");

      getIssueResponseModel.value = GetIssueResponseModel.fromJson(map);
    } on Exception catch (e) {
      ErrorHandler.handleException(e.toString());
    }
  }

  void getSpecializationList() async {
    try {
      Map<String, dynamic> map = await Network.makeGetRequest(
          "${APIConstants.api}/api/specialization");

      getSpecializationModel.value = GetIssueResponseModel.fromJson(map);
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
  }
}
