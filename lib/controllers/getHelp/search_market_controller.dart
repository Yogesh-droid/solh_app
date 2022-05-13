import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/get-help/get_specialization_response_model.dart';
import 'package:solh/model/get-help/search_market_model.dart';
import 'package:solh/services/network/network.dart';

class SearchMarketController extends GetxController {
  var isLoading = false.obs;
  var suggestionList = [].obs;
  var searchMarketModel = SearchMarketModel().obs;
  var issueModel = SearchMarketModel().obs;

  Future<void> getSearchResults(String searchText) async {
    isLoading.value = true;
    Map<String, dynamic> map = await Network.makeGetRequest(
        APIConstants.api + '/api/get-help?text=$searchText');

    searchMarketModel.value = SearchMarketModel.fromJson(map);
    isLoading.value = false;
  }

  Future<void> getSuggestions(String searchText) async {
    isLoading.value = true;
    Map<String, dynamic> map = await Network.makeGetRequest(
        APIConstants.api + '/api/get-suggestion?text=$searchText');
    suggestionList.clear();

    suggestionList.value.addAll(map['suggestions']);
    suggestionList.refresh();
    isLoading.value = false;
  }

  Future<void> getSpecializationList(String slug) async {
    Map<String, dynamic> map = await Network.makeGetRequest(
        APIConstants.api + '/api/get-help?specialization=$slug');

    issueModel.value = SearchMarketModel.fromJson(map);
  }

  Future<void> getIssueList(String slug) async {
    Map<String, dynamic> map = await Network.makeGetRequest(
        APIConstants.api + '/api/get-help?issue=$slug');

    issueModel.value = SearchMarketModel.fromJson(map);
  }
}
