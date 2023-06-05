import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/get-help/search_market_model.dart';
import 'package:solh/services/network/network.dart';
import 'dart:developer';

class SearchMarketController extends GetxController {
  var isLoading = false.obs;
  var isLoadingMoreClinician = false.obs;
  var suggestionList = [].obs;
  var searchMarketModel = SearchMarketModel().obs;
  var issueModel = SearchMarketModel().obs;
  var isSearchingDoctors = false.obs;
  String country = "IN";
  String? defaultCountry;

  Future<void> getSearchResults(String searchText, {String? c}) async {
    isLoading.value = true;
    String url;
    if (c != null && c.isNotEmpty) {
      url = APIConstants.api + '/api/v1/get-help?text=$searchText&country=$c';
    } else {
      url = APIConstants.api +
          '/api/v1/get-help?text=$searchText&country=$country';
    }
    Map<String, dynamic> map = await Network.makeGetRequest(url);
    print("map $map");
    searchMarketModel.value = SearchMarketModel.fromJson(map);
    isLoading.value = false;
  }

  Future<void> getSuggestions(String searchText) async {
    isLoading.value = true;
    Map<String, dynamic> map = await Network.makeGetRequest(
        APIConstants.api + '/api/get-suggestion?text=$searchText');
    suggestionList.clear();

    if (map['suggestions'] != null) {
      suggestionList.value.addAll(map['suggestions']);
    }
    suggestionList.refresh();
    isLoading.value = false;
  }

  Future<void> getSpecializationList(String slug,
      {String? c, String issue = '', String? page}) async {
    isSearchingDoctors.value = true;
    log("it ran1");
    String url;
    if (c != null && c.isNotEmpty) {
      url = APIConstants.api +
          '/api/v2/get-help?specialization=$slug&country=$c$issue&page=$page';
    } else {
      url = APIConstants.api +
          '/api/v1/get-help?specialization=$slug&country=$country';
    }
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(url);

    issueModel.value = SearchMarketModel.fromJson(map);
    isSearchingDoctors.value = false;
  }

  Future<void> getTopConsultants({
    String? c,
    String issue = '',
  }) async {
    isSearchingDoctors.value = true;
    String url;
    if (c != null && c.isNotEmpty) {
      url = APIConstants.api + '/api/top-consultants?country=$c&issue=$issue';
    } else {
      url = APIConstants.api + '/api/top-consultants?country=$country';
    }
    Map<String, dynamic> map = await Network.makeGetRequest(url);

    issueModel.value = SearchMarketModel.fromJson(map);
    isSearchingDoctors.value = false;
  }

  Future<void> getIssueList(String slug,
      {String? c, String issue = '', required int page}) async {
    isLoading(true);
    try {
      log("it ran2 $page");
      page > 1 ? isLoadingMoreClinician(true) : isSearchingDoctors.value = true;
      String url;
      if (c != null && c.isNotEmpty) {
        url = APIConstants.api +
            '/api/v3/get-help?specialization=$slug&country=$c$issue&page=$page';
      } else {
        url = APIConstants.api +
            '/api/v3/get-help?specialization=$slug&country=$country$issue&page=$page';
      }
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(url);

      if (page == 1) {
        log("in if");
        issueModel.value = SearchMarketModel.fromJson(map);
      } else {
        issueModel.value.provider!
            .addAll(SearchMarketModel.fromJson(map).provider!.toList());

        issueModel.refresh();
      }

      page > 1
          ? isLoadingMoreClinician(false)
          : isSearchingDoctors.value = false;
      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw (e);
    }
  }

  @override
  void onInit() {
    getCountry();
    super.onInit();
  }

  Future<void> getCountry() async {
    print("*" * 30 + " getting country" + "%" * 30);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    country = sharedPreferences.getString('userCountry') ?? "IN";
  }
}
