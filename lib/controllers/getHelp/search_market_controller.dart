import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/get-help/search_market_model.dart';
import 'package:solh/services/network/network.dart';

class SearchMarketController extends GetxController {
  var isLoading = false.obs;
  var suggestionList = [].obs;
  var searchMarketModel = SearchMarketModel().obs;
  var issueModel = SearchMarketModel().obs;
  var isSearchingDoctors = false.obs;
  String country = "IN";

  Future<void> getSearchResults(String searchText) async {
    isLoading.value = true;
    Map<String, dynamic> map = await Network.makeGetRequest(APIConstants.api +
        '/api/v1/get-help?text=$searchText&country=$country');

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

  Future<void> getSpecializationList(String slug, {String? c}) async {
    isSearchingDoctors.value = true;
    String url;
    if (c != null && c.isNotEmpty) {
      url =
          APIConstants.api + '/api/v1/get-help?specialization=$slug&country=$c';
    } else {
      url = APIConstants.api +
          '/api/v1/get-help?specialization=$slug&country=$country';
    }
    Map<String, dynamic> map = await Network.makeGetRequest(url);

    issueModel.value = SearchMarketModel.fromJson(map);
    isSearchingDoctors.value = false;
  }

  Future<void> getTopConsultants({String? c}) async {
    isSearchingDoctors.value = true;
    String url;
    if (c != null && c.isNotEmpty) {
      url = APIConstants.api + '/api/top-consultants?country=$c';
    } else {
      http: //13.126.1.127/api/top-consultants?country=AU
      url = APIConstants.api + '/api/top-consultants?country=$country';
    }
    Map<String, dynamic> map = await Network.makeGetRequest(url);

    issueModel.value = SearchMarketModel.fromJson(map);
    isSearchingDoctors.value = false;
  }

  Future<void> getIssueList(String slug, {String? c}) async {
    isSearchingDoctors.value = true;
    String url;
    if (c != null && c.isNotEmpty) {
      url =
          APIConstants.api + '/api/v1/get-help?specialization=$slug&country=$c';
    } else {
      url = APIConstants.api +
          '/api/v1/get-help?specialization=$slug&country=$country';
    }
    Map<String, dynamic> map = await Network.makeGetRequest(url);

    issueModel.value = SearchMarketModel.fromJson(map);
    isSearchingDoctors.value = false;
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
