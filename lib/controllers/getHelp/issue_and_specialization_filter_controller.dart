import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';

import '../../model/get-help/Issue_and_specialization_filter_model.dart';

class IssueAndSpecializationFilterController extends GetxController {
  var isFiltersLoading = false.obs;

  var selectedIssue = ''.obs;
  var selectedSpeciality = ''.obs;
  var selectedCountry = ''.obs;

  var issueAndSpecializationFilterModel =
      IssueAndSpecializationFilterModel().obs;

  getIssueAndSpecializationFilter(String slug) async {
    isFiltersLoading(true);
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        APIConstants.api + '/api/issue-spl-app?name=$slug');
    print(map);
    if (map["success"] == true) {
      issueAndSpecializationFilterModel.value =
          IssueAndSpecializationFilterModel.fromJson(map);
      isFiltersLoading(false);
    } else {
      SolhSnackbar.error("Error", "Something went wrong");
    }
  }
}
